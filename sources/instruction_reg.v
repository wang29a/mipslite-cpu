`include "head.v"
module instruction_reg(
    input wire clk,
    input wire rst,
    input wire ni,
    output reg [`LENGTH-1:0] i
);
Reg #(`LENGTH, `INITIAL_VAL) u_ir(
    .clk(clk),
    .rst(rst),
    .din(ni), 
    .dout(i)
);

endmodule