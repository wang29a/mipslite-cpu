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
MuxKey #(6, 6, 11) con_mux(controltmp, op, {
    `OP_R_TYPE, 11'b1000_00_010_11,
    `OP_ORI,    11'b0000_00_110_10,
    `OP_LW,     11'b0001_10_111_00,
    `OP_SW,     11'b0000_01_01_00,
    `OP_BEQ,    11'b0100_00_000_01,
    `OP_JAL,    11'b0010_00_000_00
});

MuxKey #(2, 1, 11) con_stall_mux(control, stall, {
    1'b1, controltmp,
    1'b0, 11'b000000000
});

endmodule