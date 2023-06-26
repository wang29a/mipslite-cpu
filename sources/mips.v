
module mips(
    input wire clk,

);
wire [31:0] instruction_address, alu_out,
            Read_reg_data1, Read_reg_data2, imm_extend, next_pc,
            SrcA, SrcB, instruction,
            Write_reg_Data, Write_memory_Data
            Read_memory_data;

wire [4:0] rs, rt, rd;
wire [4:0] r1, r2, r3;
assign rs = instruction[25:21],
       rt = instruction[20:16],
       rd = instruction[15:11];

wire [15:0] imm16;

assign imm16 = instruction[15:0];
pc U_PC(.clk(clk),
        .rst(),
        .npc(next_pc),
        .pc(instruction_address)
);

grp U_RF(.clk(clk),
         .wen(),
         .r1(r1),
         .r2(r2),
         .r3(r3),
         .WD(Write_reg),
         .RD1(Read_reg_data1),
         .RD2(Read_reg_data2)
);

alu U_ALU(.SrcA(SrcA),
          .SrcB(SrcB),
          .alu_op(),
          .ALUout(alu_out)
);

extend U_EXT(.imm16(imm16),
             .ext_op(),
             .ext_out(imm_extend)
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
                 .wen(),
                 .address(alu_out),
                 .write_data(RD2),
                 .read_data(Read_memory_data),
);

endmodule