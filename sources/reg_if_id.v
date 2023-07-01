`include "head.v"
`timescale 1ns / 1ps
module reg_if_id(
    input wire clk,
    input wire rst,
    input wire flush,
    input wire wen,
    input wire [`LENGTH-1:0]     instruction_in,
    input wire [`LENGTH-1:0]     pc_4_in,
    // input [`LENGTH-1:0]     pc_4
    output reg [`LENGTH-1:0]    instruction_out,
    output reg [`LENGTH-1:0]    pc_4_out
);

always @(posedge clk) begin
    if (rst) begin
        instruction_out <= `INITIAL_VAL;
        pc_4_out <= `INITIAL_VAL;
    end
    else if (flush) begin
        instruction_out <= `INITIAL_VAL;
        pc_4_out <= pc_4_in;
    end
    else if (wen) begin
        instruction_out <= instruction_in;
        pc_4_out <= pc_4_in;
    end
end

endmodule