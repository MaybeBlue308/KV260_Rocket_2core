//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Wed Oct 14 08:36:42 2026
//Host        : vsi.es running 64-bit Ubuntu 24.04.4 LTS
//Command     : generate_target kv260_bd.bd
//Design      : kv260_bd
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "kv260_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=kv260_bd,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=None}" *) (* HW_HANDOFF = "kv260_bd.hwdef" *) 
module kv260_bd
   (spi0_cs_n,
    spi0_miso,
    spi0_mosi,
    spi0_sck,
    spi1_cs_n,
    spi1_miso,
    spi1_mosi,
    spi1_sck);
  output spi0_cs_n;
  input spi0_miso;
  output spi0_mosi;
  output spi0_sck;
  output spi1_cs_n;
  input spi1_miso;
  output spi1_mosi;
  output spi1_sck;

  wire [39:0]kv260_rocket_wrapper_0_m_axi_mem_ARADDR;
  wire [1:0]kv260_rocket_wrapper_0_m_axi_mem_ARBURST;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mem_ARCACHE;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mem_ARID;
  wire [7:0]kv260_rocket_wrapper_0_m_axi_mem_ARLEN;
  wire kv260_rocket_wrapper_0_m_axi_mem_ARLOCK;
  wire [2:0]kv260_rocket_wrapper_0_m_axi_mem_ARPROT;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mem_ARQOS;
  wire kv260_rocket_wrapper_0_m_axi_mem_ARREADY;
  wire [2:0]kv260_rocket_wrapper_0_m_axi_mem_ARSIZE;
  wire kv260_rocket_wrapper_0_m_axi_mem_ARVALID;
  wire [39:0]kv260_rocket_wrapper_0_m_axi_mem_AWADDR;
  wire [1:0]kv260_rocket_wrapper_0_m_axi_mem_AWBURST;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mem_AWCACHE;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mem_AWID;
  wire [7:0]kv260_rocket_wrapper_0_m_axi_mem_AWLEN;
  wire kv260_rocket_wrapper_0_m_axi_mem_AWLOCK;
  wire [2:0]kv260_rocket_wrapper_0_m_axi_mem_AWPROT;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mem_AWQOS;
  wire kv260_rocket_wrapper_0_m_axi_mem_AWREADY;
  wire [2:0]kv260_rocket_wrapper_0_m_axi_mem_AWSIZE;
  wire kv260_rocket_wrapper_0_m_axi_mem_AWVALID;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mem_BID;
  wire kv260_rocket_wrapper_0_m_axi_mem_BREADY;
  wire [1:0]kv260_rocket_wrapper_0_m_axi_mem_BRESP;
  wire kv260_rocket_wrapper_0_m_axi_mem_BVALID;
  wire [63:0]kv260_rocket_wrapper_0_m_axi_mem_RDATA;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mem_RID;
  wire kv260_rocket_wrapper_0_m_axi_mem_RLAST;
  wire kv260_rocket_wrapper_0_m_axi_mem_RREADY;
  wire [1:0]kv260_rocket_wrapper_0_m_axi_mem_RRESP;
  wire kv260_rocket_wrapper_0_m_axi_mem_RVALID;
  wire [63:0]kv260_rocket_wrapper_0_m_axi_mem_WDATA;
  wire kv260_rocket_wrapper_0_m_axi_mem_WLAST;
  wire kv260_rocket_wrapper_0_m_axi_mem_WREADY;
  wire [7:0]kv260_rocket_wrapper_0_m_axi_mem_WSTRB;
  wire kv260_rocket_wrapper_0_m_axi_mem_WVALID;
  wire [31:0]kv260_rocket_wrapper_0_m_axi_mmio_ARADDR;
  wire [1:0]kv260_rocket_wrapper_0_m_axi_mmio_ARBURST;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mmio_ARCACHE;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mmio_ARID;
  wire [7:0]kv260_rocket_wrapper_0_m_axi_mmio_ARLEN;
  wire kv260_rocket_wrapper_0_m_axi_mmio_ARLOCK;
  wire [2:0]kv260_rocket_wrapper_0_m_axi_mmio_ARPROT;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mmio_ARQOS;
  wire kv260_rocket_wrapper_0_m_axi_mmio_ARREADY;
  wire [2:0]kv260_rocket_wrapper_0_m_axi_mmio_ARSIZE;
  wire kv260_rocket_wrapper_0_m_axi_mmio_ARVALID;
  wire [31:0]kv260_rocket_wrapper_0_m_axi_mmio_AWADDR;
  wire [1:0]kv260_rocket_wrapper_0_m_axi_mmio_AWBURST;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mmio_AWCACHE;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mmio_AWID;
  wire [7:0]kv260_rocket_wrapper_0_m_axi_mmio_AWLEN;
  wire kv260_rocket_wrapper_0_m_axi_mmio_AWLOCK;
  wire [2:0]kv260_rocket_wrapper_0_m_axi_mmio_AWPROT;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mmio_AWQOS;
  wire kv260_rocket_wrapper_0_m_axi_mmio_AWREADY;
  wire [2:0]kv260_rocket_wrapper_0_m_axi_mmio_AWSIZE;
  wire kv260_rocket_wrapper_0_m_axi_mmio_AWVALID;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mmio_BID;
  wire kv260_rocket_wrapper_0_m_axi_mmio_BREADY;
  wire [1:0]kv260_rocket_wrapper_0_m_axi_mmio_BRESP;
  wire kv260_rocket_wrapper_0_m_axi_mmio_BVALID;
  wire [63:0]kv260_rocket_wrapper_0_m_axi_mmio_RDATA;
  wire [3:0]kv260_rocket_wrapper_0_m_axi_mmio_RID;
  wire kv260_rocket_wrapper_0_m_axi_mmio_RLAST;
  wire kv260_rocket_wrapper_0_m_axi_mmio_RREADY;
  wire [1:0]kv260_rocket_wrapper_0_m_axi_mmio_RRESP;
  wire kv260_rocket_wrapper_0_m_axi_mmio_RVALID;
  wire [63:0]kv260_rocket_wrapper_0_m_axi_mmio_WDATA;
  wire kv260_rocket_wrapper_0_m_axi_mmio_WLAST;
  wire kv260_rocket_wrapper_0_m_axi_mmio_WREADY;
  wire [7:0]kv260_rocket_wrapper_0_m_axi_mmio_WSTRB;
  wire kv260_rocket_wrapper_0_m_axi_mmio_WVALID;
  wire [7:0]kv260_rocket_wrapper_0_ps_gpio_i;
  wire kv260_rocket_wrapper_0_uart_txd;
  wire [0:0]proc_sys_reset_0_peripheral_aresetn;
  wire [48:0]smartconnect_0_M00_AXI_ARADDR;
  wire [1:0]smartconnect_0_M00_AXI_ARBURST;
  wire [3:0]smartconnect_0_M00_AXI_ARCACHE;
  wire [7:0]smartconnect_0_M00_AXI_ARLEN;
  wire [0:0]smartconnect_0_M00_AXI_ARLOCK;
  wire [2:0]smartconnect_0_M00_AXI_ARPROT;
  wire [3:0]smartconnect_0_M00_AXI_ARQOS;
  wire smartconnect_0_M00_AXI_ARREADY;
  wire [2:0]smartconnect_0_M00_AXI_ARSIZE;
  wire smartconnect_0_M00_AXI_ARVALID;
  wire [48:0]smartconnect_0_M00_AXI_AWADDR;
  wire [1:0]smartconnect_0_M00_AXI_AWBURST;
  wire [3:0]smartconnect_0_M00_AXI_AWCACHE;
  wire [7:0]smartconnect_0_M00_AXI_AWLEN;
  wire [0:0]smartconnect_0_M00_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M00_AXI_AWPROT;
  wire [3:0]smartconnect_0_M00_AXI_AWQOS;
  wire smartconnect_0_M00_AXI_AWREADY;
  wire [2:0]smartconnect_0_M00_AXI_AWSIZE;
  wire smartconnect_0_M00_AXI_AWVALID;
  wire smartconnect_0_M00_AXI_BREADY;
  wire [1:0]smartconnect_0_M00_AXI_BRESP;
  wire smartconnect_0_M00_AXI_BVALID;
  wire [63:0]smartconnect_0_M00_AXI_RDATA;
  wire smartconnect_0_M00_AXI_RLAST;
  wire smartconnect_0_M00_AXI_RREADY;
  wire [1:0]smartconnect_0_M00_AXI_RRESP;
  wire smartconnect_0_M00_AXI_RVALID;
  wire [63:0]smartconnect_0_M00_AXI_WDATA;
  wire smartconnect_0_M00_AXI_WLAST;
  wire smartconnect_0_M00_AXI_WREADY;
  wire [7:0]smartconnect_0_M00_AXI_WSTRB;
  wire smartconnect_0_M00_AXI_WVALID;
  wire [48:0]smartconnect_1_M00_AXI_ARADDR;
  wire [1:0]smartconnect_1_M00_AXI_ARBURST;
  wire [3:0]smartconnect_1_M00_AXI_ARCACHE;
  wire [7:0]smartconnect_1_M00_AXI_ARLEN;
  wire [0:0]smartconnect_1_M00_AXI_ARLOCK;
  wire [2:0]smartconnect_1_M00_AXI_ARPROT;
  wire [3:0]smartconnect_1_M00_AXI_ARQOS;
  wire smartconnect_1_M00_AXI_ARREADY;
  wire [2:0]smartconnect_1_M00_AXI_ARSIZE;
  wire smartconnect_1_M00_AXI_ARVALID;
  wire [48:0]smartconnect_1_M00_AXI_AWADDR;
  wire [1:0]smartconnect_1_M00_AXI_AWBURST;
  wire [3:0]smartconnect_1_M00_AXI_AWCACHE;
  wire [7:0]smartconnect_1_M00_AXI_AWLEN;
  wire [0:0]smartconnect_1_M00_AXI_AWLOCK;
  wire [2:0]smartconnect_1_M00_AXI_AWPROT;
  wire [3:0]smartconnect_1_M00_AXI_AWQOS;
  wire smartconnect_1_M00_AXI_AWREADY;
  wire [2:0]smartconnect_1_M00_AXI_AWSIZE;
  wire smartconnect_1_M00_AXI_AWVALID;
  wire smartconnect_1_M00_AXI_BREADY;
  wire [1:0]smartconnect_1_M00_AXI_BRESP;
  wire smartconnect_1_M00_AXI_BVALID;
  wire [63:0]smartconnect_1_M00_AXI_RDATA;
  wire smartconnect_1_M00_AXI_RLAST;
  wire smartconnect_1_M00_AXI_RREADY;
  wire [1:0]smartconnect_1_M00_AXI_RRESP;
  wire smartconnect_1_M00_AXI_RVALID;
  wire [63:0]smartconnect_1_M00_AXI_WDATA;
  wire smartconnect_1_M00_AXI_WLAST;
  wire smartconnect_1_M00_AXI_WREADY;
  wire [7:0]smartconnect_1_M00_AXI_WSTRB;
  wire smartconnect_1_M00_AXI_WVALID;
  wire spi0_cs_n;
  wire spi0_miso;
  wire spi0_mosi;
  wire spi0_sck;
  wire spi1_cs_n;
  wire spi1_miso;
  wire spi1_mosi;
  wire spi1_sck;
  wire [94:0]zynq_ultra_ps_e_0_emio_gpio_o;
  wire zynq_ultra_ps_e_0_emio_uart0_txd;
  wire zynq_ultra_ps_e_0_pl_clk0;
  wire zynq_ultra_ps_e_0_pl_resetn0;

  kv260_bd_kv260_rocket_wrapper_0_0 kv260_rocket_wrapper_0
       (.clk(zynq_ultra_ps_e_0_pl_clk0),
        .m_axi_mem_araddr(kv260_rocket_wrapper_0_m_axi_mem_ARADDR),
        .m_axi_mem_arburst(kv260_rocket_wrapper_0_m_axi_mem_ARBURST),
        .m_axi_mem_arcache(kv260_rocket_wrapper_0_m_axi_mem_ARCACHE),
        .m_axi_mem_arid(kv260_rocket_wrapper_0_m_axi_mem_ARID),
        .m_axi_mem_arlen(kv260_rocket_wrapper_0_m_axi_mem_ARLEN),
        .m_axi_mem_arlock(kv260_rocket_wrapper_0_m_axi_mem_ARLOCK),
        .m_axi_mem_arprot(kv260_rocket_wrapper_0_m_axi_mem_ARPROT),
        .m_axi_mem_arqos(kv260_rocket_wrapper_0_m_axi_mem_ARQOS),
        .m_axi_mem_arready(kv260_rocket_wrapper_0_m_axi_mem_ARREADY),
        .m_axi_mem_arsize(kv260_rocket_wrapper_0_m_axi_mem_ARSIZE),
        .m_axi_mem_arvalid(kv260_rocket_wrapper_0_m_axi_mem_ARVALID),
        .m_axi_mem_awaddr(kv260_rocket_wrapper_0_m_axi_mem_AWADDR),
        .m_axi_mem_awburst(kv260_rocket_wrapper_0_m_axi_mem_AWBURST),
        .m_axi_mem_awcache(kv260_rocket_wrapper_0_m_axi_mem_AWCACHE),
        .m_axi_mem_awid(kv260_rocket_wrapper_0_m_axi_mem_AWID),
        .m_axi_mem_awlen(kv260_rocket_wrapper_0_m_axi_mem_AWLEN),
        .m_axi_mem_awlock(kv260_rocket_wrapper_0_m_axi_mem_AWLOCK),
        .m_axi_mem_awprot(kv260_rocket_wrapper_0_m_axi_mem_AWPROT),
        .m_axi_mem_awqos(kv260_rocket_wrapper_0_m_axi_mem_AWQOS),
        .m_axi_mem_awready(kv260_rocket_wrapper_0_m_axi_mem_AWREADY),
        .m_axi_mem_awsize(kv260_rocket_wrapper_0_m_axi_mem_AWSIZE),
        .m_axi_mem_awvalid(kv260_rocket_wrapper_0_m_axi_mem_AWVALID),
        .m_axi_mem_bid(kv260_rocket_wrapper_0_m_axi_mem_BID),
        .m_axi_mem_bready(kv260_rocket_wrapper_0_m_axi_mem_BREADY),
        .m_axi_mem_bresp(kv260_rocket_wrapper_0_m_axi_mem_BRESP),
        .m_axi_mem_bvalid(kv260_rocket_wrapper_0_m_axi_mem_BVALID),
        .m_axi_mem_rdata(kv260_rocket_wrapper_0_m_axi_mem_RDATA),
        .m_axi_mem_rid(kv260_rocket_wrapper_0_m_axi_mem_RID),
        .m_axi_mem_rlast(kv260_rocket_wrapper_0_m_axi_mem_RLAST),
        .m_axi_mem_rready(kv260_rocket_wrapper_0_m_axi_mem_RREADY),
        .m_axi_mem_rresp(kv260_rocket_wrapper_0_m_axi_mem_RRESP),
        .m_axi_mem_rvalid(kv260_rocket_wrapper_0_m_axi_mem_RVALID),
        .m_axi_mem_wdata(kv260_rocket_wrapper_0_m_axi_mem_WDATA),
        .m_axi_mem_wlast(kv260_rocket_wrapper_0_m_axi_mem_WLAST),
        .m_axi_mem_wready(kv260_rocket_wrapper_0_m_axi_mem_WREADY),
        .m_axi_mem_wstrb(kv260_rocket_wrapper_0_m_axi_mem_WSTRB),
        .m_axi_mem_wvalid(kv260_rocket_wrapper_0_m_axi_mem_WVALID),
        .m_axi_mmio_araddr(kv260_rocket_wrapper_0_m_axi_mmio_ARADDR),
        .m_axi_mmio_arburst(kv260_rocket_wrapper_0_m_axi_mmio_ARBURST),
        .m_axi_mmio_arcache(kv260_rocket_wrapper_0_m_axi_mmio_ARCACHE),
        .m_axi_mmio_arid(kv260_rocket_wrapper_0_m_axi_mmio_ARID),
        .m_axi_mmio_arlen(kv260_rocket_wrapper_0_m_axi_mmio_ARLEN),
        .m_axi_mmio_arlock(kv260_rocket_wrapper_0_m_axi_mmio_ARLOCK),
        .m_axi_mmio_arprot(kv260_rocket_wrapper_0_m_axi_mmio_ARPROT),
        .m_axi_mmio_arqos(kv260_rocket_wrapper_0_m_axi_mmio_ARQOS),
        .m_axi_mmio_arready(kv260_rocket_wrapper_0_m_axi_mmio_ARREADY),
        .m_axi_mmio_arsize(kv260_rocket_wrapper_0_m_axi_mmio_ARSIZE),
        .m_axi_mmio_arvalid(kv260_rocket_wrapper_0_m_axi_mmio_ARVALID),
        .m_axi_mmio_awaddr(kv260_rocket_wrapper_0_m_axi_mmio_AWADDR),
        .m_axi_mmio_awburst(kv260_rocket_wrapper_0_m_axi_mmio_AWBURST),
        .m_axi_mmio_awcache(kv260_rocket_wrapper_0_m_axi_mmio_AWCACHE),
        .m_axi_mmio_awid(kv260_rocket_wrapper_0_m_axi_mmio_AWID),
        .m_axi_mmio_awlen(kv260_rocket_wrapper_0_m_axi_mmio_AWLEN),
        .m_axi_mmio_awlock(kv260_rocket_wrapper_0_m_axi_mmio_AWLOCK),
        .m_axi_mmio_awprot(kv260_rocket_wrapper_0_m_axi_mmio_AWPROT),
        .m_axi_mmio_awqos(kv260_rocket_wrapper_0_m_axi_mmio_AWQOS),
        .m_axi_mmio_awready(kv260_rocket_wrapper_0_m_axi_mmio_AWREADY),
        .m_axi_mmio_awsize(kv260_rocket_wrapper_0_m_axi_mmio_AWSIZE),
        .m_axi_mmio_awvalid(kv260_rocket_wrapper_0_m_axi_mmio_AWVALID),
        .m_axi_mmio_bid(kv260_rocket_wrapper_0_m_axi_mmio_BID),
        .m_axi_mmio_bready(kv260_rocket_wrapper_0_m_axi_mmio_BREADY),
        .m_axi_mmio_bresp(kv260_rocket_wrapper_0_m_axi_mmio_BRESP),
        .m_axi_mmio_bvalid(kv260_rocket_wrapper_0_m_axi_mmio_BVALID),
        .m_axi_mmio_rdata(kv260_rocket_wrapper_0_m_axi_mmio_RDATA),
        .m_axi_mmio_rid(kv260_rocket_wrapper_0_m_axi_mmio_RID),
        .m_axi_mmio_rlast(kv260_rocket_wrapper_0_m_axi_mmio_RLAST),
        .m_axi_mmio_rready(kv260_rocket_wrapper_0_m_axi_mmio_RREADY),
        .m_axi_mmio_rresp(kv260_rocket_wrapper_0_m_axi_mmio_RRESP),
        .m_axi_mmio_rvalid(kv260_rocket_wrapper_0_m_axi_mmio_RVALID),
        .m_axi_mmio_wdata(kv260_rocket_wrapper_0_m_axi_mmio_WDATA),
        .m_axi_mmio_wlast(kv260_rocket_wrapper_0_m_axi_mmio_WLAST),
        .m_axi_mmio_wready(kv260_rocket_wrapper_0_m_axi_mmio_WREADY),
        .m_axi_mmio_wstrb(kv260_rocket_wrapper_0_m_axi_mmio_WSTRB),
        .m_axi_mmio_wvalid(kv260_rocket_wrapper_0_m_axi_mmio_WVALID),
        .ps_gpio_i(kv260_rocket_wrapper_0_ps_gpio_i),
        .ps_gpio_o(zynq_ultra_ps_e_0_emio_gpio_o[7:0]),
        .resetn(proc_sys_reset_0_peripheral_aresetn),
        .spi0_cs_n(spi0_cs_n),
        .spi0_miso(spi0_miso),
        .spi0_mosi(spi0_mosi),
        .spi0_sck(spi0_sck),
        .spi1_cs_n(spi1_cs_n),
        .spi1_miso(spi1_miso),
        .spi1_mosi(spi1_mosi),
        .spi1_sck(spi1_sck),
        .uart_rxd(zynq_ultra_ps_e_0_emio_uart0_txd),
        .uart_txd(kv260_rocket_wrapper_0_uart_txd));
  kv260_bd_proc_sys_reset_0_0 proc_sys_reset_0
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(zynq_ultra_ps_e_0_pl_resetn0),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .slowest_sync_clk(zynq_ultra_ps_e_0_pl_clk0));
  kv260_bd_smartconnect_0_0 smartconnect_0
       (.M00_AXI_araddr(smartconnect_0_M00_AXI_ARADDR),
        .M00_AXI_arburst(smartconnect_0_M00_AXI_ARBURST),
        .M00_AXI_arcache(smartconnect_0_M00_AXI_ARCACHE),
        .M00_AXI_arlen(smartconnect_0_M00_AXI_ARLEN),
        .M00_AXI_arlock(smartconnect_0_M00_AXI_ARLOCK),
        .M00_AXI_arprot(smartconnect_0_M00_AXI_ARPROT),
        .M00_AXI_arqos(smartconnect_0_M00_AXI_ARQOS),
        .M00_AXI_arready(smartconnect_0_M00_AXI_ARREADY),
        .M00_AXI_arsize(smartconnect_0_M00_AXI_ARSIZE),
        .M00_AXI_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .M00_AXI_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .M00_AXI_awburst(smartconnect_0_M00_AXI_AWBURST),
        .M00_AXI_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .M00_AXI_awlen(smartconnect_0_M00_AXI_AWLEN),
        .M00_AXI_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .M00_AXI_awprot(smartconnect_0_M00_AXI_AWPROT),
        .M00_AXI_awqos(smartconnect_0_M00_AXI_AWQOS),
        .M00_AXI_awready(smartconnect_0_M00_AXI_AWREADY),
        .M00_AXI_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .M00_AXI_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .M00_AXI_bready(smartconnect_0_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_0_M00_AXI_BRESP),
        .M00_AXI_bvalid(smartconnect_0_M00_AXI_BVALID),
        .M00_AXI_rdata(smartconnect_0_M00_AXI_RDATA),
        .M00_AXI_rlast(smartconnect_0_M00_AXI_RLAST),
        .M00_AXI_rready(smartconnect_0_M00_AXI_RREADY),
        .M00_AXI_rresp(smartconnect_0_M00_AXI_RRESP),
        .M00_AXI_rvalid(smartconnect_0_M00_AXI_RVALID),
        .M00_AXI_wdata(smartconnect_0_M00_AXI_WDATA),
        .M00_AXI_wlast(smartconnect_0_M00_AXI_WLAST),
        .M00_AXI_wready(smartconnect_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .M00_AXI_wvalid(smartconnect_0_M00_AXI_WVALID),
        .S00_AXI_araddr(kv260_rocket_wrapper_0_m_axi_mem_ARADDR),
        .S00_AXI_arburst(kv260_rocket_wrapper_0_m_axi_mem_ARBURST),
        .S00_AXI_arcache(kv260_rocket_wrapper_0_m_axi_mem_ARCACHE),
        .S00_AXI_arid(kv260_rocket_wrapper_0_m_axi_mem_ARID),
        .S00_AXI_arlen(kv260_rocket_wrapper_0_m_axi_mem_ARLEN),
        .S00_AXI_arlock(kv260_rocket_wrapper_0_m_axi_mem_ARLOCK),
        .S00_AXI_arprot(kv260_rocket_wrapper_0_m_axi_mem_ARPROT),
        .S00_AXI_arqos(kv260_rocket_wrapper_0_m_axi_mem_ARQOS),
        .S00_AXI_arready(kv260_rocket_wrapper_0_m_axi_mem_ARREADY),
        .S00_AXI_arsize(kv260_rocket_wrapper_0_m_axi_mem_ARSIZE),
        .S00_AXI_arvalid(kv260_rocket_wrapper_0_m_axi_mem_ARVALID),
        .S00_AXI_awaddr(kv260_rocket_wrapper_0_m_axi_mem_AWADDR),
        .S00_AXI_awburst(kv260_rocket_wrapper_0_m_axi_mem_AWBURST),
        .S00_AXI_awcache(kv260_rocket_wrapper_0_m_axi_mem_AWCACHE),
        .S00_AXI_awid(kv260_rocket_wrapper_0_m_axi_mem_AWID),
        .S00_AXI_awlen(kv260_rocket_wrapper_0_m_axi_mem_AWLEN),
        .S00_AXI_awlock(kv260_rocket_wrapper_0_m_axi_mem_AWLOCK),
        .S00_AXI_awprot(kv260_rocket_wrapper_0_m_axi_mem_AWPROT),
        .S00_AXI_awqos(kv260_rocket_wrapper_0_m_axi_mem_AWQOS),
        .S00_AXI_awready(kv260_rocket_wrapper_0_m_axi_mem_AWREADY),
        .S00_AXI_awsize(kv260_rocket_wrapper_0_m_axi_mem_AWSIZE),
        .S00_AXI_awvalid(kv260_rocket_wrapper_0_m_axi_mem_AWVALID),
        .S00_AXI_bid(kv260_rocket_wrapper_0_m_axi_mem_BID),
        .S00_AXI_bready(kv260_rocket_wrapper_0_m_axi_mem_BREADY),
        .S00_AXI_bresp(kv260_rocket_wrapper_0_m_axi_mem_BRESP),
        .S00_AXI_bvalid(kv260_rocket_wrapper_0_m_axi_mem_BVALID),
        .S00_AXI_rdata(kv260_rocket_wrapper_0_m_axi_mem_RDATA),
        .S00_AXI_rid(kv260_rocket_wrapper_0_m_axi_mem_RID),
        .S00_AXI_rlast(kv260_rocket_wrapper_0_m_axi_mem_RLAST),
        .S00_AXI_rready(kv260_rocket_wrapper_0_m_axi_mem_RREADY),
        .S00_AXI_rresp(kv260_rocket_wrapper_0_m_axi_mem_RRESP),
        .S00_AXI_rvalid(kv260_rocket_wrapper_0_m_axi_mem_RVALID),
        .S00_AXI_wdata(kv260_rocket_wrapper_0_m_axi_mem_WDATA),
        .S00_AXI_wlast(kv260_rocket_wrapper_0_m_axi_mem_WLAST),
        .S00_AXI_wready(kv260_rocket_wrapper_0_m_axi_mem_WREADY),
        .S00_AXI_wstrb(kv260_rocket_wrapper_0_m_axi_mem_WSTRB),
        .S00_AXI_wvalid(kv260_rocket_wrapper_0_m_axi_mem_WVALID),
        .aclk(zynq_ultra_ps_e_0_pl_clk0),
        .aresetn(proc_sys_reset_0_peripheral_aresetn));
  kv260_bd_smartconnect_1_0 smartconnect_1
       (.M00_AXI_araddr(smartconnect_1_M00_AXI_ARADDR),
        .M00_AXI_arburst(smartconnect_1_M00_AXI_ARBURST),
        .M00_AXI_arcache(smartconnect_1_M00_AXI_ARCACHE),
        .M00_AXI_arlen(smartconnect_1_M00_AXI_ARLEN),
        .M00_AXI_arlock(smartconnect_1_M00_AXI_ARLOCK),
        .M00_AXI_arprot(smartconnect_1_M00_AXI_ARPROT),
        .M00_AXI_arqos(smartconnect_1_M00_AXI_ARQOS),
        .M00_AXI_arready(smartconnect_1_M00_AXI_ARREADY),
        .M00_AXI_arsize(smartconnect_1_M00_AXI_ARSIZE),
        .M00_AXI_arvalid(smartconnect_1_M00_AXI_ARVALID),
        .M00_AXI_awaddr(smartconnect_1_M00_AXI_AWADDR),
        .M00_AXI_awburst(smartconnect_1_M00_AXI_AWBURST),
        .M00_AXI_awcache(smartconnect_1_M00_AXI_AWCACHE),
        .M00_AXI_awlen(smartconnect_1_M00_AXI_AWLEN),
        .M00_AXI_awlock(smartconnect_1_M00_AXI_AWLOCK),
        .M00_AXI_awprot(smartconnect_1_M00_AXI_AWPROT),
        .M00_AXI_awqos(smartconnect_1_M00_AXI_AWQOS),
        .M00_AXI_awready(smartconnect_1_M00_AXI_AWREADY),
        .M00_AXI_awsize(smartconnect_1_M00_AXI_AWSIZE),
        .M00_AXI_awvalid(smartconnect_1_M00_AXI_AWVALID),
        .M00_AXI_bready(smartconnect_1_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_1_M00_AXI_BRESP),
        .M00_AXI_bvalid(smartconnect_1_M00_AXI_BVALID),
        .M00_AXI_rdata(smartconnect_1_M00_AXI_RDATA),
        .M00_AXI_rlast(smartconnect_1_M00_AXI_RLAST),
        .M00_AXI_rready(smartconnect_1_M00_AXI_RREADY),
        .M00_AXI_rresp(smartconnect_1_M00_AXI_RRESP),
        .M00_AXI_rvalid(smartconnect_1_M00_AXI_RVALID),
        .M00_AXI_wdata(smartconnect_1_M00_AXI_WDATA),
        .M00_AXI_wlast(smartconnect_1_M00_AXI_WLAST),
        .M00_AXI_wready(smartconnect_1_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_1_M00_AXI_WSTRB),
        .M00_AXI_wvalid(smartconnect_1_M00_AXI_WVALID),
        .S00_AXI_araddr(kv260_rocket_wrapper_0_m_axi_mmio_ARADDR),
        .S00_AXI_arburst(kv260_rocket_wrapper_0_m_axi_mmio_ARBURST),
        .S00_AXI_arcache(kv260_rocket_wrapper_0_m_axi_mmio_ARCACHE),
        .S00_AXI_arid(kv260_rocket_wrapper_0_m_axi_mmio_ARID),
        .S00_AXI_arlen(kv260_rocket_wrapper_0_m_axi_mmio_ARLEN),
        .S00_AXI_arlock(kv260_rocket_wrapper_0_m_axi_mmio_ARLOCK),
        .S00_AXI_arprot(kv260_rocket_wrapper_0_m_axi_mmio_ARPROT),
        .S00_AXI_arqos(kv260_rocket_wrapper_0_m_axi_mmio_ARQOS),
        .S00_AXI_arready(kv260_rocket_wrapper_0_m_axi_mmio_ARREADY),
        .S00_AXI_arsize(kv260_rocket_wrapper_0_m_axi_mmio_ARSIZE),
        .S00_AXI_arvalid(kv260_rocket_wrapper_0_m_axi_mmio_ARVALID),
        .S00_AXI_awaddr(kv260_rocket_wrapper_0_m_axi_mmio_AWADDR),
        .S00_AXI_awburst(kv260_rocket_wrapper_0_m_axi_mmio_AWBURST),
        .S00_AXI_awcache(kv260_rocket_wrapper_0_m_axi_mmio_AWCACHE),
        .S00_AXI_awid(kv260_rocket_wrapper_0_m_axi_mmio_AWID),
        .S00_AXI_awlen(kv260_rocket_wrapper_0_m_axi_mmio_AWLEN),
        .S00_AXI_awlock(kv260_rocket_wrapper_0_m_axi_mmio_AWLOCK),
        .S00_AXI_awprot(kv260_rocket_wrapper_0_m_axi_mmio_AWPROT),
        .S00_AXI_awqos(kv260_rocket_wrapper_0_m_axi_mmio_AWQOS),
        .S00_AXI_awready(kv260_rocket_wrapper_0_m_axi_mmio_AWREADY),
        .S00_AXI_awsize(kv260_rocket_wrapper_0_m_axi_mmio_AWSIZE),
        .S00_AXI_awvalid(kv260_rocket_wrapper_0_m_axi_mmio_AWVALID),
        .S00_AXI_bid(kv260_rocket_wrapper_0_m_axi_mmio_BID),
        .S00_AXI_bready(kv260_rocket_wrapper_0_m_axi_mmio_BREADY),
        .S00_AXI_bresp(kv260_rocket_wrapper_0_m_axi_mmio_BRESP),
        .S00_AXI_bvalid(kv260_rocket_wrapper_0_m_axi_mmio_BVALID),
        .S00_AXI_rdata(kv260_rocket_wrapper_0_m_axi_mmio_RDATA),
        .S00_AXI_rid(kv260_rocket_wrapper_0_m_axi_mmio_RID),
        .S00_AXI_rlast(kv260_rocket_wrapper_0_m_axi_mmio_RLAST),
        .S00_AXI_rready(kv260_rocket_wrapper_0_m_axi_mmio_RREADY),
        .S00_AXI_rresp(kv260_rocket_wrapper_0_m_axi_mmio_RRESP),
        .S00_AXI_rvalid(kv260_rocket_wrapper_0_m_axi_mmio_RVALID),
        .S00_AXI_wdata(kv260_rocket_wrapper_0_m_axi_mmio_WDATA),
        .S00_AXI_wlast(kv260_rocket_wrapper_0_m_axi_mmio_WLAST),
        .S00_AXI_wready(kv260_rocket_wrapper_0_m_axi_mmio_WREADY),
        .S00_AXI_wstrb(kv260_rocket_wrapper_0_m_axi_mmio_WSTRB),
        .S00_AXI_wvalid(kv260_rocket_wrapper_0_m_axi_mmio_WVALID),
        .aclk(zynq_ultra_ps_e_0_pl_clk0),
        .aresetn(proc_sys_reset_0_peripheral_aresetn));
  kv260_bd_zynq_ultra_ps_e_0_0 zynq_ultra_ps_e_0
       (.emio_gpio_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,kv260_rocket_wrapper_0_ps_gpio_i}),
        .emio_gpio_o(zynq_ultra_ps_e_0_emio_gpio_o),
        .emio_uart0_rxd(kv260_rocket_wrapper_0_uart_txd),
        .emio_uart0_txd(zynq_ultra_ps_e_0_emio_uart0_txd),
        .pl_clk0(zynq_ultra_ps_e_0_pl_clk0),
        .pl_ps_irq0(1'b0),
        .pl_resetn0(zynq_ultra_ps_e_0_pl_resetn0),
        .saxi_lpd_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .saxigp2_araddr(smartconnect_0_M00_AXI_ARADDR),
        .saxigp2_arburst(smartconnect_0_M00_AXI_ARBURST),
        .saxigp2_arcache(smartconnect_0_M00_AXI_ARCACHE),
        .saxigp2_arid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .saxigp2_arlen(smartconnect_0_M00_AXI_ARLEN),
        .saxigp2_arlock(smartconnect_0_M00_AXI_ARLOCK),
        .saxigp2_arprot(smartconnect_0_M00_AXI_ARPROT),
        .saxigp2_arqos(smartconnect_0_M00_AXI_ARQOS),
        .saxigp2_arready(smartconnect_0_M00_AXI_ARREADY),
        .saxigp2_arsize(smartconnect_0_M00_AXI_ARSIZE),
        .saxigp2_aruser(1'b0),
        .saxigp2_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .saxigp2_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .saxigp2_awburst(smartconnect_0_M00_AXI_AWBURST),
        .saxigp2_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .saxigp2_awid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .saxigp2_awlen(smartconnect_0_M00_AXI_AWLEN),
        .saxigp2_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .saxigp2_awprot(smartconnect_0_M00_AXI_AWPROT),
        .saxigp2_awqos(smartconnect_0_M00_AXI_AWQOS),
        .saxigp2_awready(smartconnect_0_M00_AXI_AWREADY),
        .saxigp2_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .saxigp2_awuser(1'b0),
        .saxigp2_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .saxigp2_bready(smartconnect_0_M00_AXI_BREADY),
        .saxigp2_bresp(smartconnect_0_M00_AXI_BRESP),
        .saxigp2_bvalid(smartconnect_0_M00_AXI_BVALID),
        .saxigp2_rdata(smartconnect_0_M00_AXI_RDATA),
        .saxigp2_rlast(smartconnect_0_M00_AXI_RLAST),
        .saxigp2_rready(smartconnect_0_M00_AXI_RREADY),
        .saxigp2_rresp(smartconnect_0_M00_AXI_RRESP),
        .saxigp2_rvalid(smartconnect_0_M00_AXI_RVALID),
        .saxigp2_wdata(smartconnect_0_M00_AXI_WDATA),
        .saxigp2_wlast(smartconnect_0_M00_AXI_WLAST),
        .saxigp2_wready(smartconnect_0_M00_AXI_WREADY),
        .saxigp2_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .saxigp2_wvalid(smartconnect_0_M00_AXI_WVALID),
        .saxigp6_araddr(smartconnect_1_M00_AXI_ARADDR),
        .saxigp6_arburst(smartconnect_1_M00_AXI_ARBURST),
        .saxigp6_arcache(smartconnect_1_M00_AXI_ARCACHE),
        .saxigp6_arid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .saxigp6_arlen(smartconnect_1_M00_AXI_ARLEN),
        .saxigp6_arlock(smartconnect_1_M00_AXI_ARLOCK),
        .saxigp6_arprot(smartconnect_1_M00_AXI_ARPROT),
        .saxigp6_arqos(smartconnect_1_M00_AXI_ARQOS),
        .saxigp6_arready(smartconnect_1_M00_AXI_ARREADY),
        .saxigp6_arsize(smartconnect_1_M00_AXI_ARSIZE),
        .saxigp6_aruser(1'b0),
        .saxigp6_arvalid(smartconnect_1_M00_AXI_ARVALID),
        .saxigp6_awaddr(smartconnect_1_M00_AXI_AWADDR),
        .saxigp6_awburst(smartconnect_1_M00_AXI_AWBURST),
        .saxigp6_awcache(smartconnect_1_M00_AXI_AWCACHE),
        .saxigp6_awid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .saxigp6_awlen(smartconnect_1_M00_AXI_AWLEN),
        .saxigp6_awlock(smartconnect_1_M00_AXI_AWLOCK),
        .saxigp6_awprot(smartconnect_1_M00_AXI_AWPROT),
        .saxigp6_awqos(smartconnect_1_M00_AXI_AWQOS),
        .saxigp6_awready(smartconnect_1_M00_AXI_AWREADY),
        .saxigp6_awsize(smartconnect_1_M00_AXI_AWSIZE),
        .saxigp6_awuser(1'b0),
        .saxigp6_awvalid(smartconnect_1_M00_AXI_AWVALID),
        .saxigp6_bready(smartconnect_1_M00_AXI_BREADY),
        .saxigp6_bresp(smartconnect_1_M00_AXI_BRESP),
        .saxigp6_bvalid(smartconnect_1_M00_AXI_BVALID),
        .saxigp6_rdata(smartconnect_1_M00_AXI_RDATA),
        .saxigp6_rlast(smartconnect_1_M00_AXI_RLAST),
        .saxigp6_rready(smartconnect_1_M00_AXI_RREADY),
        .saxigp6_rresp(smartconnect_1_M00_AXI_RRESP),
        .saxigp6_rvalid(smartconnect_1_M00_AXI_RVALID),
        .saxigp6_wdata(smartconnect_1_M00_AXI_WDATA),
        .saxigp6_wlast(smartconnect_1_M00_AXI_WLAST),
        .saxigp6_wready(smartconnect_1_M00_AXI_WREADY),
        .saxigp6_wstrb(smartconnect_1_M00_AXI_WSTRB),
        .saxigp6_wvalid(smartconnect_1_M00_AXI_WVALID),
        .saxihp0_fpd_aclk(zynq_ultra_ps_e_0_pl_clk0));
endmodule
