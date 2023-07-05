`include "head.v"
`timescale 1ns / 1ps
module reg_hilo_w(
    input clk,
    input rst,
    input [`LENGTH-1:0] hi_in,
    input [`LENGTH-1:0] lo_in,
    input wen_in,

    output reg wen_out,
    output reg[`LENGTH-1:0] hi_out,
    output reg[`LENGTH-1:0] lo_out
);

always @(posedge clk) begin
    if (rst) begin
        hi_out     <= `INITIAL_VAL_32;
        lo_out     <= `INITIAL_VAL_32;
        wen_out    <= 0;
    end
    else  begin
        hi_out <= hi_in;
        lo_out <= lo_in;
        wen_out <= wen_in;
    end
end

endmodule