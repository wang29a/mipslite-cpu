`include "head.v"
module reg_if_id(
    input wire clk,
    input wire rst,
    input wire wen,
    input wire [`LENGTH-1:0]     instruction_in,
    // input [`LENGTH-1:0]     pc_4
    output reg [`LENGTH-1:0]    instruction_out
);

always @(posedge clk) begin
    if (rst) begin
        instruction_out <= `INITIAL_VAL;
    end
    else if (wen) begin
        instruction_out <= instruction_in;
    end
end

endmodule