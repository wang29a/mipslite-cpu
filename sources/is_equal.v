`include "head.v"
`timescale 1ns / 1ps
module is_equal(
    input wire [`LENGTH-1:0] read_data_1,
    input wire [`LENGTH-1:0] read_data_2,
    output wire equal
);
wire tmp;
assign tmp = read_data_1 == read_data_2;
assign equal = (tmp) ?1:0;
endmodule