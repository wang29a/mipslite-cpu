// `include "mips.v"
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
`include "forwarding_uint.v"
`include "hazard_detection_uint.v"
`include "is_equal.v"
`include "Branch_History_Table.v"
`timescale 1ns / 1ps

module mips_sim_vscode();
    reg clk, pc_rst;
    mips_pipeline u_mips(clk, pc_rst);
    always #10 clk = ~clk;
    integer i;
    initial begin
        $display("start a clock pulse");
        $dumpfile("wave_tmp.vcd");
        $dumpvars(0, mips_sim_vscode);
        $readmemh("./data/reg.txt", u_mips.U_RF.reg_file);
        $readmemh("./data/data.txt", u_mips.U_DM.dm);
        $readmemh("./data/inst_beq_stall.txt", u_mips.U_IM.im);
    // $readmemh("data.txt", dm);
        for (i = 0; i < `DATA_MEM_LENGTH; i = i +1)
            $display("DM[%d] = %x", i, u_mips.U_DM.dm[i]);
        // for (i = 0; i < `INST_MEM_LENGTH; i = i + 1)
        //     $display("IM[%d] = %x", i, u_mips.U_IM.im[i]);
        // for (i = 0; i < 32; i = i + 1)
        //     $display("RF[%d] = %x", i, u_mips.U_RF.reg_file[i]);

        clk = 0;
        pc_rst = 1;
        #10;
        #1;
        pc_rst = 0;
        // for (i = 0; i < `DATA_MEM_LENGTH; i = i +1)
        //     $display("DM[%d] = %x", i, u_mips.U_DM.dm[i]);
        #2000;
        for (i = 0; i < 32; i = i + 1)
            $display("RF[%d] = %x", i, u_mips.U_RF.reg_file[i]);
        $finish;
    end
endmodule