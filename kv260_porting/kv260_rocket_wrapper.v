// -----------------------------------------------------------------------------
// KV260 wrapper around the Chipyard ChipTop of KV260DualRocketConfig.
//
//  - m_axi_mem  : Rocket DRAM (0x8000_0000..0xBFFF_FFFF) remapped to MEM_PS_BASE
//                 in the PS address space -> connect to S_AXI_HP0_FPD
//  - m_axi_mmio : Rocket MMIO window (0xC000_0000..0xDFFF_FFFF), identity mapped
//                 to the PS QSPI linear window -> connect to S_AXI_LPD
//  - ps_gpio_o/i: PS EMIO GPIO, used for reset, custom boot and bit-banged JTAG
//  - uart_*     : connect to PS UART0 over EMIO (or to PL pins)
//  - spi0_*     : single-SPI NOR flash, spi1_* : SD card in SPI mode (PMOD pins)
//
// Usable as a Vivado block-design module reference (top is plain Verilog,
// the Chipyard sources below it are SystemVerilog).
// -----------------------------------------------------------------------------
module kv260_rocket_wrapper #(
  // PS physical address of Rocket's 0x8000_0000. Default: start of DDR_HIGH.
  parameter [39:0] MEM_PS_BASE = 40'h08_0000_0000
) (
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
  (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF m_axi_mem:m_axi_mmio, ASSOCIATED_RESET resetn" *)
  input         clk,        // pl_clk0, 100 MHz
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 resetn RST" *)
  (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
  input         resetn,     // pl_resetn0 or proc_sys_reset peripheral_aresetn

  // ---------------- PS EMIO GPIO ----------------
  // ps_gpio_o[0] : Rocket reset (1 = hold in reset)
  // ps_gpio_o[1] : custom_boot  (rising to 1 makes hart 0 jump to 0x8000_0000)
  // ps_gpio_o[2] : JTAG TCK
  // ps_gpio_o[3] : JTAG TMS
  // ps_gpio_o[4] : JTAG TDI
  // ps_gpio_o[5] : JTAG reset (1 = reset the DTM, keep 0 normally)
  // ps_gpio_i[6] : JTAG TDO     (each EMIO pin k is one GPIO line: o[k]/i[k] share it)
  input  [7:0]  ps_gpio_o,
  output [7:0]  ps_gpio_i,

  // ---------------- UART ----------------
  output        uart_txd,   // -> PS emio_uart0_rxd
  input         uart_rxd,   // <- PS emio_uart0_txd

  // ---------------- SPI0: NOR flash (single SPI) ----------------
  output        spi0_sck,
  output        spi0_cs_n,
  output        spi0_mosi,
  input         spi0_miso,

  // ---------------- SPI1: SD card (SPI mode) ----------------
  output        spi1_sck,
  output        spi1_cs_n,
  output        spi1_mosi,
  input         spi1_miso,

  // ---------------- AXI4 master: DRAM -> PS DDR ----------------
  output [3:0]  m_axi_mem_awid,
  output [39:0] m_axi_mem_awaddr,
  output [7:0]  m_axi_mem_awlen,
  output [2:0]  m_axi_mem_awsize,
  output [1:0]  m_axi_mem_awburst,
  output        m_axi_mem_awlock,
  output [3:0]  m_axi_mem_awcache,
  output [2:0]  m_axi_mem_awprot,
  output [3:0]  m_axi_mem_awqos,
  output        m_axi_mem_awvalid,
  input         m_axi_mem_awready,
  output [63:0] m_axi_mem_wdata,
  output [7:0]  m_axi_mem_wstrb,
  output        m_axi_mem_wlast,
  output        m_axi_mem_wvalid,
  input         m_axi_mem_wready,
  input  [3:0]  m_axi_mem_bid,
  input  [1:0]  m_axi_mem_bresp,
  input         m_axi_mem_bvalid,
  output        m_axi_mem_bready,
  output [3:0]  m_axi_mem_arid,
  output [39:0] m_axi_mem_araddr,
  output [7:0]  m_axi_mem_arlen,
  output [2:0]  m_axi_mem_arsize,
  output [1:0]  m_axi_mem_arburst,
  output        m_axi_mem_arlock,
  output [3:0]  m_axi_mem_arcache,
  output [2:0]  m_axi_mem_arprot,
  output [3:0]  m_axi_mem_arqos,
  output        m_axi_mem_arvalid,
  input         m_axi_mem_arready,
  input  [3:0]  m_axi_mem_rid,
  input  [63:0] m_axi_mem_rdata,
  input  [1:0]  m_axi_mem_rresp,
  input         m_axi_mem_rlast,
  input         m_axi_mem_rvalid,
  output        m_axi_mem_rready,

  // ---------------- AXI4 master: MMIO -> PS QSPI linear ----------------
  output [3:0]  m_axi_mmio_awid,
  output [31:0] m_axi_mmio_awaddr,
  output [7:0]  m_axi_mmio_awlen,
  output [2:0]  m_axi_mmio_awsize,
  output [1:0]  m_axi_mmio_awburst,
  output        m_axi_mmio_awlock,
  output [3:0]  m_axi_mmio_awcache,
  output [2:0]  m_axi_mmio_awprot,
  output [3:0]  m_axi_mmio_awqos,
  output        m_axi_mmio_awvalid,
  input         m_axi_mmio_awready,
  output [63:0] m_axi_mmio_wdata,
  output [7:0]  m_axi_mmio_wstrb,
  output        m_axi_mmio_wlast,
  output        m_axi_mmio_wvalid,
  input         m_axi_mmio_wready,
  input  [3:0]  m_axi_mmio_bid,
  input  [1:0]  m_axi_mmio_bresp,
  input         m_axi_mmio_bvalid,
  output        m_axi_mmio_bready,
  output [3:0]  m_axi_mmio_arid,
  output [31:0] m_axi_mmio_araddr,
  output [7:0]  m_axi_mmio_arlen,
  output [2:0]  m_axi_mmio_arsize,
  output [1:0]  m_axi_mmio_arburst,
  output        m_axi_mmio_arlock,
  output [3:0]  m_axi_mmio_arcache,
  output [2:0]  m_axi_mmio_arprot,
  output [3:0]  m_axi_mmio_arqos,
  output        m_axi_mmio_arvalid,
  input         m_axi_mmio_arready,
  input  [3:0]  m_axi_mmio_rid,
  input  [63:0] m_axi_mmio_rdata,
  input  [1:0]  m_axi_mmio_rresp,
  input         m_axi_mmio_rlast,
  input         m_axi_mmio_rvalid,
  output        m_axi_mmio_rready
);

  // Rocket only issues 0x8000_0000..0xBFFF_FFFF on the memory port, so bits [29:0]
  // are the offset inside the 1 GiB region.
  wire [31:0] mem_awaddr_rocket;
  wire [31:0] mem_araddr_rocket;
  assign m_axi_mem_awaddr = MEM_PS_BASE + {10'd0, mem_awaddr_rocket[29:0]};
  assign m_axi_mem_araddr = MEM_PS_BASE + {10'd0, mem_araddr_rocket[29:0]};

  // Single-SPI mapping of the 4-bit SiFive SPI port: dq[0] = MOSI, dq[1] = MISO
  wire spi0_dq0_o, spi1_dq0_o;
  assign spi0_mosi = spi0_dq0_o;
  assign spi1_mosi = spi1_dq0_o;

  wire   jtag_tdo;
  assign ps_gpio_i = {1'b0, jtag_tdo, 6'd0};

  ChipTop chiptop (
    .clock_uncore                    (clk),
    .reset_io                        (~resetn | ps_gpio_o[0]),
    .clock_tap                       (),

    .custom_boot                     (ps_gpio_o[1]),
    .jtag_TCK                        (ps_gpio_o[2]),
    .jtag_TMS                        (ps_gpio_o[3]),
    .jtag_TDI                        (ps_gpio_o[4]),
    .jtag_reset                      (ps_gpio_o[5]),
    .jtag_TDO                        (jtag_tdo),

    .uart_0_txd                      (uart_txd),
    .uart_0_rxd                      (uart_rxd),

    .spi_0_sck                       (spi0_sck),
    .spi_0_cs_0                      (spi0_cs_n),
    .spi_0_dq_0_i                    (1'b0),
    .spi_0_dq_0_o                    (spi0_dq0_o),
    .spi_0_dq_0_ie                   (),
    .spi_0_dq_0_oe                   (),
    .spi_0_dq_1_i                    (spi0_miso),
    .spi_0_dq_1_o                    (),
    .spi_0_dq_1_ie                   (),
    .spi_0_dq_1_oe                   (),
    .spi_0_dq_2_i                    (1'b1),
    .spi_0_dq_2_o                    (),
    .spi_0_dq_2_ie                   (),
    .spi_0_dq_2_oe                   (),
    .spi_0_dq_3_i                    (1'b1),
    .spi_0_dq_3_o                    (),
    .spi_0_dq_3_ie                   (),
    .spi_0_dq_3_oe                   (),

    .spi_1_sck                       (spi1_sck),
    .spi_1_cs_0                      (spi1_cs_n),
    .spi_1_dq_0_i                    (1'b0),
    .spi_1_dq_0_o                    (spi1_dq0_o),
    .spi_1_dq_0_ie                   (),
    .spi_1_dq_0_oe                   (),
    .spi_1_dq_1_i                    (spi1_miso),
    .spi_1_dq_1_o                    (),
    .spi_1_dq_1_ie                   (),
    .spi_1_dq_1_oe                   (),
    .spi_1_dq_2_i                    (1'b1),
    .spi_1_dq_2_o                    (),
    .spi_1_dq_2_ie                   (),
    .spi_1_dq_2_oe                   (),
    .spi_1_dq_3_i                    (1'b1),
    .spi_1_dq_3_o                    (),
    .spi_1_dq_3_ie                   (),
    .spi_1_dq_3_oe                   (),

    .axi4_mem_0_clock                (),
    .axi4_mem_0_bits_aw_ready        (m_axi_mem_awready),
    .axi4_mem_0_bits_aw_valid        (m_axi_mem_awvalid),
    .axi4_mem_0_bits_aw_bits_id      (m_axi_mem_awid),
    .axi4_mem_0_bits_aw_bits_addr    (mem_awaddr_rocket),
    .axi4_mem_0_bits_aw_bits_len     (m_axi_mem_awlen),
    .axi4_mem_0_bits_aw_bits_size    (m_axi_mem_awsize),
    .axi4_mem_0_bits_aw_bits_burst   (m_axi_mem_awburst),
    .axi4_mem_0_bits_aw_bits_lock    (m_axi_mem_awlock),
    .axi4_mem_0_bits_aw_bits_cache   (m_axi_mem_awcache),
    .axi4_mem_0_bits_aw_bits_prot    (m_axi_mem_awprot),
    .axi4_mem_0_bits_aw_bits_qos     (m_axi_mem_awqos),
    .axi4_mem_0_bits_w_ready         (m_axi_mem_wready),
    .axi4_mem_0_bits_w_valid         (m_axi_mem_wvalid),
    .axi4_mem_0_bits_w_bits_data     (m_axi_mem_wdata),
    .axi4_mem_0_bits_w_bits_strb     (m_axi_mem_wstrb),
    .axi4_mem_0_bits_w_bits_last     (m_axi_mem_wlast),
    .axi4_mem_0_bits_b_ready         (m_axi_mem_bready),
    .axi4_mem_0_bits_b_valid         (m_axi_mem_bvalid),
    .axi4_mem_0_bits_b_bits_id       (m_axi_mem_bid),
    .axi4_mem_0_bits_b_bits_resp     (m_axi_mem_bresp),
    .axi4_mem_0_bits_ar_ready        (m_axi_mem_arready),
    .axi4_mem_0_bits_ar_valid        (m_axi_mem_arvalid),
    .axi4_mem_0_bits_ar_bits_id      (m_axi_mem_arid),
    .axi4_mem_0_bits_ar_bits_addr    (mem_araddr_rocket),
    .axi4_mem_0_bits_ar_bits_len     (m_axi_mem_arlen),
    .axi4_mem_0_bits_ar_bits_size    (m_axi_mem_arsize),
    .axi4_mem_0_bits_ar_bits_burst   (m_axi_mem_arburst),
    .axi4_mem_0_bits_ar_bits_lock    (m_axi_mem_arlock),
    .axi4_mem_0_bits_ar_bits_cache   (m_axi_mem_arcache),
    .axi4_mem_0_bits_ar_bits_prot    (m_axi_mem_arprot),
    .axi4_mem_0_bits_ar_bits_qos     (m_axi_mem_arqos),
    .axi4_mem_0_bits_r_ready         (m_axi_mem_rready),
    .axi4_mem_0_bits_r_valid         (m_axi_mem_rvalid),
    .axi4_mem_0_bits_r_bits_id       (m_axi_mem_rid),
    .axi4_mem_0_bits_r_bits_data     (m_axi_mem_rdata),
    .axi4_mem_0_bits_r_bits_resp     (m_axi_mem_rresp),
    .axi4_mem_0_bits_r_bits_last     (m_axi_mem_rlast),

    .axi4_mmio_0_clock               (),
    .axi4_mmio_0_bits_aw_ready       (m_axi_mmio_awready),
    .axi4_mmio_0_bits_aw_valid       (m_axi_mmio_awvalid),
    .axi4_mmio_0_bits_aw_bits_id     (m_axi_mmio_awid),
    .axi4_mmio_0_bits_aw_bits_addr   (m_axi_mmio_awaddr),
    .axi4_mmio_0_bits_aw_bits_len    (m_axi_mmio_awlen),
    .axi4_mmio_0_bits_aw_bits_size   (m_axi_mmio_awsize),
    .axi4_mmio_0_bits_aw_bits_burst  (m_axi_mmio_awburst),
    .axi4_mmio_0_bits_aw_bits_lock   (m_axi_mmio_awlock),
    .axi4_mmio_0_bits_aw_bits_cache  (m_axi_mmio_awcache),
    .axi4_mmio_0_bits_aw_bits_prot   (m_axi_mmio_awprot),
    .axi4_mmio_0_bits_aw_bits_qos    (m_axi_mmio_awqos),
    .axi4_mmio_0_bits_w_ready        (m_axi_mmio_wready),
    .axi4_mmio_0_bits_w_valid        (m_axi_mmio_wvalid),
    .axi4_mmio_0_bits_w_bits_data    (m_axi_mmio_wdata),
    .axi4_mmio_0_bits_w_bits_strb    (m_axi_mmio_wstrb),
    .axi4_mmio_0_bits_w_bits_last    (m_axi_mmio_wlast),
    .axi4_mmio_0_bits_b_ready        (m_axi_mmio_bready),
    .axi4_mmio_0_bits_b_valid        (m_axi_mmio_bvalid),
    .axi4_mmio_0_bits_b_bits_id      (m_axi_mmio_bid),
    .axi4_mmio_0_bits_b_bits_resp    (m_axi_mmio_bresp),
    .axi4_mmio_0_bits_ar_ready       (m_axi_mmio_arready),
    .axi4_mmio_0_bits_ar_valid       (m_axi_mmio_arvalid),
    .axi4_mmio_0_bits_ar_bits_id     (m_axi_mmio_arid),
    .axi4_mmio_0_bits_ar_bits_addr   (m_axi_mmio_araddr),
    .axi4_mmio_0_bits_ar_bits_len    (m_axi_mmio_arlen),
    .axi4_mmio_0_bits_ar_bits_size   (m_axi_mmio_arsize),
    .axi4_mmio_0_bits_ar_bits_burst  (m_axi_mmio_arburst),
    .axi4_mmio_0_bits_ar_bits_lock   (m_axi_mmio_arlock),
    .axi4_mmio_0_bits_ar_bits_cache  (m_axi_mmio_arcache),
    .axi4_mmio_0_bits_ar_bits_prot   (m_axi_mmio_arprot),
    .axi4_mmio_0_bits_ar_bits_qos    (m_axi_mmio_arqos),
    .axi4_mmio_0_bits_r_ready        (m_axi_mmio_rready),
    .axi4_mmio_0_bits_r_valid        (m_axi_mmio_rvalid),
    .axi4_mmio_0_bits_r_bits_id      (m_axi_mmio_rid),
    .axi4_mmio_0_bits_r_bits_data    (m_axi_mmio_rdata),
    .axi4_mmio_0_bits_r_bits_resp    (m_axi_mmio_rresp),
    .axi4_mmio_0_bits_r_bits_last    (m_axi_mmio_rlast)
  );

endmodule
