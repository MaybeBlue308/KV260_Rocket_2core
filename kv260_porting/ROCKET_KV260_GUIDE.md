# Hướng Dẫn Kiến Trúc & Vận Hành: Dual-Core Rocket Chip Trên AMD Kria KV260

Tài liệu này mô tả chi tiết:
1. Cách thiết kế và kết nối hệ thống trong Vivado Block Design (`rocket_kv260`).
2. Cách mở Vivado GUI để kiểm tra thiết kế, sơ đồ nguyên lý (Schematic) và kết quả tổng hợp.
3. Phân tích kết quả Synthesis và tài nguyên FPGA (LUT, BRAM, URAM, DSP).
4. Quy trình nạp phần mềm và khởi động SoC Rocket Chip từ Linux PS trên board KV260.

---

## 1. Tổng Quan Kiến Trúc & Sơ Đồ Kết Nối

Hệ thống ghép nối lõi xử lý ứng dụng **Zynq UltraScale+ MPSoC (PS)** và **SoC RISC-V Dual Rocket Core (PL)** thông qua giao tiếp bus AXI4 tốc độ cao, EMIO UART và EMIO GPIO nội chip.

### 1.1 Sơ đồ khối (Block Diagram)

```mermaid
flowchart TD
    subgraph PS ["Zynq UltraScale+ MPSoC (Processing System)"]
        pl_clk0["pl_clk0 (100 MHz)"]
        pl_resetn0["pl_resetn0 (Active-Low)"]
        HP0["S_AXI_HP0_FPD (DDR High 64-bit)"]
        LPD["S_AXI_LPD (QSPI Linear 64-bit)"]
        UART0["EMIO UART0 (Console)"]
        GPIO["EMIO GPIO[7:0] (Control & JTAG)"]
    end

    subgraph Interconnect ["Hạ tầng kết nối PL"]
        PSR["proc_sys_reset_0"]
        SMC0["smartconnect_0 (DRAM Interconnect)"]
        SMC1["smartconnect_1 (MMIO Interconnect)"]
    end

    subgraph Wrapper ["kv260_rocket_wrapper"]
        ChipTop["ChipTop (Dual Rocket RV64GC)
        - 2x Rocket Core (L1 I/D 32KB)
        - L2 Inclusive Cache (512KB)
        - Scratchpad RAM (512KB)
        - CLINT & PLIC
        - SiFive UART & SPI Cores"]
    end

    subgraph External ["PMOD Header J2 (Chân ngoài KV260)"]
        SPI0_DEV["SPI0: NOR Flash"]
        SPI1_DEV["SPI1: SD Card"]
    end

    pl_clk0 --> PSR
    pl_clk0 --> SMC0
    pl_clk0 --> SMC1
    pl_clk0 --> Wrapper
    pl_resetn0 --> PSR

    PSR -->|peripheral_aresetn| SMC0
    PSR -->|peripheral_aresetn| SMC1
    PSR -->|resetn| Wrapper

    Wrapper -->|m_axi_mem (Remapped 0x8_0000_0000)| SMC0 --> HP0
    Wrapper -->|m_axi_mmio (Identity 0xC000_0000)| SMC1 --> LPD

    UART0 <-->|uart_rxd / uart_txd| Wrapper
    GPIO <-->|ps_gpio_o[7:0] / ps_gpio_i[7:0]| Wrapper

    Wrapper -->|spi0_sck, cs, mosi, miso| SPI0_DEV
    Wrapper -->|spi1_sck, cs, mosi, miso| SPI1_DEV
```

---

### 1.2 Chi tiết kết nối chân & tín hiệu trong Block Design (`kv260_bd`)

| Tín hiệu nguồn | Tín hiệu đích | Mô tả chức năng |
|---|---|---|
| `zynq_ultra_ps_e_0/pl_clk0` | `proc_sys_reset_0/slowest_sync_clk`<br>`kv260_rocket_wrapper_0/clk`<br>`smartconnect_0/aclk`<br>`smartconnect_1/aclk`<br>`zynq_ultra_ps_e_0/saxihp0_fpd_aclk`<br>`zynq_ultra_ps_e_0/saxi_lpd_aclk` | Đồng hồ chính 100 MHz cung cấp cho toàn bộ hệ thống Rocket Chip và bus interconnect. |
| `zynq_ultra_ps_e_0/pl_resetn0` | `proc_sys_reset_0/ext_reset_in` | Tín hiệu reset cấp từ PS khi hệ thống khởi động. |
| `proc_sys_reset_0/peripheral_aresetn` | `kv260_rocket_wrapper_0/resetn`<br>`smartconnect_0/aresetn`<br>`smartconnect_1/aresetn` | Tín hiệu reset đồng bộ cho Rocket wrapper và các bộ ghép AXI SmartConnect. |
| `kv260_rocket_wrapper_0/m_axi_mem` | `smartconnect_0/S00_AXI` $\rightarrow$ `zynq_ultra_ps_e_0/S_AXI_HP0_FPD` | Bus AXI4 Master 64-bit truy cập DRAM chung của PS. Địa chỉ được dịch tự động lên vùng DDR_HIGH (`0x8_0000_0000`). |
| `kv260_rocket_wrapper_0/m_axi_mmio` | `smartconnect_1/S00_AXI` $\rightarrow$ `zynq_ultra_ps_e_0/S_AXI_LPD` | Bus AXI4 Master 64-bit truy cập không gian QSPI linear của PS (`0xC000_0000`). |
| `zynq_ultra_ps_e_0/emio_uart0_txd` | `kv260_rocket_wrapper_0/uart_rxd` | PS gửi ký tự tới UART Rocket. |
| `kv260_rocket_wrapper_0/uart_txd` | `zynq_ultra_ps_e_0/emio_uart0_rxd` | Rocket gửi ký tự về Linux PS (hiển thị console qua `/dev/ttyPS1`). |
| `zynq_ultra_ps_e_0/emio_gpio_o[7:0]` | `kv260_rocket_wrapper_0/ps_gpio_o[7:0]` | PS điều khiển tín hiệu reset, boot và JTAG cho Rocket (xem chi tiết mục 1.3). |
| `kv260_rocket_wrapper_0/ps_gpio_i[7:0]` | `zynq_ultra_ps_e_0/emio_gpio_i[7:0]` | Rocket trả về tín hiệu JTAG TDO về cho PS. |
| `kv260_rocket_wrapper_0/spi0_*` | External Ports (`spi0_sck`, `spi0_cs_n`, `spi0_mosi`, `spi0_miso`) | Nối ra chân PMOD Header J2 cho module SPI NOR Flash ngoài. |
| `kv260_rocket_wrapper_0/spi1_*` | External Ports (`spi1_sck`, `spi1_cs_n`, `spi1_mosi`, `spi1_miso`) | Nối ra chân PMOD Header J2 cho module MicroSD chế độ SPI ngoài. |

---

### 1.3 Bảng định tuyến EMIO GPIO (Điều khiển & JTAG từ Linux PS)

| EMIO Pin | Linux GPIO Line | Chiều | Tín hiệu | Chức năng |
|:---:|:---:|:---:|:---:|---|
| **0** | **78** | PS $\rightarrow$ Rocket | `rocket_reset` | `1` = Giữ Rocket ở trạng thái Reset; `0` = Cho phép chạy. |
| **1** | **79** | PS $\rightarrow$ Rocket | `custom_boot` | Cạnh lên `0 -> 1`: hart 0 nhảy trực tiếp tới địa chỉ `0x8000_0000`. |
| **2** | **80** | PS $\rightarrow$ Rocket | `jtag_TCK` | Clock JTAG bit-bang từ OpenOCD trên PS. |
| **3** | **81** | PS $\rightarrow$ Rocket | `jtag_TMS` | Test Mode Select cho JTAG TAP. |
| **4** | **82** | PS $\rightarrow$ Rocket | `jtag_TDI` | Test Data In cho JTAG TAP. |
| **5** | **83** | PS $\rightarrow$ Rocket | `jtag_reset` | Test Reset (TRST), thường giữ mức `0`. |
| **6** | **84** | Rocket $\rightarrow$ PS | `jtag_TDO` | Test Data Out trả về cho PS đọc. |

---

## 2. Bản Đồ Địa Chỉ Bộ Nhớ (Address Map)

| Vùng địa chỉ (Rocket nhìn) | Kích thước | Cổng Bus | Vùng địa chỉ (PS nhìn) | Chức năng / Ghi chú |
|---|---|---|---|---|
| `0x8000_0000 – 0xBFFF_FFFF` | 1 GiB | `m_axi_mem` (HP0) | `0x8_0000_0000 – 0x8_3FFF_FFFF` | **DRAM chính**: Remap lên vùng DDR_HIGH để tránh đụng độ bộ nhớ 1GB thấp của Linux PS. |
| `0xC000_0000 – 0xDFFF_FFFF` | 512 MiB | `m_axi_mmio` (LPD) | `0xC000_0000 – 0xDFFF_FFFF` | **Linear QSPI**: Đọc trực tiếp nội dung Flash trên SOM qua controller LQSPI của PS. |
| `0x1002_0000 – 0x1002_0FFF` | 4 KiB | TileLink nội bộ | Không qua PS | **UART SiFive**: Console nối vào EMIO UART0 của PS. |
| `0x1003_0000 – 0x1003_0FFF` | 4 KiB | TileLink nội bộ | Không qua PS | **SPI0 Controller**: Kết nối NOR Flash ngoài qua PMOD. |
| `0x1003_1000 – 0x1003_1FFF` | 4 KiB | TileLink nội bộ | Không qua PS | **SPI1 Controller**: Kết nối thẻ MicroSD ngoài qua PMOD. |
| `0x0800_0000 – 0x0807_FFFF` | 512 KiB | TileLink nội bộ | Không qua PS | **Scratchpad RAM**: Bộ nhớ on-chip BRAM trong PL. |
| `0x0200_0000 – 0x0200_FFFF` | 64 KiB | TileLink nội bộ | Không qua PS | **CLINT**: Bộ định thời thời gian thực (`mtime`, `mtimecmp`). |
| `0x0C00_0000 – 0x0FFF_FFFF` | 64 MiB | TileLink nội bộ | Không qua PS | **PLIC**: Bộ điều khiển ngắt ngoài mức nền tảng (Platform-Level Interrupt Controller). |

---

## 3. Hướng Dẫn Mở & Kiểm Tra Trên Vivado GUI

Project đã được tổ chức hoàn chỉnh chuẩn Vivado Project Mode.

### Các bước mở kiểm tra:
1. Mở công cụ **AMD Vivado 2024.2** từ Start Menu hoặc chạy lệnh:
   ```powershell
   & "D:\vivado\Vivado\2024.2\bin\vivado.bat" "D:\WORK_FOR_MONEY\kv260_porting\rocket_kv260\rocket_kv260.xpr"
   ```
2. **Kiểm tra Sơ đồ Block Design:**
   * Trong cửa sổ *Flow Navigator* (bên trái), chọn **IP Integrator** $\rightarrow$ **Open Block Design**.
   * Mở design `kv260_bd`. Bạn sẽ thấy sơ đồ kết nối hoàn chỉnh giữa khối `zynq_ultra_ps_e_0`, khối `kv260_rocket_wrapper_0`, 2 bộ `smartconnect` và các cổng PMOD.
3. **Kiểm tra Phân bổ Địa chỉ (Address Editor):**
   * Nhấp vào tab **Address Editor** trên thanh công cụ của Block Design.
   * Xác nhận:
     * `m_axi_mem`: Gán vào segment `HP0_DDR_HIGH` tại offset `0x8_0000_0000`, kích thước `1G`.
     * `m_axi_mmio`: Gán vào segment `LPD_QSPI` tại offset `0xC000_0000`, kích thước `512M`.
     * Mọi segment còn lại (`HP0_DDR_LOW`, `LPD_DDR_LOW`, `LPS_OCM`) đều đã ở trạng thái **Excluded**.
4. **Kiểm tra Kết quả Tổng hợp (Synthesis Results):**
   * Trong *Flow Navigator*, dưới mục **Synthesis**, nhấp vào **Open Synthesized Design**.
   * Bạn có thể xem:
     * **Schematic**: Sơ đồ mạch logic sau tổng hợp.
     * **Device View**: Bố trí logic trên chip FPGA Zynq UltraScale+ XCK26.
     * **Report Utilization**: Thống kê tài nguyên chi tiết.

---

## 4. Phân Tích Kết Quả Tổng Hợp (Synthesis Report)

Báo cáo tổng hợp chi tiết đã được tạo tại:  
[`D:\WORK_FOR_MONEY\kv260_porting\rocket_kv260\synth_utilization.rpt`](file:///D:/WORK_FOR_MONEY/kv260_porting/rocket_kv260/synth_utilization.rpt)

### Bảng tóm tắt tài nguyên:

| Loại tài nguyên | Sử dụng (Used) | Tổng số có trên chip (Available) | Tỷ lệ sử dụng (Util %) | Đánh giá |
|---|:---:|:---:|:---:|---|
| **CLB LUTs** | 109,141 | 117,120 | **93.19%** | Đạt ngưỡng logic cao (2 core Huge RV64GC với FPU + Bitmanip). Sau khi chạy `opt_design` / `place_design`, số LUT thường sẽ được tối ưu gọn hơn. |
| **CLB Registers (FF)** | 38,210 | 234,240 | **16.31%** | Rất thoải mái, còn dư nhiều Flip-Flop. |
| **DSPs (DSP48E2)** | 50 | 1,248 | **4.01%** | Rất thấp, tài nguyên tính toán DSP còn dồi dào. |
| **URAM (UltraRAM)** | 0 | 64 | **0.00%** | **Chưa sử dụng** (toàn bộ 64 khối URAM = 18 Mb còn nguyên). |
| **Block RAM (RAMB36)** | 240 | 144 | **166.67%** | **Vượt số lượng BRAM vật lý**. Do toàn bộ L2 cache 512KB + Scratchpad 512KB + L1 cache đang được map vào BRAM36. |

> [!IMPORTANT]
> **Giải pháp tối ưu tài nguyên trước khi chạy Implementation:**
> 1. **Chuyển Cache/Scratchpad sang URAM:** Kit KV260 có sẵn **64 khối URAM (288 Kbit/block = 2.25 MB bộ nhớ)** hoàn toàn chưa dùng đến. Chỉ cần đặt thuộc tính ép kiểu RAM sang URAM cho mảng nhớ L2 hoặc Scratchpad trong Vivado (`set_property RAM_STYLE ultra [get_cells ...]`) là số lượng BRAM sẽ giảm mạnh xuống dưới 100%.
> 2. **Hoặc giảm kích thước L2 / Scratchpad trong cấu hình Chisel:** Nếu không cần thiết, giảm L2 Cache xuống 256KB hoặc bỏ bớt Scratchpad 512KB (chỉ dùng DRAM của PS).

---

## 5. Hướng Dẫn Nạp Bitstream & Chạy Phần Mềm Trên KV260

### 5.1 Gán chân PMOD J2 & Chạy Implementation
Khi muốn xuất Bitstream nạp lên board thật:
1. Mở file ràng buộc chân PMOD, gán `PACKAGE_PIN` của Header J2 trên KV260 Carrier card cho các cổng:
   * Flash: `spi0_sck`, `spi0_cs_n`, `spi0_mosi`, `spi0_miso`
   * SD Card: `spi1_sck`, `spi1_cs_n`, `spi1_mosi`, `spi1_miso`
2. Trong Vivado, bấm **Run Implementation** $\rightarrow$ **Generate Bitstream**.
3. Chọn `File` $\rightarrow$ `Export` $\rightarrow$ `Export Hardware` (tích chọn *Include Bitstream*) để tạo file `.xsa`.

### 5.2 Nạp Bitstream từ Linux PS (Kria Ubuntu / PetaLinux)
Chuyển file bitstream sang định dạng binary `.bin` và nạp bằng tiện ích `xmutil`:
```bash
# Trên PC: Chuyển đổi định dạng bitstream
echo 'all:{ kv260_bd_wrapper.bit }' > bit.bif
bootgen -image bit.bif -arch zynqmp -process_bitstream bin

# Trên board KV260:
sudo mkdir -p /lib/firmware/xilinx/rocket
sudo cp kv260_bd_wrapper.bit.bin /lib/firmware/xilinx/rocket/rocket.bit.bin
sudo cp rocket.dtbo              /lib/firmware/xilinx/rocket/
echo '{ "shell_type": "XRT_FLAT", "num_slots": "1" }' | sudo tee /lib/firmware/xilinx/rocket/shell.json
sudo xmutil unloadapp
sudo xmutil loadapp rocket
```

### 5.3 Nạp Code & Khởi Động Rocket Chip
1. **Cấu hình RAM cho Linux PS:** Thêm tham số `mem=1G` vào `bootargs` của U-Boot để Linux PS chỉ sử dụng 1GB thấp (`0x0 – 0x3FFF_FFFF`), dành toàn bộ vùng `0x8_0000_0000` cho Rocket Chip.
2. **Biên dịch code RISC-V:**
   ```bash
   riscv64-unknown-elf-gcc -Tlink.ld -nostdlib prog.c -o prog.elf
   riscv64-unknown-elf-objcopy -O binary prog.elf prog.bin
   ```
3. **Nạp và khởi chạy trên KV260:**
   ```bash
   # 1. Giữ Rocket ở trạng thái Reset (GPIO line 78 = 1, custom_boot line 79 = 0)
   sudo gpioset -c gpiochip0 -z 78=1 79=0

   # 2. Chép binary vào địa chỉ RAM 0x8_0000_0000 của PS (= 0x8000_0000 của Rocket)
   sudo ./rocket_load.py prog.bin

   # 3. Nhả reset và kích hoạt boot (line 78 = 0, line 79 = 1) -> Rocket bắt đầu chạy!
   sudo gpioset -c gpiochip0 -z 78=0 79=1
   ```
4. **Mở Console UART của Rocket:**
   ```bash
   sudo picocom -b 115200 /dev/ttyPS1
   ```
   Bạn có thể tương tác trực tiếp với console của Rocket Chip qua kết nối SSH tới KV260 mà không cần bất kỳ dây USB-UART ngoài nào.

---

## 6. Kết Quả Hiện Thực Hóa (Implementation Results)

Thiết kế đã hoàn thành toàn bộ chu trình **Synthesis $\rightarrow$ Placement $\rightarrow$ Routing $\rightarrow$ Timing Signoff** trên Vivado 2024.2 với cấu hình chip AMD Xilinx Kria K26 SOM (`xck26-sfvc784-2LV-c`).

### 6.1 Bảng Tổng Kết Tài Nguyên Sau Routing (Resource Utilization)

| Loại Tài Nguyên | Sử Dụng (Used) | Khả Dụng (Available) | Tỷ Lệ (% Util) | Ghi Chú Kỹ Thuật |
| :--- | :---: | :---: | :---: | :--- |
| **CLB LUTs** | **77,791** | 117,120 | **66.42%** | Bao gồm logic dual-core, L2 cache, bus TileLink |
| ├─ *LUT as Logic* | 73,836 | 117,120 | 63.04% | Logic xử lý ALU, Control, Decode, Crossbar |
| └─ *LUT as Memory (LUTRAM)* | 3,955 | 57,600 | 6.87% | Hàng đợi TileLink Queues & Async FIFOs |
| **CLB Registers (FFs)** | **37,021** | 234,240 | **15.80%** | Pipeline registers, TileLink buffers, CSRs |
| **Block RAM Tiles (BRAM36)** | **88** | 144 | **61.11%** | 8 khối RAMB36 + 160 khối RAMB18 |
| **UltraRAM (URAM288)** | **32** | 64 | **50.00%** | **16 URAM** (Scratchpad 512KB) + **16 URAM** (L2 Cache 512KB) |
| **DSP Blocks (DSP48E2)** | **50** | 1,248 | **4.01%** | 25 DSPs cho mỗi bộ nhân/chia FPU Core 0 & Core 1 |
| **Clock Buffers (BUFG/PS)** | **4** | 144 | **2.78%** | `clk_pl_0` 100MHz, `clk_pl_1`, JTAG TCK & Reset gated clock |

### 6.2 Phân Bổ Tài Nguyên Theo Phân Cấp (Hierarchical Utilization)

| Module / Phân Cấp | LUTs | Flip-Flops | BRAM Tile | URAM | DSP48 | Chức Năng |
| :--- | :---: | :---: | :---: | :---: | :---: | :--- |
| **Core 0 (`tile_prci_domain`)** | ~29,500 | ~13,275 | 40 | 0 | 25 | Rocket Core 64-bit #0 + L1 I$/D$ (32KB/32KB) |
| **Core 1 (`tile_prci_domain_1`)** | ~29,500 | ~13,275 | 40 | 0 | 25 | Rocket Core 64-bit #1 + L1 I$/D$ (32KB/32KB) |
| **L2 Cache (`coh_wrapper / l2`)** | ~6,200 | ~2,820 | 4 | **16** | 0 | Bộ nhớ đệm dùng chung 512KB (4 banks x 4 URAM) |
| **Scratchpad (`bank / ram`)** | ~300 | ~120 | 0 | **16** | 0 | Bộ nhớ nội SRAM 512KB ánh xạ 16 URAM288 |
| **TileLink System Interconnect** | ~6,500 | ~3,500 | 4 | 0 | 0 | Bus Coherence, SystemBus, PeripheryBus, BootROM |
| **SmartConnect Interconnects** | ~2,800 | ~2,900 | 0 | 0 | 0 | PS HP0 DDR DRAM 64-bit & PS LPD MMIO 64-bit |

### 6.3 Báo Cáo Timing Signoff (100 MHz PL Clock)

Tất cả các ràng buộc thời gian (timing constraints) do người dùng và hệ thống quy định đều **ĐẠT (MET)** mà không có bất kỳ vi phạm nào:

- **Tần số xung nhịp PL Clock (`clk_pl_0`):** `100.0 MHz` ($T = 10.000\text{ ns}$)
- **Worst Negative Slack (WNS):** **`+0.287 ns`** (Slack dương, an toàn ở Slow Process Corner)
- **Total Negative Slack (TNS):** **`0.000 ns`** (0 / 114,478 endpoints vi phạm)
- **Worst Hold Slack (WHS):** **`+0.008 ns`** (Đạt ở Fast Corner)
- **Total Hold Slack (THS):** **`0.000 ns`** (0 / 114,478 endpoints vi phạm)
- **Worst Pulse Width Slack (WPWS):** **`+3.500 ns`** (0 vi phạm)
- **Trạng thái định tuyến (Routing Status):** **100% Routed**, 0 Unrouted Nets, 0 Overlaps.
