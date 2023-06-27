`include "head.v"
module controller_uint(
    input wire [5:0]op;
    output RegDst,
    output Branch,
    output Jmp,
    output Write_reg_mux,
    output [`ALU_OP_LENGTH-1:0] ALUOp,
    output Memwrite,
    output ALUsrc,
    output RegWrite,
    output extend_op,
);




endmodule