`include "head.v"
`timescale 1ns / 1ps
module hilo_reg(
    input clk,
    input rst,
    input wen,
    input [`LENGTH-1:0] w_lo, w_hi,
    output reg[`LENGTH-1:0] lo, hi
);
always@(posedge clk) begin
    if(rst)begin
      lo <= `INITIAL_VAL_32;
      hi <= `INITIAL_VAL_32;
    end
    else if(wen)begin
      lo <= w_lo;
      hi <= w_hi;
    end
end
endmodule