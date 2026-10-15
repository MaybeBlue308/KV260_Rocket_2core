// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module kv260_bd (
  spi0_sck,
  spi0_cs_n,
  spi0_mosi,
  spi0_miso,
  spi1_sck,
  spi1_cs_n,
  spi1_mosi,
  spi1_miso
);

  (* X_INTERFACE_IGNORE = "true" *)
  output spi0_sck;
  (* X_INTERFACE_IGNORE = "true" *)
  output spi0_cs_n;
  (* X_INTERFACE_IGNORE = "true" *)
  output spi0_mosi;
  (* X_INTERFACE_IGNORE = "true" *)
  input spi0_miso;
  (* X_INTERFACE_IGNORE = "true" *)
  output spi1_sck;
  (* X_INTERFACE_IGNORE = "true" *)
  output spi1_cs_n;
  (* X_INTERFACE_IGNORE = "true" *)
  output spi1_mosi;
  (* X_INTERFACE_IGNORE = "true" *)
  input spi1_miso;

  // stub module has no contents

endmodule
