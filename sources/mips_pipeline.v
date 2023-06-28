`include "head.v"
module mips(
    input wire clk,
    input wire rst

);
wire [31:0] pcF, ALU_out,
            Read_reg_data1, Read_reg_data2, imm_extend, next_pc,
            SrcA, SrcB, instructionD,
            Write_reg_Data, Write_memory_Data,
            Read_memory_data;

wire [31:0] pcF, pc_4F, instructionF;

wire [31:0] instructionD,
            Read_data_1D,
            Read_data_2D,
            imm_extD;

wire ALUsrc_muxD, Write_reg_muxD, RegDstD;
wire RegWriteD, MemwriteD;
wire extend_opD;
wire [4:0] rtD, rdD;

wire [31:0] SrcAE, SrcBE, ALU_outE;
wire [4:0] funcE, Write_Reg_AddressE;
wire ALUsrc_muxE, Write_reg_muxE, RegDstE;
wire RegWriteE, MemwriteE;
wire zeroE;

wire [31:0] Write_memory_DataM, Read_memory_dataM;
wire [4:0] Write_Reg_AddressM;
//TODO Write_memory_address
wire RegWriteM, MemwriteM;

wire [31:0] ALU_outW, Read_memory_dataW;
wire RegWriteW, MemwriteW;

assign pc_4F = pcF+32'h00000004
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
       func =instruction[5:0];

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
        .pc(pc)
);

npc U_NPC(.pc(pc),
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
instruction_memory U_IM(.instruction_address(pc[`INST_MEM_ADDRESS+1:2]),
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

reg_if_id U_IF_ID(
    .clk(clk),
    .rst(rst),
    .instruction_in(),
    .instruction_out()
);

reg_id_exe U_ID_EXE(
    .clk(clk),
    .rst(rst),
    .RegDst_in(),
    .ALUOp_in(),
    .Write_reg_mux_in(),
    .Memwrite_in(),
    .ALUsrc_in(),
    .RegWrite_in(),
    .extend_op_in(),
    .Read_data_1_in(),
    .Read_data_2_in(),
    .imm_ext_in(),
    .rt_in(),
    .rd_in(),
    .RegDst_out(),
    .ALUOp_out(),
    .Write_reg_mux_out(),
    .Memwrite_out(),
    .ALUsrc_out(),
    .RegWrite_out(),
    .extend_op_out(),
    .Read_data_1_out(),
    .Read_data_2_out(),
    .imm_ext_out(),
    .rt_out(),
    .rd_out(),
);

reg_exe_mem U_EXE_MEM(
    .clk(clk),
    .rst(rst),
    .Write_reg_mux_in(),
    .Memwrite_in(),
    .RegWrite_in(),
    .ALU_out_in(),
    .Write_memory_Data_in(),
    .zero_in(),
    .Write_Reg_Address_in(),
    .Write_reg_mux_out(),
    .Memwrite_out(),
    .RegWrite_out(),
    .ALU_out_out(),
    .Write_memory_Data_out(),
    .zero_out(),
    .Write_Reg_Address_out(),
);

reg_mem_wb U_MEM_WB(
    .clk(clk),
    .rst(rst),
    Read_memory_data_in(),
    Write_Reg_Address_in(),
    Read_memory_data_out(),
    Write_Reg_Address_out(),
);

endmodule