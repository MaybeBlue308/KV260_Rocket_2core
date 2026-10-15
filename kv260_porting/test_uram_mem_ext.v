`timescale 1ns / 1ps

module test_uram_mem_ext (
  input  [15:0] RW0_addr,
  input         RW0_clk,
  input  [63:0] RW0_wdata,
  output [63:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode,
  input  [7:0]  RW0_wmask
);
  (* ram_style = "ultra" *) reg [63:0] ram [0:65535];
  reg [15:0] raddr_reg;

  always @(posedge RW0_clk) begin
    if (RW0_en & RW0_wmode) begin
      if (RW0_wmask[0]) ram[RW0_addr][7:0]   <= RW0_wdata[7:0];
      if (RW0_wmask[1]) ram[RW0_addr][15:8]  <= RW0_wdata[15:8];
      if (RW0_wmask[2]) ram[RW0_addr][23:16] <= RW0_wdata[23:16];
      if (RW0_wmask[3]) ram[RW0_addr][31:24] <= RW0_wdata[31:24];
      if (RW0_wmask[4]) ram[RW0_addr][39:32] <= RW0_wdata[39:32];
      if (RW0_wmask[5]) ram[RW0_addr][47:40] <= RW0_wdata[47:40];
      if (RW0_wmask[6]) ram[RW0_addr][55:48] <= RW0_wdata[55:48];
      if (RW0_wmask[7]) ram[RW0_addr][63:56] <= RW0_wdata[63:56];
    end
    if (RW0_en & ~RW0_wmode) begin
      raddr_reg <= RW0_addr;
    end
  end
  assign RW0_rdata = ram[raddr_reg];
endmodule
