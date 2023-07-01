// 触发器模板
module Reg #(parameter WIDTH = 1, parameter RESET_VAL = 0) (
  input clk,
  input rst,
  input wen,
  input [WIDTH-1:0] din,
  output reg [WIDTH-1:0] dout
);
  always @(posedge clk) begin
    if (rst) dout <= RESET_VAL;
    else if (wen) dout <= din;
    // else dout <= din;
  end
endmodule