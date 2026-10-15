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


//------------------------------------------------------------------------------------
// Filename:    kv260_bd_zynq_ultra_ps_e_0_0_stub.sv
// Description: This HDL file is intended to be used with following simulators only:
//
//   Vivado Simulator (XSim)
//   Cadence Xcelium Simulator
//
//------------------------------------------------------------------------------------
`timescale 1ps/1ps

`ifdef XILINX_SIMULATOR

`ifndef XILINX_SIMULATOR_BITASBOOL
`define XILINX_SIMULATOR_BITASBOOL
typedef bit bit_as_bool;
`endif

(* SC_MODULE_EXPORT *)
module kv260_bd_zynq_ultra_ps_e_0_0 (
  input bit_as_bool saxihp0_fpd_aclk,
  input bit_as_bool saxigp2_aruser,
  input bit_as_bool saxigp2_awuser,
  input bit [5 : 0] saxigp2_awid,
  input bit [48 : 0] saxigp2_awaddr,
  input bit [7 : 0] saxigp2_awlen,
  input bit [2 : 0] saxigp2_awsize,
  input bit [1 : 0] saxigp2_awburst,
  input bit_as_bool saxigp2_awlock,
  input bit [3 : 0] saxigp2_awcache,
  input bit [2 : 0] saxigp2_awprot,
  input bit_as_bool saxigp2_awvalid,
  output bit_as_bool saxigp2_awready,
  input bit [63 : 0] saxigp2_wdata,
  input bit [7 : 0] saxigp2_wstrb,
  input bit_as_bool saxigp2_wlast,
  input bit_as_bool saxigp2_wvalid,
  output bit_as_bool saxigp2_wready,
  output bit [5 : 0] saxigp2_bid,
  output bit [1 : 0] saxigp2_bresp,
  output bit_as_bool saxigp2_bvalid,
  input bit_as_bool saxigp2_bready,
  input bit [5 : 0] saxigp2_arid,
  input bit [48 : 0] saxigp2_araddr,
  input bit [7 : 0] saxigp2_arlen,
  input bit [2 : 0] saxigp2_arsize,
  input bit [1 : 0] saxigp2_arburst,
  input bit_as_bool saxigp2_arlock,
  input bit [3 : 0] saxigp2_arcache,
  input bit [2 : 0] saxigp2_arprot,
  input bit_as_bool saxigp2_arvalid,
  output bit_as_bool saxigp2_arready,
  output bit [5 : 0] saxigp2_rid,
  output bit [63 : 0] saxigp2_rdata,
  output bit [1 : 0] saxigp2_rresp,
  output bit_as_bool saxigp2_rlast,
  output bit_as_bool saxigp2_rvalid,
  input bit_as_bool saxigp2_rready,
  input bit [3 : 0] saxigp2_awqos,
  input bit [3 : 0] saxigp2_arqos,
  input bit_as_bool saxi_lpd_aclk,
  input bit_as_bool saxigp6_aruser,
  input bit_as_bool saxigp6_awuser,
  input bit [5 : 0] saxigp6_awid,
  input bit [48 : 0] saxigp6_awaddr,
  input bit [7 : 0] saxigp6_awlen,
  input bit [2 : 0] saxigp6_awsize,
  input bit [1 : 0] saxigp6_awburst,
  input bit_as_bool saxigp6_awlock,
  input bit [3 : 0] saxigp6_awcache,
  input bit [2 : 0] saxigp6_awprot,
  input bit_as_bool saxigp6_awvalid,
  output bit_as_bool saxigp6_awready,
  input bit [63 : 0] saxigp6_wdata,
  input bit [7 : 0] saxigp6_wstrb,
  input bit_as_bool saxigp6_wlast,
  input bit_as_bool saxigp6_wvalid,
  output bit_as_bool saxigp6_wready,
  output bit [5 : 0] saxigp6_bid,
  output bit [1 : 0] saxigp6_bresp,
  output bit_as_bool saxigp6_bvalid,
  input bit_as_bool saxigp6_bready,
  input bit [5 : 0] saxigp6_arid,
  input bit [48 : 0] saxigp6_araddr,
  input bit [7 : 0] saxigp6_arlen,
  input bit [2 : 0] saxigp6_arsize,
  input bit [1 : 0] saxigp6_arburst,
  input bit_as_bool saxigp6_arlock,
  input bit [3 : 0] saxigp6_arcache,
  input bit [2 : 0] saxigp6_arprot,
  input bit_as_bool saxigp6_arvalid,
  output bit_as_bool saxigp6_arready,
  output bit [5 : 0] saxigp6_rid,
  output bit [63 : 0] saxigp6_rdata,
  output bit [1 : 0] saxigp6_rresp,
  output bit_as_bool saxigp6_rlast,
  output bit_as_bool saxigp6_rvalid,
  input bit_as_bool saxigp6_rready,
  input bit [3 : 0] saxigp6_awqos,
  input bit [3 : 0] saxigp6_arqos,
  input bit [7 : 0] emio_gpio_i,
  output bit [7 : 0] emio_gpio_o,
  output bit [7 : 0] emio_gpio_t,
  output bit_as_bool emio_uart0_txd,
  input bit_as_bool emio_uart0_rxd,
  input bit [0 : 0] pl_ps_irq0,
  output bit_as_bool pl_resetn0,
  output bit_as_bool pl_clk0
);
endmodule
`endif

`ifdef XCELIUM
(* XMSC_MODULE_EXPORT *)
module kv260_bd_zynq_ultra_ps_e_0_0 (saxihp0_fpd_aclk,saxigp2_aruser,saxigp2_awuser,saxigp2_awid,saxigp2_awaddr,saxigp2_awlen,saxigp2_awsize,saxigp2_awburst,saxigp2_awlock,saxigp2_awcache,saxigp2_awprot,saxigp2_awvalid,saxigp2_awready,saxigp2_wdata,saxigp2_wstrb,saxigp2_wlast,saxigp2_wvalid,saxigp2_wready,saxigp2_bid,saxigp2_bresp,saxigp2_bvalid,saxigp2_bready,saxigp2_arid,saxigp2_araddr,saxigp2_arlen,saxigp2_arsize,saxigp2_arburst,saxigp2_arlock,saxigp2_arcache,saxigp2_arprot,saxigp2_arvalid,saxigp2_arready,saxigp2_rid,saxigp2_rdata,saxigp2_rresp,saxigp2_rlast,saxigp2_rvalid,saxigp2_rready,saxigp2_awqos,saxigp2_arqos,saxi_lpd_aclk,saxigp6_aruser,saxigp6_awuser,saxigp6_awid,saxigp6_awaddr,saxigp6_awlen,saxigp6_awsize,saxigp6_awburst,saxigp6_awlock,saxigp6_awcache,saxigp6_awprot,saxigp6_awvalid,saxigp6_awready,saxigp6_wdata,saxigp6_wstrb,saxigp6_wlast,saxigp6_wvalid,saxigp6_wready,saxigp6_bid,saxigp6_bresp,saxigp6_bvalid,saxigp6_bready,saxigp6_arid,saxigp6_araddr,saxigp6_arlen,saxigp6_arsize,saxigp6_arburst,saxigp6_arlock,saxigp6_arcache,saxigp6_arprot,saxigp6_arvalid,saxigp6_arready,saxigp6_rid,saxigp6_rdata,saxigp6_rresp,saxigp6_rlast,saxigp6_rvalid,saxigp6_rready,saxigp6_awqos,saxigp6_arqos,emio_gpio_i,emio_gpio_o,emio_gpio_t,emio_uart0_txd,emio_uart0_rxd,pl_ps_irq0,pl_resetn0,pl_clk0)
(* integer foreign = "SystemC";
*);
  input bit saxihp0_fpd_aclk;
  input bit saxigp2_aruser;
  input bit saxigp2_awuser;
  input bit [5 : 0] saxigp2_awid;
  input bit [48 : 0] saxigp2_awaddr;
  input bit [7 : 0] saxigp2_awlen;
  input bit [2 : 0] saxigp2_awsize;
  input bit [1 : 0] saxigp2_awburst;
  input bit saxigp2_awlock;
  input bit [3 : 0] saxigp2_awcache;
  input bit [2 : 0] saxigp2_awprot;
  input bit saxigp2_awvalid;
  output wire saxigp2_awready;
  input bit [63 : 0] saxigp2_wdata;
  input bit [7 : 0] saxigp2_wstrb;
  input bit saxigp2_wlast;
  input bit saxigp2_wvalid;
  output wire saxigp2_wready;
  output wire [5 : 0] saxigp2_bid;
  output wire [1 : 0] saxigp2_bresp;
  output wire saxigp2_bvalid;
  input bit saxigp2_bready;
  input bit [5 : 0] saxigp2_arid;
  input bit [48 : 0] saxigp2_araddr;
  input bit [7 : 0] saxigp2_arlen;
  input bit [2 : 0] saxigp2_arsize;
  input bit [1 : 0] saxigp2_arburst;
  input bit saxigp2_arlock;
  input bit [3 : 0] saxigp2_arcache;
  input bit [2 : 0] saxigp2_arprot;
  input bit saxigp2_arvalid;
  output wire saxigp2_arready;
  output wire [5 : 0] saxigp2_rid;
  output wire [63 : 0] saxigp2_rdata;
  output wire [1 : 0] saxigp2_rresp;
  output wire saxigp2_rlast;
  output wire saxigp2_rvalid;
  input bit saxigp2_rready;
  input bit [3 : 0] saxigp2_awqos;
  input bit [3 : 0] saxigp2_arqos;
  input bit saxi_lpd_aclk;
  input bit saxigp6_aruser;
  input bit saxigp6_awuser;
  input bit [5 : 0] saxigp6_awid;
  input bit [48 : 0] saxigp6_awaddr;
  input bit [7 : 0] saxigp6_awlen;
  input bit [2 : 0] saxigp6_awsize;
  input bit [1 : 0] saxigp6_awburst;
  input bit saxigp6_awlock;
  input bit [3 : 0] saxigp6_awcache;
  input bit [2 : 0] saxigp6_awprot;
  input bit saxigp6_awvalid;
  output wire saxigp6_awready;
  input bit [63 : 0] saxigp6_wdata;
  input bit [7 : 0] saxigp6_wstrb;
  input bit saxigp6_wlast;
  input bit saxigp6_wvalid;
  output wire saxigp6_wready;
  output wire [5 : 0] saxigp6_bid;
  output wire [1 : 0] saxigp6_bresp;
  output wire saxigp6_bvalid;
  input bit saxigp6_bready;
  input bit [5 : 0] saxigp6_arid;
  input bit [48 : 0] saxigp6_araddr;
  input bit [7 : 0] saxigp6_arlen;
  input bit [2 : 0] saxigp6_arsize;
  input bit [1 : 0] saxigp6_arburst;
  input bit saxigp6_arlock;
  input bit [3 : 0] saxigp6_arcache;
  input bit [2 : 0] saxigp6_arprot;
  input bit saxigp6_arvalid;
  output wire saxigp6_arready;
  output wire [5 : 0] saxigp6_rid;
  output wire [63 : 0] saxigp6_rdata;
  output wire [1 : 0] saxigp6_rresp;
  output wire saxigp6_rlast;
  output wire saxigp6_rvalid;
  input bit saxigp6_rready;
  input bit [3 : 0] saxigp6_awqos;
  input bit [3 : 0] saxigp6_arqos;
  input bit [7 : 0] emio_gpio_i;
  output wire [7 : 0] emio_gpio_o;
  output wire [7 : 0] emio_gpio_t;
  output wire emio_uart0_txd;
  input bit emio_uart0_rxd;
  input bit [0 : 0] pl_ps_irq0;
  output wire pl_resetn0;
  output wire pl_clk0;
endmodule
`endif
