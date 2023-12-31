`include "head.v"
`timescale 1ns / 1ps
module alu_control(
    input wire [`ALU_OP_LENGTH-1:0] aluop,
    input wire [5:0] func,
    output wire [`ALU_CONTROL_LENGTH-1:0] alu_control
);

wire [`ALU_CONTROL_LENGTH-1:0] r_type_alu;
//non-R-TYPE
MuxKey #(7, `ALU_OP_LENGTH, `ALU_CONTROL_LENGTH) mux_nr(alu_control, aluop, {
    `ALU_OP_ADD, `ALU_CONTROL_ADD,
    `ALU_OP_SUB, `ALU_CONTROL_SUBU,
    `ALU_OP_ORI, `ALU_CONTROL_ORI,
    `ALU_OP_R_TYPE, r_type_alu,
    `ALU_OP_XORI, `ALU_CONTROL_XORI,
    `ALU_OP_ANDI, `ALU_CONTROL_ANDI,
    `ALU_OP_ADDI, `ALU_CONTROL_ADDI
});

MuxKey #(13, 6, `ALU_CONTROL_LENGTH) mux_r(r_type_alu, func, {
    `FUNC_ADDU, `ALU_CONTROL_ADDU,
    `FUNC_SUBU, `ALU_CONTROL_SUBU,
    `FUNC_AND,  `ALU_CONTROL_AND,
    `FUNC_XOR,  `ALU_CONTROL_XOR,
    `FUNC_OR,   `ALU_CONTROL_OR,
    `FUNC_NOR,  `ALU_CONTROL_NOR,
    `FUNC_MULTU, `ALU_CONTROL_MULTU,
    `FUNC_DIVU, `ALU_CONTROL_DIVU,
    `FUNC_MTHI, `ALU_CONTROL_MTHI,
    `FUNC_MTLO, `ALU_CONTROL_MTLO,
    `FUNC_MFHI, `ALU_CONTROL_MFHI,
    `FUNC_MFLO, `ALU_CONTROL_MFLO,
    `FUNC_MULT, `ALU_CONTROL_MULT
});
endmodule