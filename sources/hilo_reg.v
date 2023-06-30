`include "head.v"
module hilo_reg(
    input clk,
    input wen,
    input [`LENGTH-1:0] w_lo, w_hi,
    output reg[`LENGTH-1:0] lo, hi
);
always@(posedge clk) begin
    if(wen == 1'b1)begin
        lo <= w_lo;
        hi <= w_hi;
    end
end
endmodule