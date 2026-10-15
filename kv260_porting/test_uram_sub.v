`timescale 1ns / 1ps

module test_uram_bank (
  input  [13:0] RW0_addr,
  input         RW0_clk,
  input  [63:0] RW0_wdata,
  output [63:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode
);
  (* ram_style = "ultra" *) reg [63:0] ram [0:16383];
  reg [13:0] ram_RW_0_r_addr_pipe_0;
  reg [63:0] rdata_pipe;

  always @(posedge RW0_clk) begin
    if (RW0_en & RW0_wmode) begin
      ram[RW0_addr] <= RW0_wdata;
    end
    if (RW0_en & ~RW0_wmode) begin
      ram_RW_0_r_addr_pipe_0 <= RW0_addr;
    end
  end
  assign RW0_rdata = ram[ram_RW_0_r_addr_pipe_0];
endmodule

module test_uram_scratch (
  input  [15:0] RW0_addr,
  input         RW0_clk,
  input  [7:0]  RW0_wdata,
  output [7:0]  RW0_rdata,
  input         RW0_en,
  input         RW0_wmode,
  input         RW0_wmask
);
  (* ram_style = "ultra" *) reg [7:0] ram [0:65535];
  reg [15:0] ram_RW_0_r_addr_pipe_0;

  always @(posedge RW0_clk) begin
    if (RW0_en & RW0_wmode & RW0_wmask) begin
      ram[RW0_addr] <= RW0_wdata;
    end
    if (RW0_en & ~RW0_wmode) begin
      ram_RW_0_r_addr_pipe_0 <= RW0_addr;
    end
  end
  assign RW0_rdata = ram[ram_RW_0_r_addr_pipe_0];
endmodule
