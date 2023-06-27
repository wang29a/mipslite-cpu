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

`timescale 1ns / 1ps

module mips_sim_vscode();
    reg clk, pc_rst;
    mips u_mips(clk, pc_rst);
    always #10 clk = ~clk;
    initial begin
        $display("start a clock pulse");
        $dumpfile("wave.vcd");              // 指定记录模拟波形的文件
        $dumpvars(0, mips_sim_vscode);          // 指定记录的模块层级
        clk = 0;
        #10;
        pc_rst = 1;
        #10;
        pc_rst = 0;
        #10000 $finish;
    end
endmodule