`include "head.v"
module pc(
    input clk,
    input rst,
    input [`LENGTH-1:0] npc,
    output wire [`LENGTH-1:0] pc
    
);
    Reg #(`LENGTH, `INITIAL_VAL) u_pc(
        .clk(clk), .rst(rst), .din(npc), .dout(pc));
endmodule