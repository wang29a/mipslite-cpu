`include "head.v"
module mips(
    input wire clk,
    input wire rst

);
wire [31:0] instruction_address, ALU_out,
            Read_reg_data1, Read_reg_data2, imm_extend, next_pc,
            SrcA, SrcB, instruction,
            Write_reg_Data, Write_memory_Data,
            Read_memory_data;
assign SrcA = Read_reg_data1;
wire ALUsrc_mux, Write_reg_mux, RegDst;
wire RegWrite, Memwrite, MemRead;
wire extend_op;
wire [`ALU_OP_LENGTH-1:0]       alu_op;
wire [`ALU_CONTROL_LENGTH-1:0]  alu_cont;

wire [4:0] rs, rt, rd;
wire [4:0] r1, r2, r3;
assign rs = instruction[25:21],
       rt = instruction[20:16],
       rd = instruction[15:11];
assign r1 = rs,
       r2 = rt;
wire [15:0] imm16;
wire [25:0] imm26;
assign imm16 = instruction[15:0],
       imm26 = instruction[25:0];

wire [5:0] op, func;

assign op = instruction[31:26],
       func = instruction[5:0];

wire Branch, Jmp, zero;

controller_uint U_CU(
    .op(op),
    .RegDst(RegDst),
    .Branch(Branch),
    .Jmp(Jmp),
    .Write_reg_mux(Write_reg_mux),
    .ALUOp(alu_op),
    .Memwrite(Memwrite),
    .ALUsrc(ALUsrc_mux),
    .RegWrite(RegWrite),
    .extend_op(extend_op)
);

alu_control U_ALU_CONT(
    .aluop(alu_op),
    .func(func),
    .alu_control(alu_cont)
);

pc U_PC(.clk(clk),
        .rst(rst),
        .npc(next_pc),
        .pc(instruction_address)
);

npc U_NPC(.pc(instruction_address),
          .imm16(imm16),
          .imm26(imm26),
          .branch((Branch&zero)),
          .jmp(Jmp),
          .npc(next_pc)
);

grp U_RF(.clk(clk),
         .wen(RegWrite),
         .r1(r1),
         .r2(r2),
         .r3(r3),
         .WD(Write_reg_Data),
         .RD1(Read_reg_data1),
         .RD2(Read_reg_data2)
);

extend U_EXT(.imm16(imm16),
             .ext_op(extend_op),
             .ext_out(imm_extend)
);
alu U_ALU(.SrcA(SrcA),
          .SrcB(SrcB),
          .alu_cont(alu_cont),
          .zero(zero),
          .ALUout(ALU_out)
);

wire [31:0] wrie_IM_to_IR;
instruction_memory U_IM(.instruction_address(instruction_address[`INST_MEM_ADDRESS+1:2]),
                        // .instruction(wrie_IM_to_IR));
                        .instruction(instruction));
// instruction_reg U_IR(.clk(clk),
//                      .rst(rst),
//                      .ni(wrie_IM_to_IR),
//                      .i(instruction)
// );

data_memory U_DM(.clk(clk),
                 .wen(Memwrite),
                 .address(ALU_out[`DATA_MEM_ADDRESS+1:2]),
                 .write_data(Read_reg_data2),
                 .read_data(Read_memory_data)
);

//AULsrc MUX
MuxKey #(2, 1, 32) U_ALUsrc_MUX(SrcB, ALUsrc_mux, {
    1'b0, Read_reg_data2,
    1'b1, imm_extend
});
//Write_reg_MemorALU
MuxKey #(2, 1, 32) U_Write_reg_data_MUX(Write_reg_Data, Write_reg_mux, {
    1'b0, ALU_out,
    1'b1, Read_memory_data
});

//Write_Reg_Address Mux
MuxKey #(2, 1, 5) U_Write_reg_address_MUX(r3, RegDst, {
    1'b0, rt,
    1'b1, rd
});
endmodule