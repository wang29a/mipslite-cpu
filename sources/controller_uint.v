`include "head.v"
module controller_uint(
    input wire [5:0]op,
    input wire stall,
    output RegDst,
    output Branch,
    output Jmp,
    output Write_reg_mux,
    output [`ALU_OP_LENGTH-1:0] ALUOp,
    output Memwrite,
    output Memread,
    output ALUsrc,
    output RegWrite,
    output extend_op
);
wire [10:0] control, controltmp;
assign {RegDst, Branch, Jmp, Write_reg_mux,
        Memread, Memwrite, ALUsrc, RegWrite, extend_op,
        ALUOp} = control;
MuxKey #(7, 6, 11) con_mux(control, op, {
    `OP_R_TYPE, 11'b10000010_011,
    `OP_ORI,    11'b00000110_010,
    `OP_LW,     11'b00011111_000,
    `OP_SW,     11'b00000101_000,
    `OP_BEQ,    11'b01000000_001,
    `OP_JAL,    11'b00100000_000,
    `OP_XORI,   11'b00000110_100
});

MuxKey #(2, 1, 11) con_stall_mux(control, stall, {
    1'b1, controltmp,
    1'b0, 11'b000000000
});

endmodule