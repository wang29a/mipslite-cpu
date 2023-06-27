`include "head.v"
module mips(
    input wire clk,
    input wire pc_rst

);
wire [31:0] instruction_address, ALU_out,
            Read_reg_data1, Read_reg_data2, imm_extend, next_pc,
            SrcA, SrcB, instruction,
            Write_reg_Data, Write_memory_Data
            Read_memory_data;

wire ALUsrc_mux, Write_reg_mux, RegDst;
wire RegWrite, Memwrite, MemRead;
//操作码
wire extend_op;
wire [`ALU_OP_LENGTH-1:0] alu_op;

wire [4:0] rs, rt, rd;
wire [4:0] r1, r2, r3;
assign rs = instruction[25:21],
       rt = instruction[20:16],
       rd = instruction[15:11];

wire [15:0] imm16;

assign imm16 = instruction[15:0];
pc U_PC(.clk(clk),
        .rst(pc_rst),
        .npc(next_pc),
        .pc(instruction_address)
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
          .alu_op(alu_op),
          .ALUout(alu_out)
);

wire [31:0] wrie_IM_to_IR;
instruction_memory U_IM(.pc(instruction_address),
                        .instruction(wrie_IM_to_IR));
instruction_reg U_IR(.clk(clk),
                     .rst(),
                     .ni(wrie_IM_to_IR),
                     .i(instruction)
);

data_memory U_DM(.clk(clk),
                 .wen(Memwrite),
                 .address(ALU_out),
                 .write_data(RD2),
                 .read_data(Read_memory_data),
);

//AULsrc MUX
MuxKey #(2, 1, 32) (SrcB, ALUsrc_mux,
    1'b0, Read_reg_data2,
    1'b1, imm_extend
);
//Write_reg_MemorALU
MuxKey #(2, 1, 32) (Write_reg_Data, Write_reg_mux,
    1'b0, ALU_out,
    1'b1, Read_memory_data
);

//Write_Reg_Address Mux
MuxKey #(2, 1, 5) (r3, RegDst,
    1'b0, rt,
    1'b1, rd
);
endmodule