
module npc(
    input wire [31:0] pc,
    input wire [15:0] imm16,
    input wire [25:0] imm26,
    input wire branch,
    input wire jmp,
    output wire [31:0] npc
);
wire [31:0] pc_4, pc_b, pc_j, pc_tmp;
assign pc_4 = pc + 32'h4;
assign pc_b = pc_4 + {{14{imm16[15]}}, imm16, 2'b00};
assign pc_j = {pc[31:28], imm26, 2'b00};

MuxKeyWithDefault #(2, 1, 32) mux_b(pc_tmp, branch, pc_4, {
    1'b0, pc_4,
    1'b1, pc_b
});

MuxKeyWithDefault #(2, 1, 32) mux_j(npc, jmp, pc_tmp, {
    1'b0, pc_tmp,
    1'b1, pc_j
});

endmodule