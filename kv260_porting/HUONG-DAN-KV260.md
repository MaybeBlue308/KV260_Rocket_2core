# Hướng Dẫn Vivado: Dual Rocket Trên KV260 (`KV260DualRocketConfig`)

Tài liệu mô tả mọi thứ cần cấu hình trong Vivado để ra bitstream KV260 chạy 2 core Rocket ở PL,
dùng chung DDR và QSPI của PS. Phần sinh RTL xem [`HUONG-DAN-CHAY-CONFIG.md`](HUONG-DAN-CHAY-CONFIG.md),
phần tham số Rocket xem [`HUONG-DAN-CUSTOM-ROCKET.md`](HUONG-DAN-CUSTOM-ROCKET.md).

> Các mục đánh dấu **[KIỂM TRA]** là chi tiết phụ thuộc phiên bản Vivado / image Kria mà tôi chưa
> xác minh được trên board thật — hãy đối chiếu với tài liệu AMD (UG1085, UG1087, UG1089) khi làm.

---

## 0. Tổng quan

### Sơ đồ kết nối

```
 ┌──────────────────────── Zynq UltraScale+ PS ─────────────────────────┐
 │  A53 Linux (1 GiB: 0x0000_0000-0x3FFF_FFFF)                            │
 │                                                                        │
 │  S_AXI_HP0_FPD ◄──── SmartConnect ◄── m_axi_mem  (40-bit, remapped) ─┐ │
 │  S_AXI_LPD     ◄──── SmartConnect ◄── m_axi_mmio (32-bit, identity) ─┤ │
 │  EMIO GPIO[7:0] ──── ps_gpio_o / ps_gpio_i (reset, boot, JTAG) ──────┤ │
 │  EMIO UART0     ──── uart_rxd / uart_txd ────────────────────────────┤ │
 │  pl_clk0 100 MHz, pl_resetn0 ────────────────────────────────────────┤ │
 └──────────────────────────────────────────────────────────────────────┼─┘
                                         ┌──────────────────────────────┴──┐
                                         │ kv260_rocket_wrapper (PL)       │
                                         │   └─ ChipTop: 2x Huge Rocket,   │
                                         │      L2 512 KiB, 100 MHz        │
                                         │ spi0_* ──► PMOD J2 ──► NOR flash│
                                         │ spi1_* ──► PMOD J2 ──► SD card  │
                                         └─────────────────────────────────┘
```

### Bản đồ địa chỉ

| Rocket nhìn thấy | Cổng | PS nhìn thấy | Ghi chú |
|---|---|---|---|
| `0x8000_0000 – 0xBFFF_FFFF` (1 GiB) | `m_axi_mem` → HP0 | `0x8_0000_0000 – 0x8_3FFF_FFFF` | Remap trong wrapper (`MEM_PS_BASE`), vùng DDR_HIGH |
| `0xC000_0000 – 0xDFFF_FFFF` | `m_axi_mmio` → LPD | `0xC000_0000 – 0xDFFF_FFFF` | Cửa sổ QSPI linear của PS, **chỉ đọc** |
| `0x1002_0000` | UART (PL) | – | Ra PS UART0 qua EMIO |
| `0x1003_0000` | SPI0 | – | NOR flash, single SPI, đọc/ghi |
| `0x1003_1000` | SPI1 | – | SD card chế độ SPI |
| `0x0800_0000` (512 KiB) | Scratchpad on-chip | – | BRAM/URAM trong PL |
| `0x0200_0000` | CLINT | – | `mtime` 1 MHz |

**Vì sao dùng DDR_HIGH (`0x8_0000_0000`) cho Rocket?** Đỉnh vùng DDR_LOW thường bị firmware PS dùng
(ví dụ U-Boot tự relocate lên đỉnh RAM thấp khi boot). Đặt 1 GiB của Rocket
ở đầu DDR_HIGH thì PS Linux chỉ cần `mem=1G` là dùng đúng 1 GiB thấp, không đụng vùng của Rocket.
Muốn dùng `0x4000_0000` thì đổi parameter `MEM_PS_BASE = 40'h00_4000_0000` (và tự đảm bảo firmware PS
không ghi vào vùng đó).

### Các file liên quan

| File | Vai trò |
|---|---|
| `generators/chipyard/src/main/scala/config/KV260RocketConfigs.scala` | Config `KV260DualRocketConfig` |
| `generators/chipyard/src/main/scala/config/DualRocketNorFlashConfig.scala` | IOBinder SPI (node `flash@0`, `mmc@0` trong DTS) |
| `fpga/kv260/rtl/kv260_rocket_wrapper.v` | Wrapper: remap DDR, map GPIO/JTAG, SPI single-mode, AXI chuẩn Xilinx |
| `fpga/kv260/tcl/add_rocket_sources.tcl` | Thêm toàn bộ RTL Chipyard + wrapper + XDC vào project |
| `fpga/kv260/constraints/kv260_rocket_pmod.xdc` | XDC mẫu cho PMOD (cần điền chân) |
| `fpga/kv260/openocd/kv260-rocket-ps-gpio.cfg` | OpenOCD chạy trên PS, JTAG bit-bang qua EMIO |
| `fpga/kv260/ps/rocket_load.py` | Chạy trên PS: chép image Rocket vào DDR |

---

## 1. Sinh RTL

```bash
cd ~/workspace/chipyard
source env.sh
export JAVA_TOOL_OPTIONS="-Xmx8G -Xss8M -Djava.io.tmpdir=/tmp/sbt-$USER"
make -C sims/verilator verilog CONFIG=KV260DualRocketConfig
```

Kết quả dùng cho Vivado (trong `sims/verilator/generated-src/chipyard.harness.TestHarness.KV260DualRocketConfig/`):

- `*.top.f` — danh sách file của `ChipTop` (~410 file `.sv`/`.v`).
- `gen-collateral/*.top.mems.v` — **các SRAM** (cache, L2, scratchpad). **Không** có trong `top.f`, phải thêm riêng
  (script Tcl ở mục 3 đã làm).
- `*.dts` — device tree của Rocket (dùng cho phần mềm Rocket).

Không dùng các file của TestHarness / mô phỏng (`TestDriver.v`, `SimDRAM`, `*.model.*`).

---

## 2. Tạo project

1. Vivado (bản có board file Kria, ví dụ 2022.2+) → **Create Project** → RTL Project, chưa add source.
2. **Boards** → chọn *Kria KV260 Vision AI Starter Kit SOM*, bấm **Connections** → nối với
   *KV260 carrier card*. (Part tương ứng: `xck26-sfvc784-2LV-c`.) **[KIỂM TRA]** tên board theo phiên bản.

---

## 3. Thêm nguồn RTL

Trong Tcl console của Vivado:

```tcl
set CHIPYARD_DIR /data/workspaces/khoant17/workspace/chipyard
set CONFIG KV260DualRocketConfig
source $CHIPYARD_DIR/fpga/kv260/tcl/add_rocket_sources.tcl
```

Script thêm: các file trong `top.f`, file `top.mems.v`, `kv260_rocket_wrapper.v`, XDC PMOD, và define `SYNTHESIS`
(để `plusarg_reader` bỏ code `$value$plusargs`). Các file `.sv` được đặt `file_type SystemVerilog`.

> Mỗi lần sinh lại RTL (đổi config) thì xoá các file cũ khỏi project rồi chạy lại script.

---

## 4. Block Design

**Create Block Design** (ví dụ tên `kv260_bd`).

### 4.1 Zynq UltraScale+ MPSoC

Add IP **Zynq UltraScale+ MPSoC** → **Run Block Automation** (Apply Board Preset) → mở IP và chỉnh:

| Mục | Cài đặt |
|---|---|
| **PS-PL Configuration → PS-PL Interfaces → Slave Interface → AXI HP → AXI HP0 FPD** | Bật, data width **64** |
| **PS-PL Configuration → PS-PL Interfaces → Slave Interface → AXI LPD** | Bật (`S_AXI_LPD`), data width 64 |
| **PS-PL Configuration → PS-PL Interfaces → Master Interface** | Có thể tắt `M_AXI_HPM0_FPD`/`HPM1_FPD`/`HPM0_LPD` nếu không dùng |
| **Clock Configuration → Output Clocks → PL Fabric Clocks → PL0** | Bật, **100 MHz** |
| **PS-PL Configuration → General → Fabric Reset Enable** | Bật, 1 reset (`pl_resetn0`) |
| **I/O Configuration → Low Speed → I/O Peripherals → UART → UART 0** | Bật, chọn **EMIO** (UART1 giữ nguyên MIO, là console của PS) **[KIỂM TRA]** preset KV260 dùng UART1 cho console |
| **I/O Configuration → Low Speed → I/O Peripherals → GPIO → GPIO EMIO** | Bật, width **8** |
| **I/O Configuration → Low Speed → Memory Interfaces → QSPI** | Giữ như preset (QSPI boot của SOM) |

Sau khi bấm OK, PS có thêm các chân: `S_AXI_HP0_FPD`, `S_AXI_LPD`, `saxihp0_fpd_aclk`, `saxi_lpd_aclk`,
`pl_clk0`, `pl_resetn0`, `UART_0` (EMIO), `GPIO_0` (EMIO).

### 4.2 Wrapper Rocket (module reference)

Chuột phải canvas → **Add Module** → chọn `kv260_rocket_wrapper`. Vivado tự nhận diện:
- 2 interface AXI4 master `m_axi_mem` (addr 40 bit) và `m_axi_mmio` (addr 32 bit), data 64 bit, ID 4 bit;
- clock `clk` (100 MHz, gắn với 2 interface trên), reset `resetn` (active-low).

Double-click module để xem/đổi parameter `MEM_PS_BASE` (mặc định `0x0800000000`).

> Wrapper là Verilog thuần, `ChipTop` bên dưới là SystemVerilog — module reference cho phép điều này.
> Nếu Vivado báo lỗi module reference với SystemVerilog **[KIỂM TRA]**: tạo HDL wrapper cho block design rồi
> instantiate `kv260_rocket_wrapper` ở một file top Verilog riêng, nối với các cổng AXI/clock được
> "Make External" từ block design.

### 4.3 Kết nối

Add thêm: 2 × **AXI SmartConnect** (1 slave, 1 master mỗi cái), 1 × **Processor System Reset**.

| Từ | Đến | Ghi chú |
|---|---|---|
| `zynq_ultra_ps_e_0/pl_clk0` | `kv260_rocket_wrapper_0/clk`, cả 2 SmartConnect `aclk`, `saxihp0_fpd_aclk`, `saxi_lpd_aclk`, `proc_sys_reset_0/slowest_sync_clk` | Một miền clock 100 MHz duy nhất |
| `zynq_ultra_ps_e_0/pl_resetn0` | `proc_sys_reset_0/ext_reset_in` | |
| `proc_sys_reset_0/peripheral_aresetn` | `kv260_rocket_wrapper_0/resetn`, 2 SmartConnect `aresetn` | |
| `kv260_rocket_wrapper_0/m_axi_mem` | `smartconnect_0/S00_AXI` → `M00_AXI` → `zynq_ultra_ps_e_0/S_AXI_HP0_FPD` | DDR |
| `kv260_rocket_wrapper_0/m_axi_mmio` | `smartconnect_1/S00_AXI` → `M00_AXI` → `zynq_ultra_ps_e_0/S_AXI_LPD` | QSPI linear |
| `zynq_ultra_ps_e_0/emio_gpio_o[7:0]` | `kv260_rocket_wrapper_0/ps_gpio_o[7:0]` | Mở rộng interface `GPIO_0` để thấy `emio_gpio_o/_i/_t` |
| `kv260_rocket_wrapper_0/ps_gpio_i[7:0]` | `zynq_ultra_ps_e_0/emio_gpio_i[7:0]` | `emio_gpio_t` để hở |
| `kv260_rocket_wrapper_0/uart_txd` | `zynq_ultra_ps_e_0/emio_uart0_rxd` | Mở rộng interface `UART_0` |
| `zynq_ultra_ps_e_0/emio_uart0_txd` | `kv260_rocket_wrapper_0/uart_rxd` | |
| `kv260_rocket_wrapper_0/spi0_*`, `spi1_*` | **Make External** | Tên cổng ngoài phải giữ đúng `spi0_sck`, `spi0_cs_n`, ... để khớp XDC |

Bảng bit EMIO GPIO (khớp với wrapper và cấu hình OpenOCD):

| EMIO pin | Line Linux | Hướng | Tín hiệu |
|---|---|---|---|
| 0 | 78 | PS → Rocket | Reset Rocket (1 = giữ reset) |
| 1 | 79 | PS → Rocket | `custom_boot` (lên 1 → hart 0 nhảy tới `0x8000_0000`) |
| 2 | 80 | PS → Rocket | JTAG TCK |
| 3 | 81 | PS → Rocket | JTAG TMS |
| 4 | 82 | PS → Rocket | JTAG TDI |
| 5 | 83 | PS → Rocket | JTAG reset (TRST, active-high, để 0) |
| 6 | 84 | Rocket → PS | JTAG TDO |

(ZynqMP: MIO là line 0–77, EMIO pin *k* là line 78 + *k*. Mỗi pin *k* là **một** line, nên o và i không dùng chung số pin.)

### 4.4 Address Editor

Mở tab **Address Editor** → **Assign All**, sau đó chỉnh lại cho đúng:

| Master (address space) | Slave segment | Offset | Range |
|---|---|---|---|
| `kv260_rocket_wrapper_0/m_axi_mem` | `zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH` | `0x8_0000_0000` | 2G (hoặc 1G) |
| `kv260_rocket_wrapper_0/m_axi_mmio` | `zynq_ultra_ps_e_0/SAXIGP6/LPD_QSPI` | `0xC000_0000` | 512M |

- **Exclude** mọi segment khác (`HP0_DDR_LOW`, `HP0_LPS_OCM`, `LPD_DDR_*`, ...) để Rocket không thể vô tình đi vào
  vùng của PS. **[KIỂM TRA]** tên segment chính xác theo phiên bản Vivado.
- Không cần remap trong Address Editor: SmartConnect không dịch địa chỉ, nên phần dịch
  `0x8000_0000 → 0x8_0000_0000` đã được làm trong wrapper.

### 4.5 Hoàn tất

**Validate Design** (F6) → **Generate Output Products** → chuột phải `kv260_bd` → **Create HDL Wrapper**
(let Vivado manage) → **Set as Top**.

---

## 5. Constraints

### 5.1 PMOD

KV260 chỉ có **một** PMOD (J2) với 8 chân tín hiệu: vừa đủ cho flash (4 chân) + SD (4 chân).
Vì vậy JTAG và UART đi qua PS (mục 4.3), không cần thêm module hay chân nào.

Mở `fpga/kv260/constraints/kv260_rocket_pmod.xdc` và thay các `<PMOD_PINx>` bằng `PACKAGE_PIN` thật từ XDC của
carrier card KV260 (AMD cung cấp; tên tín hiệu dạng `HDA*`/`PMOD*`). **Tôi không ghi sẵn số chân để tránh sai —
hãy lấy từ file XDC chính thức.**

- Flash: WP# và HOLD# phải được kéo lên mức 1 trên module flash (wrapper chạy single SPI: MOSI = DQ0, MISO = DQ1).
- SD: MISO có `PULLUP true`. Thẻ phải hỗ trợ chế độ SPI (thẻ SD/SDHC thông thường đều hỗ trợ).

### 5.2 Clock

- `pl_clk0` đã được IP PS tự constrain, Rocket chạy chung clock này nên **không** cần `create_clock` thêm.
- **JTAG TCK** đi từ EMIO GPIO và được Rocket dùng làm clock cho JTAG TAP. Thêm vào một file XDC:

```tcl
create_clock -name jtag_tck -period 1000.000 [get_pins -hierarchical -filter {NAME =~ *chiptop/jtag_TCK}]
set_clock_groups -asynchronous -group [get_clocks jtag_tck] -group [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ *zynq_ultra_ps_e_0/pl_clk0}]]
```

  (1000 ns = 1 MHz, đủ cho bit-bang GPIO.) Vivado sẽ tự chèn BUFG cho net này; nếu không, thêm
  `set_property CLOCK_BUFFER_TYPE BUFG [get_nets -of_objects [get_pins -hierarchical -filter {NAME =~ *chiptop/jtag_TCK}]]`.

---

## 6. Synthesis / Implementation / Bitstream

1. **Run Synthesis** → mở *Report Utilization*: kiểm tra L2 (`cc_banks_*`), L1 (`rockettile_*cache*`) và
   scratchpad (`split_mem_ext`) đã vào **BRAM/URAM**, không bị trải ra LUTRAM/FF.
2. **Run Implementation** → kiểm tra *Report Timing Summary*: WNS ≥ 0 ở 100 MHz.
3. **Generate Bitstream** → `File → Export → Export Hardware` (kèm bitstream) để có `.xsa` cho phần mềm PS.

Nếu không đạt timing / không đủ tài nguyên (2 core Huge có FPU + Zfh + bitmanip là khá nặng):

| Cách | Sửa ở |
|---|---|
| Giảm xuống 2 core Big (bỏ Zfh/bitmanip, L1 16 KiB) | `nHugeCores = 0, nBigCores = 2` trong `KV260RocketConfigs.scala` |
| Hạ tần số, ví dụ 75 MHz | `tileFreqMHz`/`busFreqMHz` = 75 **và** PL0 = 75 MHz, `FREQ_HZ` trong wrapper; `timebaseHz` phải chia hết (ví dụ `Some(1000000L)` vẫn được với 75 MHz) |
| Giảm L2 / bỏ scratchpad 512 KiB | `l2CapacityKB`, fragment `WithMbusScratchpad` |
| Bật tối ưu | Synthesis strategy `Flow_PerfOptimized_high`, Implementation `Performance_Explore` |

Đổi config xong thì chạy lại `make ... verilog` và mục 3.

---

## 7. Nạp bitstream lên KV260

Trên image Kria (Ubuntu hoặc PetaLinux), PL được nạp như một "accelerator app":

```bash
# trên PC: chuyển .bit sang .bit.bin
echo 'all:{ kv260_bd_wrapper.bit }' > bit.bif
bootgen -image bit.bif -arch zynqmp -process_bitstream bin

# trên KV260
sudo mkdir -p /lib/firmware/xilinx/rocket
sudo cp kv260_bd_wrapper.bit.bin  /lib/firmware/xilinx/rocket/rocket.bit.bin
sudo cp rocket.dtbo               /lib/firmware/xilinx/rocket/        # overlay, xem 8.2
echo '{ "shell_type": "XRT_FLAT", "num_slots": "1" }' | sudo tee /lib/firmware/xilinx/rocket/shell.json
sudo xmutil unloadapp
sudo xmutil loadapp rocket
```

**[KIỂM TRA]** quy trình theo phiên bản image Kria (UG1089). Hoặc dùng `fpgautil -b rocket.bit.bin -o rocket.dtbo`.

---

## 8. Phần mềm phía PS

### 8.1 Giới hạn bộ nhớ PS còn 1 GiB

Thêm `mem=1G` vào bootargs của kernel PS (PetaLinux: `CONFIG_SUBSYSTEM_BOOTARGS`; Ubuntu Kria: cấu hình
boot của U-Boot / extlinux). Linux sẽ chỉ dùng `0x0–0x3FFF_FFFF`; vùng `0x8_0000_0000` (Rocket) và
phần còn lại của DDR không bị đụng tới.

Cách khác: khai báo `reserved-memory` với `no-map` cho `0x8_0000_0000` kích thước `0x4000_0000`
trong device tree gốc của PS.

### 8.2 Device tree overlay (`rocket.dtbo`)

Tạo từ `.xsa` (`xsct` → `createdts`, hoặc `dtg`). Overlay cần tối thiểu:
- `fpga-full` / `firmware-name = "rocket.bit.bin"`;
- `&uart0 { status = "okay"; };` — để Linux PS có `/dev/ttyPS*` nối với UART của Rocket.

Không cần node nào cho GPIO EMIO (controller `zynqmp_gpio` có sẵn trong DT gốc).

### 8.3 QSPI linear

- Phần mềm PS phải chuyển controller QSPI sang **linear mode** (controller legacy LQSPI) trước khi Rocket đọc
  `0xC000_0000`. **[KIỂM TRA]** thanh ghi chọn controller và cấu hình linear mode trong UG1085/UG1087 (chương QSPI).
- Linux PS **không được** dùng driver QSPI cùng lúc (driver GQSPI đưa controller về generic mode → Rocket đọc
  ra dữ liệu sai). Tắt node QSPI trong DT của PS, hoặc không load driver.
- Flash QSPI trên SOM chứa boot firmware của KV260 — Rocket chỉ **đọc**; ghi sẽ trả lỗi bus.

### 8.4 Khởi động Rocket (không cần JTAG)

```bash
# trên PC: build chương trình liên kết ở 0x80000000, chuyển sang raw binary
riscv64-unknown-elf-objcopy -O binary prog.riscv prog.bin

# trên KV260 (libgpiod v2; với v1 bỏ "-c" và "-z": gpioset gpiochip0 78=1 79=0)
sudo gpioset -c gpiochip0 -z 78=1 79=0          # giữ Rocket ở reset, custom_boot = 0
sudo ./rocket_load.py prog.bin                   # chép vào PS 0x8_0000_0000 (= Rocket 0x8000_0000)
sudo gpioset -c gpiochip0 -z 78=0 79=1          # nhả reset, custom_boot = 1 -> Rocket chạy
```

(Kiểm tra số gpiochip bằng `gpiodetect`.) Khi `custom_boot` lên 1, phần cứng `CustomBootPin` ghi
`0x8000_0000` vào boot-address-reg và bật `msip` của hart 0; BootROM đánh thức các hart còn lại.

### 8.5 Console UART của Rocket

```bash
sudo picocom -b 115200 /dev/ttyPS1      # tên ttyPS* tương ứng UART0, xem dmesg / aliases trong DT
```

Có thể SSH vào KV260 từ PC rồi mở console này — **không cần module USB-UART ngoài**.

### 8.6 Debug JTAG qua PS (không cần JTAG adapter)

```bash
# trên KV260 (OpenOCD >= 0.12 có linuxgpiod)
sudo openocd -f fpga/kv260/openocd/kv260-rocket-ps-gpio.cfg
# từ PC hoặc ngay trên KV260
gdb-multiarch prog.riscv -ex "target extended-remote <ip-kv260>:3333"
```

Bit-bang GPIO chậm (vài trăm kHz) — đủ để debug và nạp chương trình nhỏ. Nạp image lớn (Linux) thì dùng
`rocket_load.py`, vì PS ghi thẳng vào DDR nhanh hơn rất nhiều.

---

## 9. Phần mềm phía Rocket

- DTS của Rocket: `sims/verilator/generated-src/chipyard.harness.TestHarness.KV260DualRocketConfig/*.dts`
  (cũng được nhúng sẵn trong BootROM): 2 hart, `timebase-frequency = 1000000`, RAM `0x8000_0000` 1 GiB,
  UART `0x10020000`, SPI `0x10030000` (`flash@0`), SPI `0x10031000` (`mmc@0`).
- **Không dùng HTIF**: các chương trình mẫu trong `tests/` in qua HTIF (`tohost`) — chỉ chạy trong mô phỏng.
  Trên FPGA phải in qua UART `0x10020000` (driver `sifive,uart0`).
- Linux trên Rocket: OpenSBI (`fw_payload`) + kernel + DTB ở trên, nạp vào `0x8000_0000` bằng `rocket_load.py`.
  Driver Linux có sẵn: `sifive,uart0`, `sifive,spi0` + `jedec,spi-nor`, `mmc-spi-slot`.

---

## 10. Checklist

- [ ] `make -C sims/verilator verilog CONFIG=KV260DualRocketConfig` thành công
- [ ] Project KV260 (board file + carrier connection), chạy `add_rocket_sources.tcl`
- [ ] PS: HP0 FPD 64-bit, S_AXI_LPD, PL0 = 100 MHz, pl_resetn0, UART0 EMIO, GPIO EMIO 8 bit
- [ ] Module `kv260_rocket_wrapper` + 2 SmartConnect + proc_sys_reset, nối đúng bảng 4.3
- [ ] Address Editor: `m_axi_mem → HP0_DDR_HIGH @ 0x8_0000_0000`, `m_axi_mmio → LPD_QSPI @ 0xC000_0000`, exclude phần còn lại
- [ ] `spi0_*`/`spi1_*` Make External, XDC đã điền chân PMOD thật, thêm constraint `jtag_tck`
- [ ] Utilization: SRAM vào BRAM/URAM; Timing: WNS ≥ 0 @ 100 MHz
- [ ] PS: `mem=1G`, overlay bật UART0, QSPI ở linear mode và Linux không dùng QSPI
- [ ] Nạp image bằng `rocket_load.py`, bật `custom_boot`, xem console qua `/dev/ttyPS*`
