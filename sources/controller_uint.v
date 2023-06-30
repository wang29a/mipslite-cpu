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
    `OP_R_TYPE, 11'b1000_00_010_011,
    `OP_ORI,    11'b0000_00_110_010,
    `OP_LW,     11'b0001_10_111_000,
    `OP_SW,     11'b0000_01_101_000,
    `OP_BEQ,    11'b0100_00_000_001,
    `OP_JAL,    11'b0010_00_000_000,
    `OP_XORI,   11'b0000_00_110_100
});

MuxKey #(2, 1, 11) con_stall_mux(control, stall, {
    1'b1, controltmp,
    1'b0, 11'b000000000
});

endmodule
