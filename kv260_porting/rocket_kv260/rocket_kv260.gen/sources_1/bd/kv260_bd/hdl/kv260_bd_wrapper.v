//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Wed Oct 14 08:36:43 2026
//Host        : vsi.es running 64-bit Ubuntu 24.04.4 LTS
//Command     : generate_target kv260_bd_wrapper.bd
//Design      : kv260_bd_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module kv260_bd_wrapper
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

  wire spi0_cs_n;
  wire spi0_miso;
  wire spi0_mosi;
  wire spi0_sck;
  wire spi1_cs_n;
  wire spi1_miso;
  wire spi1_mosi;
  wire spi1_sck;

  kv260_bd kv260_bd_i
       (.spi0_cs_n(spi0_cs_n),
        .spi0_miso(spi0_miso),
        .spi0_mosi(spi0_mosi),
        .spi0_sck(spi0_sck),
        .spi1_cs_n(spi1_cs_n),
        .spi1_miso(spi1_miso),
        .spi1_mosi(spi1_mosi),
        .spi1_sck(spi1_sck));
endmodule
