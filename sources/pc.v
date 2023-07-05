`include "head.v"
`timescale 1ns / 1ps
module pc(
    input clk,
    input rst,
    input wen,
    input [`LENGTH-1:0] npc,
    output wire [`LENGTH-1:0] pc
    
);
    Reg #(`LENGTH, 32'h00003000) u_pc(
        .clk(clk), .rst(rst), .wen(wen), .din(npc), .dout(pc));
endmodule