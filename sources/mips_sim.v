`timescale 1ns / 1ps

module mips_sim();
    reg clk, pc_rst;
    mips u_mips(clk, pc_rst);
    always #10 clk = ~clk;
    initial begin
        clk = 0;
        #10;
        pc_rst = 1;
        #10;
        pc_rst = 0;
    end
endmodule