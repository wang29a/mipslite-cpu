`include "mips.v"
`include "pc.v"
`include "npc.v"
`include "grp.v"
`include "alu.v"
`include "alu_control.v"
`include "controller_uint.v"
`include "data_memory.v"
`include "instruction_memory.v"
`include "instruction_reg.v"
`include "reg-template.v"
`include "muxkey-template.v"
`include "extend.v"
`include "mips_pipeline.v"
`include "reg_if_id.v"
`include "reg_exe_mem.v"
`include "reg_id_exe.v"
`include "reg_mem_wb.v"
`timescale 1ns / 1ps

module mips_sim_vscode();
    reg clk, pc_rst;
    mips_pipeline u_mips(clk, pc_rst);
    always #10 clk = ~clk;
    integer i;
    initial begin
        $display("start a clock pulse");
        $dumpfile("wave_2.vcd");              // 指定记录模拟波形的文件
        $dumpvars(0, mips_sim_vscode);          // 指定记录的模块层级
        $readmemh("./data/data.txt", u_mips.U_DM.dm);
        $readmemh("./data/inst.txt", u_mips.U_IM.im);
    // $readmemh("data.txt", dm);
        for (i = 0; i < `DATA_MEM_LENGTH; i = i +1)
            $display("DM[%d] = %x", i, u_mips.U_DM.dm[i]);
        for (i = 0; i < `INST_MEM_LENGTH; i = i + 1)
            $display("IM[%d] = %x", i, u_mips.U_IM.im[i]);

        clk = 0;
        pc_rst = 1;
        #10;
        #1;
        pc_rst = 0;
        #10000 $finish;
    end
endmodule