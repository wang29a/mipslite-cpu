`include "head.v"
`timescale 1ns / 1ps
module instruction_memory(
    input wire [`INST_MEM_ADDRESS+1:2] instruction_address,
    output wire [`LENGTH-1:0] instruction
);

reg[31:0] im[0:`INST_MEM_LENGTH-1];
assign instruction = im[instruction_address];

endmodule