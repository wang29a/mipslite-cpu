`include "head.v"

module alu_control(
    input [1:0] aluop,
    input [5:0] func,
    output [`ALU_CONLROL_LENGTH-1:0]   alu_conlrol
);

wire [`ALU_CONLROL_LENGTH-1:0] r_type_alu;
//non-R-TYPE
MuxKey #(4, 2, `ALU_CONLROL_LENGTH) (alu_conlrol, aluop, {
    `ALU_OP_ADD, `ALU_CONLROL_ADD,
    `ALU_OP_SUB, `ALU_CONLROL_SUBU,
    `ALU_OP_ORI, `ALU_CONLROL_ORI,
    `ALU_OP_R_TYPE, r_type_alu
});

MuxKey #(2, 5, `ALU_CONLROL_LENGTH) (r_type_alu, func, {
    `FUNC_ADDU, `ALU_CONLROL_ADDU,
    `FUNC_SUBU, `ALU_CONLROL_SUBU
});

endmodule