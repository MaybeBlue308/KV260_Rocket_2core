// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2026 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:kv260_rocket_wrapper:1.0
// IP Revision: 1

(* X_CORE_INFO = "kv260_rocket_wrapper,Vivado 2025.2" *)
(* CHECK_LICENSE_TYPE = "kv260_bd_kv260_rocket_wrapper_0_0,kv260_rocket_wrapper,{}" *)
(* CORE_GENERATION_INFO = "kv260_bd_kv260_rocket_wrapper_0_0,kv260_rocket_wrapper,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=kv260_rocket_wrapper,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,MEM_PS_BASE=0x0800000000}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module kv260_bd_kv260_rocket_wrapper_0_0 (
  clk,
  resetn,
  ps_gpio_o,
  ps_gpio_i,
  uart_txd,
  uart_rxd,
  spi0_sck,
  spi0_cs_n,
  spi0_mosi,
  spi0_miso,
  spi1_sck,
  spi1_cs_n,
  spi1_mosi,
  spi1_miso,
  m_axi_mem_awid,
  m_axi_mem_awaddr,
  m_axi_mem_awlen,
  m_axi_mem_awsize,
  m_axi_mem_awburst,
  m_axi_mem_awlock,
  m_axi_mem_awcache,
  m_axi_mem_awprot,
  m_axi_mem_awqos,
  m_axi_mem_awvalid,
  m_axi_mem_awready,
  m_axi_mem_wdata,
  m_axi_mem_wstrb,
  m_axi_mem_wlast,
  m_axi_mem_wvalid,
  m_axi_mem_wready,
  m_axi_mem_bid,
  m_axi_mem_bresp,
  m_axi_mem_bvalid,
  m_axi_mem_bready,
  m_axi_mem_arid,
  m_axi_mem_araddr,
  m_axi_mem_arlen,
  m_axi_mem_arsize,
  m_axi_mem_arburst,
  m_axi_mem_arlock,
  m_axi_mem_arcache,
  m_axi_mem_arprot,
  m_axi_mem_arqos,
  m_axi_mem_arvalid,
  m_axi_mem_arready,
  m_axi_mem_rid,
  m_axi_mem_rdata,
  m_axi_mem_rresp,
  m_axi_mem_rlast,
  m_axi_mem_rvalid,
  m_axi_mem_rready,
  m_axi_mmio_awid,
  m_axi_mmio_awaddr,
  m_axi_mmio_awlen,
  m_axi_mmio_awsize,
  m_axi_mmio_awburst,
  m_axi_mmio_awlock,
  m_axi_mmio_awcache,
  m_axi_mmio_awprot,
  m_axi_mmio_awqos,
  m_axi_mmio_awvalid,
  m_axi_mmio_awready,
  m_axi_mmio_wdata,
  m_axi_mmio_wstrb,
  m_axi_mmio_wlast,
  m_axi_mmio_wvalid,
  m_axi_mmio_wready,
  m_axi_mmio_bid,
  m_axi_mmio_bresp,
  m_axi_mmio_bvalid,
  m_axi_mmio_bready,
  m_axi_mmio_arid,
  m_axi_mmio_araddr,
  m_axi_mmio_arlen,
  m_axi_mmio_arsize,
  m_axi_mmio_arburst,
  m_axi_mmio_arlock,
  m_axi_mmio_arcache,
  m_axi_mmio_arprot,
  m_axi_mmio_arqos,
  m_axi_mmio_arvalid,
  m_axi_mmio_arready,
  m_axi_mmio_rid,
  m_axi_mmio_rdata,
  m_axi_mmio_rresp,
  m_axi_mmio_rlast,
  m_axi_mmio_rvalid,
  m_axi_mmio_rready
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF m_axi_mem:m_axi_mmio, ASSOCIATED_RESET resetn, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN kv260_bd_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
input wire clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 resetn RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire resetn;
input wire [7 : 0] ps_gpio_o;
output wire [7 : 0] ps_gpio_i;
output wire uart_txd;
input wire uart_rxd;
output wire spi0_sck;
output wire spi0_cs_n;
output wire spi0_mosi;
input wire spi0_miso;
output wire spi1_sck;
output wire spi1_cs_n;
output wire spi1_mosi;
input wire spi1_miso;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWID" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_mem, DATA_WIDTH 64, PROTOCOL AXI4, FREQ_HZ 99999001, ID_WIDTH 4, ADDR_WIDTH 40, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN kv260_bd_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, N\
UM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
output wire [3 : 0] m_axi_mem_awid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWADDR" *)
output wire [39 : 0] m_axi_mem_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWLEN" *)
output wire [7 : 0] m_axi_mem_awlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWSIZE" *)
output wire [2 : 0] m_axi_mem_awsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWBURST" *)
output wire [1 : 0] m_axi_mem_awburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWLOCK" *)
output wire m_axi_mem_awlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWCACHE" *)
output wire [3 : 0] m_axi_mem_awcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWPROT" *)
output wire [2 : 0] m_axi_mem_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWQOS" *)
output wire [3 : 0] m_axi_mem_awqos;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWVALID" *)
output wire m_axi_mem_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem AWREADY" *)
input wire m_axi_mem_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem WDATA" *)
output wire [63 : 0] m_axi_mem_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem WSTRB" *)
output wire [7 : 0] m_axi_mem_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem WLAST" *)
output wire m_axi_mem_wlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem WVALID" *)
output wire m_axi_mem_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem WREADY" *)
input wire m_axi_mem_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem BID" *)
input wire [3 : 0] m_axi_mem_bid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem BRESP" *)
input wire [1 : 0] m_axi_mem_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem BVALID" *)
input wire m_axi_mem_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem BREADY" *)
output wire m_axi_mem_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARID" *)
output wire [3 : 0] m_axi_mem_arid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARADDR" *)
output wire [39 : 0] m_axi_mem_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARLEN" *)
output wire [7 : 0] m_axi_mem_arlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARSIZE" *)
output wire [2 : 0] m_axi_mem_arsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARBURST" *)
output wire [1 : 0] m_axi_mem_arburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARLOCK" *)
output wire m_axi_mem_arlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARCACHE" *)
output wire [3 : 0] m_axi_mem_arcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARPROT" *)
output wire [2 : 0] m_axi_mem_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARQOS" *)
output wire [3 : 0] m_axi_mem_arqos;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARVALID" *)
output wire m_axi_mem_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem ARREADY" *)
input wire m_axi_mem_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RID" *)
input wire [3 : 0] m_axi_mem_rid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RDATA" *)
input wire [63 : 0] m_axi_mem_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RRESP" *)
input wire [1 : 0] m_axi_mem_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RLAST" *)
input wire m_axi_mem_rlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RVALID" *)
input wire m_axi_mem_rvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mem RREADY" *)
output wire m_axi_mem_rready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWID" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_mmio, DATA_WIDTH 64, PROTOCOL AXI4, FREQ_HZ 99999001, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN kv260_bd_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, \
NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
output wire [3 : 0] m_axi_mmio_awid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWADDR" *)
output wire [31 : 0] m_axi_mmio_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWLEN" *)
output wire [7 : 0] m_axi_mmio_awlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWSIZE" *)
output wire [2 : 0] m_axi_mmio_awsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWBURST" *)
output wire [1 : 0] m_axi_mmio_awburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWLOCK" *)
output wire m_axi_mmio_awlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWCACHE" *)
output wire [3 : 0] m_axi_mmio_awcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWPROT" *)
output wire [2 : 0] m_axi_mmio_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWQOS" *)
output wire [3 : 0] m_axi_mmio_awqos;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWVALID" *)
output wire m_axi_mmio_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio AWREADY" *)
input wire m_axi_mmio_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio WDATA" *)
output wire [63 : 0] m_axi_mmio_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio WSTRB" *)
output wire [7 : 0] m_axi_mmio_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio WLAST" *)
output wire m_axi_mmio_wlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio WVALID" *)
output wire m_axi_mmio_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio WREADY" *)
input wire m_axi_mmio_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio BID" *)
input wire [3 : 0] m_axi_mmio_bid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio BRESP" *)
input wire [1 : 0] m_axi_mmio_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio BVALID" *)
input wire m_axi_mmio_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio BREADY" *)
output wire m_axi_mmio_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARID" *)
output wire [3 : 0] m_axi_mmio_arid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARADDR" *)
output wire [31 : 0] m_axi_mmio_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARLEN" *)
output wire [7 : 0] m_axi_mmio_arlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARSIZE" *)
output wire [2 : 0] m_axi_mmio_arsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARBURST" *)
output wire [1 : 0] m_axi_mmio_arburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARLOCK" *)
output wire m_axi_mmio_arlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARCACHE" *)
output wire [3 : 0] m_axi_mmio_arcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARPROT" *)
output wire [2 : 0] m_axi_mmio_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARQOS" *)
output wire [3 : 0] m_axi_mmio_arqos;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARVALID" *)
output wire m_axi_mmio_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio ARREADY" *)
input wire m_axi_mmio_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RID" *)
input wire [3 : 0] m_axi_mmio_rid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RDATA" *)
input wire [63 : 0] m_axi_mmio_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RRESP" *)
input wire [1 : 0] m_axi_mmio_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RLAST" *)
input wire m_axi_mmio_rlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RVALID" *)
input wire m_axi_mmio_rvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_mmio RREADY" *)
output wire m_axi_mmio_rready;

  kv260_rocket_wrapper #(
    .MEM_PS_BASE(40'H0800000000)
  ) inst (
    .clk(clk),
    .resetn(resetn),
    .ps_gpio_o(ps_gpio_o),
    .ps_gpio_i(ps_gpio_i),
    .uart_txd(uart_txd),
    .uart_rxd(uart_rxd),
    .spi0_sck(spi0_sck),
    .spi0_cs_n(spi0_cs_n),
    .spi0_mosi(spi0_mosi),
    .spi0_miso(spi0_miso),
    .spi1_sck(spi1_sck),
    .spi1_cs_n(spi1_cs_n),
    .spi1_mosi(spi1_mosi),
    .spi1_miso(spi1_miso),
    .m_axi_mem_awid(m_axi_mem_awid),
    .m_axi_mem_awaddr(m_axi_mem_awaddr),
    .m_axi_mem_awlen(m_axi_mem_awlen),
    .m_axi_mem_awsize(m_axi_mem_awsize),
    .m_axi_mem_awburst(m_axi_mem_awburst),
    .m_axi_mem_awlock(m_axi_mem_awlock),
    .m_axi_mem_awcache(m_axi_mem_awcache),
    .m_axi_mem_awprot(m_axi_mem_awprot),
    .m_axi_mem_awqos(m_axi_mem_awqos),
    .m_axi_mem_awvalid(m_axi_mem_awvalid),
    .m_axi_mem_awready(m_axi_mem_awready),
    .m_axi_mem_wdata(m_axi_mem_wdata),
    .m_axi_mem_wstrb(m_axi_mem_wstrb),
    .m_axi_mem_wlast(m_axi_mem_wlast),
    .m_axi_mem_wvalid(m_axi_mem_wvalid),
    .m_axi_mem_wready(m_axi_mem_wready),
    .m_axi_mem_bid(m_axi_mem_bid),
    .m_axi_mem_bresp(m_axi_mem_bresp),
    .m_axi_mem_bvalid(m_axi_mem_bvalid),
    .m_axi_mem_bready(m_axi_mem_bready),
    .m_axi_mem_arid(m_axi_mem_arid),
    .m_axi_mem_araddr(m_axi_mem_araddr),
    .m_axi_mem_arlen(m_axi_mem_arlen),
    .m_axi_mem_arsize(m_axi_mem_arsize),
    .m_axi_mem_arburst(m_axi_mem_arburst),
    .m_axi_mem_arlock(m_axi_mem_arlock),
    .m_axi_mem_arcache(m_axi_mem_arcache),
    .m_axi_mem_arprot(m_axi_mem_arprot),
    .m_axi_mem_arqos(m_axi_mem_arqos),
    .m_axi_mem_arvalid(m_axi_mem_arvalid),
    .m_axi_mem_arready(m_axi_mem_arready),
    .m_axi_mem_rid(m_axi_mem_rid),
    .m_axi_mem_rdata(m_axi_mem_rdata),
    .m_axi_mem_rresp(m_axi_mem_rresp),
    .m_axi_mem_rlast(m_axi_mem_rlast),
    .m_axi_mem_rvalid(m_axi_mem_rvalid),
    .m_axi_mem_rready(m_axi_mem_rready),
    .m_axi_mmio_awid(m_axi_mmio_awid),
    .m_axi_mmio_awaddr(m_axi_mmio_awaddr),
    .m_axi_mmio_awlen(m_axi_mmio_awlen),
    .m_axi_mmio_awsize(m_axi_mmio_awsize),
    .m_axi_mmio_awburst(m_axi_mmio_awburst),
    .m_axi_mmio_awlock(m_axi_mmio_awlock),
    .m_axi_mmio_awcache(m_axi_mmio_awcache),
    .m_axi_mmio_awprot(m_axi_mmio_awprot),
    .m_axi_mmio_awqos(m_axi_mmio_awqos),
    .m_axi_mmio_awvalid(m_axi_mmio_awvalid),
    .m_axi_mmio_awready(m_axi_mmio_awready),
    .m_axi_mmio_wdata(m_axi_mmio_wdata),
    .m_axi_mmio_wstrb(m_axi_mmio_wstrb),
    .m_axi_mmio_wlast(m_axi_mmio_wlast),
    .m_axi_mmio_wvalid(m_axi_mmio_wvalid),
    .m_axi_mmio_wready(m_axi_mmio_wready),
    .m_axi_mmio_bid(m_axi_mmio_bid),
    .m_axi_mmio_bresp(m_axi_mmio_bresp),
    .m_axi_mmio_bvalid(m_axi_mmio_bvalid),
    .m_axi_mmio_bready(m_axi_mmio_bready),
    .m_axi_mmio_arid(m_axi_mmio_arid),
    .m_axi_mmio_araddr(m_axi_mmio_araddr),
    .m_axi_mmio_arlen(m_axi_mmio_arlen),
    .m_axi_mmio_arsize(m_axi_mmio_arsize),
    .m_axi_mmio_arburst(m_axi_mmio_arburst),
    .m_axi_mmio_arlock(m_axi_mmio_arlock),
    .m_axi_mmio_arcache(m_axi_mmio_arcache),
    .m_axi_mmio_arprot(m_axi_mmio_arprot),
    .m_axi_mmio_arqos(m_axi_mmio_arqos),
    .m_axi_mmio_arvalid(m_axi_mmio_arvalid),
    .m_axi_mmio_arready(m_axi_mmio_arready),
    .m_axi_mmio_rid(m_axi_mmio_rid),
    .m_axi_mmio_rdata(m_axi_mmio_rdata),
    .m_axi_mmio_rresp(m_axi_mmio_rresp),
    .m_axi_mmio_rlast(m_axi_mmio_rlast),
    .m_axi_mmio_rvalid(m_axi_mmio_rvalid),
    .m_axi_mmio_rready(m_axi_mmio_rready)
  );
endmodule
