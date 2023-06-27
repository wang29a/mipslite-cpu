`include "head.v"

module alu_control(
    input wire [1:0] aluop,
    input wire [5:0] func,
    output wire [`ALU_CONTROL_LENGTH-1:0] alu_control
);

wire [`ALU_CONTROL_LENGTH-1:0] r_type_alu;
//non-R-TYPE
MuxKey #(4, 2, `ALU_CONTROL_LENGTH) mux_nr(alu_control, aluop, {
    `ALU_OP_ADD, `ALU_CONTROL_ADD,
    `ALU_OP_SUB, `ALU_CONTROL_SUBU,
    `ALU_OP_ORI, `ALU_CONTROL_ORI,
    `ALU_OP_R_TYPE, r_type_alu
});

MuxKey #(2, 6, `ALU_CONTROL_LENGTH) mux_r(r_type_alu, func, {
    `FUNC_ADDU, `ALU_CONTROL_ADDU,
    `FUNC_SUBU, `ALU_CONTROL_SUBU
});

endmodule