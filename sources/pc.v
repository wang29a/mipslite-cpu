`include "head.v"
module pc(
    input clk,
    input rst,
    input wen,
    input [`LENGTH-1:0] npc,
    output wire [`LENGTH-1:0] pc
    
);
    Reg #(`LENGTH, `INITIAL_VAL) u_pc(
        .clk(clk), .rst(rst), .wen(wen), .din(npc), .dout(pc));
endmodule