// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Thu Oct 15 09:17:44 2026
// Host        : vsi.es running 64-bit Ubuntu 24.04.4 LTS
// Command     : write_verilog -force -mode synth_stub
//               /ssd3/workspaces-ssd/khoant17/workspace/kv260_porting/rocket_kv260_lnx/rocket_kv260.gen/sources_1/bd/kv260_bd/ip/kv260_bd_kv260_rocket_wrapper_0_0/kv260_bd_kv260_rocket_wrapper_0_0_stub.v
// Design      : kv260_bd_kv260_rocket_wrapper_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xck26-sfvc784-2LV-c
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "kv260_bd_kv260_rocket_wrapper_0_0,kv260_rocket_wrapper,{}" *) (* CORE_GENERATION_INFO = "kv260_bd_kv260_rocket_wrapper_0_0,kv260_rocket_wrapper,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=kv260_rocket_wrapper,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,MEM_PS_BASE=0x0800000000}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "kv260_rocket_wrapper,Vivado 2025.2" *) 
module kv260_bd_kv260_rocket_wrapper_0_0(clk, resetn, ps_gpio_o, ps_gpio_i, uart_txd, 
  uart_rxd, spi0_sck, spi0_cs_n, spi0_mosi, spi0_miso, spi1_sck, spi1_cs_n, spi1_mosi, spi1_miso, 
  m_axi_mem_awid, m_axi_mem_awaddr, m_axi_mem_awlen, m_axi_mem_awsize, m_axi_mem_awburst, 
  m_axi_mem_awlock, m_axi_mem_awcache, m_axi_mem_awprot, m_axi_mem_awqos, 
  m_axi_mem_awvalid, m_axi_mem_awready, m_axi_mem_wdata, m_axi_mem_wstrb, m_axi_mem_wlast, 
  m_axi_mem_wvalid, m_axi_mem_wready, m_axi_mem_bid, m_axi_mem_bresp, m_axi_mem_bvalid, 
  m_axi_mem_bready, m_axi_mem_arid, m_axi_mem_araddr, m_axi_mem_arlen, m_axi_mem_arsize, 
  m_axi_mem_arburst, m_axi_mem_arlock, m_axi_mem_arcache, m_axi_mem_arprot, 
  m_axi_mem_arqos, m_axi_mem_arvalid, m_axi_mem_arready, m_axi_mem_rid, m_axi_mem_rdata, 
  m_axi_mem_rresp, m_axi_mem_rlast, m_axi_mem_rvalid, m_axi_mem_rready, m_axi_mmio_awid, 
  m_axi_mmio_awaddr, m_axi_mmio_awlen, m_axi_mmio_awsize, m_axi_mmio_awburst, 
  m_axi_mmio_awlock, m_axi_mmio_awcache, m_axi_mmio_awprot, m_axi_mmio_awqos, 
  m_axi_mmio_awvalid, m_axi_mmio_awready, m_axi_mmio_wdata, m_axi_mmio_wstrb, 
  m_axi_mmio_wlast, m_axi_mmio_wvalid, m_axi_mmio_wready, m_axi_mmio_bid, m_axi_mmio_bresp, 
  m_axi_mmio_bvalid, m_axi_mmio_bready, m_axi_mmio_arid, m_axi_mmio_araddr, 
  m_axi_mmio_arlen, m_axi_mmio_arsize, m_axi_mmio_arburst, m_axi_mmio_arlock, 
  m_axi_mmio_arcache, m_axi_mmio_arprot, m_axi_mmio_arqos, m_axi_mmio_arvalid, 
  m_axi_mmio_arready, m_axi_mmio_rid, m_axi_mmio_rdata, m_axi_mmio_rresp, m_axi_mmio_rlast, 
  m_axi_mmio_rvalid, m_axi_mmio_rready)
/* synthesis syn_black_box black_box_pad_pin="resetn,ps_gpio_o[7:0],ps_gpio_i[7:0],uart_txd,uart_rxd,spi0_sck,spi0_cs_n,spi0_mosi,spi0_miso,spi1_sck,spi1_cs_n,spi1_mosi,spi1_miso,m_axi_mem_awid[3:0],m_axi_mem_awaddr[39:0],m_axi_mem_awlen[7:0],m_axi_mem_awsize[2:0],m_axi_mem_awburst[1:0],m_axi_mem_awlock,m_axi_mem_awcache[3:0],m_axi_mem_awprot[2:0],m_axi_mem_awqos[3:0],m_axi_mem_awvalid,m_axi_mem_awready,m_axi_mem_wdata[63:0],m_axi_mem_wstrb[7:0],m_axi_mem_wlast,m_axi_mem_wvalid,m_axi_mem_wready,m_axi_mem_bid[3:0],m_axi_mem_bresp[1:0],m_axi_mem_bvalid,m_axi_mem_bready,m_axi_mem_arid[3:0],m_axi_mem_araddr[39:0],m_axi_mem_arlen[7:0],m_axi_mem_arsize[2:0],m_axi_mem_arburst[1:0],m_axi_mem_arlock,m_axi_mem_arcache[3:0],m_axi_mem_arprot[2:0],m_axi_mem_arqos[3:0],m_axi_mem_arvalid,m_axi_mem_arready,m_axi_mem_rid[3:0],m_axi_mem_rdata[63:0],m_axi_mem_rresp[1:0],m_axi_mem_rlast,m_axi_mem_rvalid,m_axi_mem_rready,m_axi_mmio_awid[3:0],m_axi_mmio_awaddr[31:0],m_axi_mmio_awlen[7:0],m_axi_mmio_awsize[2:0],m_axi_mmio_awburst[1:0],m_axi_mmio_awlock,m_axi_mmio_awcache[3:0],m_axi_mmio_awprot[2:0],m_axi_mmio_awqos[3:0],m_axi_mmio_awvalid,m_axi_mmio_awready,m_axi_mmio_wdata[63:0],m_axi_mmio_wstrb[7:0],m_axi_mmio_wlast,m_axi_mmio_wvalid,m_axi_mmio_wready,m_axi_mmio_bid[3:0],m_axi_mmio_bresp[1:0],m_axi_mmio_bvalid,m_axi_mmio_bready,m_axi_mmio_arid[3:0],m_axi_mmio_araddr[31:0],m_axi_mmio_arlen[7:0],m_axi_mmio_arsize[2:0],m_axi_mmio_arburst[1:0],m_axi_mmio_arlock,m_axi_mmio_arcache[3:0],m_axi_mmio_arprot[2:0],m_axi_mmio_arqos[3:0],m_axi_mmio_arvalid,m_axi_mmio_arready,m_axi_mmio_rid[3:0],m_axi_mmio_rdata[63:0],m_axi_mmio_rresp[1:0],m_axi_mmio_rlast,m_axi_mmio_rvalid,m_axi_mmio_rready" */
/* synthesis syn_force_seq_prim="clk" */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF m_axi_mem:m_axi_mmio, ASSOCIATED_RESET resetn, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN kv260_bd_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *) input clk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 resetn RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input resetn;
  input [7:0]ps_gpio_o;
  output [7:0]ps_gpio_i;
  output uart_txd;
  input uart_rxd;
  output spi0_sck;
  output spi0_cs_n;
  output spi0_mosi;
  input spi0_miso;
  output spi1_sck;
  output spi1_cs_n;
  output spi1_mosi;
  input spi1_miso;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWID" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_mem, DATA_WIDTH 64, PROTOCOL AXI4, FREQ_HZ 99999001, ID_WIDTH 4, ADDR_WIDTH 40, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN kv260_bd_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [3:0]m_axi_mem_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWADDR" *) output [39:0]m_axi_mem_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWLEN" *) output [7:0]m_axi_mem_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWSIZE" *) output [2:0]m_axi_mem_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWBURST" *) output [1:0]m_axi_mem_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWLOCK" *) output m_axi_mem_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWCACHE" *) output [3:0]m_axi_mem_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWPROT" *) output [2:0]m_axi_mem_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWQOS" *) output [3:0]m_axi_mem_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWVALID" *) output m_axi_mem_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWREADY" *) input m_axi_mem_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem WDATA" *) output [63:0]m_axi_mem_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem WSTRB" *) output [7:0]m_axi_mem_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem WLAST" *) output m_axi_mem_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem WVALID" *) output m_axi_mem_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem WREADY" *) input m_axi_mem_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem BID" *) input [3:0]m_axi_mem_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem BRESP" *) input [1:0]m_axi_mem_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem BVALID" *) input m_axi_mem_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem BREADY" *) output m_axi_mem_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARID" *) output [3:0]m_axi_mem_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARADDR" *) output [39:0]m_axi_mem_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARLEN" *) output [7:0]m_axi_mem_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARSIZE" *) output [2:0]m_axi_mem_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARBURST" *) output [1:0]m_axi_mem_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARLOCK" *) output m_axi_mem_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARCACHE" *) output [3:0]m_axi_mem_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARPROT" *) output [2:0]m_axi_mem_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARQOS" *) output [3:0]m_axi_mem_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARVALID" *) output m_axi_mem_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARREADY" *) input m_axi_mem_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RID" *) input [3:0]m_axi_mem_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RDATA" *) input [63:0]m_axi_mem_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RRESP" *) input [1:0]m_axi_mem_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RLAST" *) input m_axi_mem_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RVALID" *) input m_axi_mem_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RREADY" *) output m_axi_mem_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWID" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_mmio, DATA_WIDTH 64, PROTOCOL AXI4, FREQ_HZ 99999001, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN kv260_bd_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [3:0]m_axi_mmio_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWADDR" *) output [31:0]m_axi_mmio_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWLEN" *) output [7:0]m_axi_mmio_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWSIZE" *) output [2:0]m_axi_mmio_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWBURST" *) output [1:0]m_axi_mmio_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWLOCK" *) output m_axi_mmio_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWCACHE" *) output [3:0]m_axi_mmio_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWPROT" *) output [2:0]m_axi_mmio_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWQOS" *) output [3:0]m_axi_mmio_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWVALID" *) output m_axi_mmio_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWREADY" *) input m_axi_mmio_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio WDATA" *) output [63:0]m_axi_mmio_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio WSTRB" *) output [7:0]m_axi_mmio_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio WLAST" *) output m_axi_mmio_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio WVALID" *) output m_axi_mmio_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio WREADY" *) input m_axi_mmio_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio BID" *) input [3:0]m_axi_mmio_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio BRESP" *) input [1:0]m_axi_mmio_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio BVALID" *) input m_axi_mmio_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio BREADY" *) output m_axi_mmio_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARID" *) output [3:0]m_axi_mmio_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARADDR" *) output [31:0]m_axi_mmio_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARLEN" *) output [7:0]m_axi_mmio_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARSIZE" *) output [2:0]m_axi_mmio_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARBURST" *) output [1:0]m_axi_mmio_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARLOCK" *) output m_axi_mmio_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARCACHE" *) output [3:0]m_axi_mmio_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARPROT" *) output [2:0]m_axi_mmio_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARQOS" *) output [3:0]m_axi_mmio_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARVALID" *) output m_axi_mmio_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARREADY" *) input m_axi_mmio_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RID" *) input [3:0]m_axi_mmio_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RDATA" *) input [63:0]m_axi_mmio_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RRESP" *) input [1:0]m_axi_mmio_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RLAST" *) input m_axi_mmio_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RVALID" *) input m_axi_mmio_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RREADY" *) output m_axi_mmio_rready;
endmodule
