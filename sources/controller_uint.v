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
wire [11:0] control, controltmp;
assign {RegDst, Branch, Jmp, Write_reg_mux,
        Memread, Memwrite, ALUsrc, RegWrite, extend_op,
        ALUOp} = control;
    MuxKey #(7, 6, 12) con_mux(control, op, {
    `OP_R_TYPE, 12'b1000_00_010_011,
    `OP_ORI,    12'b0000_00_110_010,
    `OP_LW,     12'b0001_10_111_000,
    `OP_SW,     12'b0000_01_101_000,
    `OP_BEQ,    12'b0100_00_000_001,
    `OP_JAL,    12'b0010_00_000_000,
    `OP_XORI,   12'b0000_00_110_100
});

MuxKey #(2, 1, 12) con_stall_mux(control, stall, {
    1'b1, controltmp,
    1'b0, 12'b0000000000
});

endmodule
