`include "head.v"
`timescale 1ns / 1ps
module reg_hilo_r(
    input clk,
    input rst,
    input [`LENGTH-1:0] hi_in,
    input [`LENGTH-1:0] lo_in,

    output reg[`LENGTH-1:0] hi_out,
    output reg[`LENGTH-1:0] lo_out
);

always @(posedge clk) begin
    if (rst) begin
        hi_out     <= `INITIAL_VAL_32;
        lo_out     <= `INITIAL_VAL_32;
    end
    else  begin
        hi_out <= hi_in;
        lo_out <= lo_in;
    end
end

endmodule