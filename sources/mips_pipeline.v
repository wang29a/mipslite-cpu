`include "head.v"
module mips_pipeline(
    input wire clk,
    input wire rst

);
wire [31:0] 
            // pcF, ALU_out,
            // Read_reg_data1, Read_reg_data2, imm_extend, next_pc,
            // SrcA, SrcB, instructionD,
            Write_reg_Data, Write_memory_Data,
            Read_memory_data;

wire [31:0] pcF, pc_4F, instructionF;

wire [31:0] instructionD,
            Read_reg_data_1D,
            Read_reg_data_2D,
            imm_extD;

wire ALUsrc_muxD, Write_reg_muxD, RegDstD;
wire RegWriteD, MemwriteD;
wire extend_opD;
wire [`ALU_OP_LENGTH-1:0] alu_opD;
wire [4:0] rtD, rdD;

assign rtD = instructionD[20:16],
       rdD = instructionD[15:11];

wire [31:0] SrcAE, SrcBE, ALU_outE,
            imm_extE,
            Read_reg_data_1E,
            Read_reg_data_2E;
wire [5:0] funcE;
wire [4:0] Write_Reg_AddressE,
           rtE, rdE;
wire [`ALU_OP_LENGTH-1:0] alu_opE;
wire ALUsrc_muxE, Write_reg_muxE, RegDstE;
wire RegWriteE, MemwriteE;
wire zeroE;

assign funcE = imm_extE[5:0];

wire [31:0] Write_memory_DataM, Read_memory_dataM,
            ALU_outM;
wire [4:0] Write_Reg_AddressM;
//TODO Write_memory_address
wire RegWriteM, MemwriteM, zeroM, Write_reg_muxM;

wire [31:0] ALU_outW, Read_memory_dataW;
wire [4:0] Write_Reg_AddressW;
wire RegWriteW, Write_reg_muxW;

assign pc_4F = pcF+32'h00000004;
assign SrcAE = Read_reg_data_1E;
wire ALUsrc_mux, Write_reg_mux, RegDst;
wire RegWrite, Memwrite, MemRead;
wire extend_op;
wire [`ALU_OP_LENGTH-1:0]       alu_op;
wire [`ALU_CONTROL_LENGTH-1:0]  alu_cont;

wire [4:0] rs, rt, rd;
wire [4:0] r1D, r2D, r3D;
assign rs = instructionD[25:21],
       rt = instructionD[20:16],
       rd = instructionD[15:11];
assign r1D = rs,
       r2D = rt;
wire [15:0] imm16;
wire [25:0] imm26;
assign imm16 = instructionD[15:0],
       imm26 = instructionD[25:0];

wire [5:0] op, func;

assign op = instructionD[31:26],
       func = instructionD[5:0];

wire Branch, Jmp, zero;

controller_uint U_CU(
    .op(op),
    .RegDst(RegDstD),
    .Branch(Branch),
    .Jmp(Jmp),
    .Write_reg_mux(Write_reg_muxD),
    .ALUOp(alu_opD),
    .Memwrite(MemwriteD),
    .ALUsrc(ALUsrc_muxD),
    .RegWrite(RegWriteD),
    .extend_op(extend_opD)
);

alu_control U_ALU_CONT(
    .aluop(alu_opE),
    .func(funcE),
    .alu_control(alu_cont)
);

pc U_PC(.clk(clk),
        .rst(rst),
        .npc(pc_4F),
        .pc(pcF)
);

// npc U_NPC(.pc(pc),
//           .imm16(imm16),
//           .imm26(imm26),
//           .branch((Branch&zero)),
//           .jmp(Jmp),
//           .npc(next_pc)
// );

grp U_RF(.clk(clk),
         .wen(RegWriteW),
         .r1(r1D),
         .r2(r2D),
         .r3(Write_Reg_AddressW),
         .WD(Write_reg_Data),
         .RD1(Read_reg_data_1D),
         .RD2(Read_reg_data_2D)
);

extend U_EXT(.imm16(imm16),
             .ext_op(extend_opD),
             .ext_out(imm_extD)
);

alu U_ALU(.SrcA(SrcAE),
          .SrcB(SrcBE),
          .alu_cont(alu_cont),
          .zero(zero),
          .ALUout(ALU_outE)
);

wire [31:0] wrie_IM_to_IR;
instruction_memory U_IM(.instruction_address(pcF[`INST_MEM_ADDRESS+1:2]),
                        // .instruction(wrie_IM_to_IR));
                        .instruction(instructionF));
// instruction_reg U_IR(.clk(clk),
//                      .rst(rst),
//                      .ni(wrie_IM_to_IR),
//                      .i(instruction)
// );

data_memory U_DM(.clk(clk),
                 .wen(Memwrite),
                 .address(ALU_outM[`DATA_MEM_ADDRESS+1:2]),
                 .write_data(Write_memory_DataM),
                 .read_data(Read_memory_data)
);

//AULsrc MUX
MuxKey #(2, 1, 32) U_ALUsrc_MUX(SrcBE, ALUsrc_muxE, {
    1'b0, Read_reg_data_2E,
    1'b1, imm_extE
});
//Write_reg_MemorALU
MuxKey #(2, 1, 32) U_Write_reg_data_MUX(Write_reg_Data, Write_reg_muxW, {
    1'b0, ALU_outW,
    1'b1, Read_memory_dataW
});

//Write_Reg_Address Mux
MuxKey #(2, 1, 5) U_Write_reg_address_MUX(Write_Reg_AddressE, RegDstE, {
    1'b0, rtE,
    1'b1, rdE
});

reg_if_id U_IF_ID(
    .clk(clk),
    .rst(rst),
    .instruction_in(instructionF),
    .instruction_out(instructionD)
);

reg_id_exe U_ID_EXE(
    .clk(clk),
    .rst(rst),
    .RegDst_in(RegDstD),
    .ALUOp_in(alu_opD),
    .Write_reg_mux_in(Write_reg_muxD),
    .Memwrite_in(MemwriteD),
    .ALUsrc_in(ALUsrc_muxD),
    .RegWrite_in(RegWriteD),
    .Read_data_1_in(Read_reg_data_1D),
    .Read_data_2_in(Read_reg_data_2D),
    .imm_ext_in(imm_extD),
    .rt_in(rtD),
    .rd_in(rdD),
    .RegDst_out(RegDstE),
    .ALUOp_out(alu_opE),
    .Write_reg_mux_out(Write_reg_muxE),
    .Memwrite_out(MemwriteE),
    .ALUsrc_out(ALUsrc_muxE),
    .RegWrite_out(RegWriteE),
    .Read_data_1_out(Read_reg_data_1E),
    .Read_data_2_out(Read_reg_data_2E),
    .imm_ext_out(imm_extE),
    .rt_out(rtE),
    .rd_out(rdE)
);

reg_exe_mem U_EXE_MEM(
    .clk(clk),
    .rst(rst),
    .Memwrite_in(MemwriteE),
    .RegWrite_in(RegWriteE),
    .ALU_out_in(ALU_outE),
    .Write_memory_Data_in(Read_reg_data_2E),
    .zero_in(zeroE),
    .Write_Reg_Address_in(Write_Reg_AddressE),
    .Write_reg_mux_in(Write_reg_muxE),
    .Memwrite_out(MemwriteM),
    .RegWrite_out(RegWriteM),
    .ALU_out_out(ALU_outM),
    .Write_memory_Data_out(Write_memory_DataM),
    .zero_out(zeroM),
    .Write_Reg_Address_out(Write_Reg_AddressM),
    .Write_reg_mux_out(Write_reg_muxM)
);

reg_mem_wb U_MEM_WB(
    .clk(clk),
    .rst(rst),
    .RegWrite_in(RegWriteM),
    .Read_memory_data_in(Read_memory_dataM),
    .Write_Reg_Address_in(Write_Reg_AddressM),
    .ALU_out_in(ALU_outM),
    .Write_reg_mux_in(Write_reg_muxM),
    .RegWrite_out(RegWriteW),
    .Read_memory_data_out(Read_memory_dataW),
    .Write_Reg_Address_out(Write_Reg_AddressW),
    .ALU_out_out(ALU_outW),
    .Write_reg_mux_out(Write_reg_muxW)
);

endmodule