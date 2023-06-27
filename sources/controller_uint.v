`include "head.v"
module controller_uint(
    input wire [5:0]op,
    output RegDst,
    output Branch,
    output Jmp,
    output Write_reg_mux,
    output [`ALU_OP_LENGTH-1:0] ALUOp,
    output Memwrite,
    output ALUsrc,
    output RegWrite,
    output extend_op
);
wire [9:0] control;
assign {RegDst, Branch, Jmp, Write_reg_mux,
        Memwrite, ALUsrc, RegWrite, extend_op,
        ALUOp} = control;
MuxKey #(7, 6, 10) con_mux(control, op, {
    `OP_R_TYPE, 10'b10000010_11,
    `OP_ORI,    10'b00000110_10,
    `OP_LW,     10'b00011111_00,
    `OP_SW,     10'b00000101_00,
    `OP_BEQ,    10'b01000000_01,
    `OP_JAL,    10'b00100000_00
});



endmodule