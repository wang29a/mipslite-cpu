`include "head.v"
module alu(
    input [31:0] SrcA, SrcB,
    input [`ALU_CONTROL_LENGTH-1:0] alu_cont,
    output zero,
    output reg [31:0] ALUout
);

assign zero = (ALUout == 32'h00000000) ? 1 : 0;

always @(*) begin
    case (alu_cont)
        `ALU_CONTROL_ADD: 
            ALUout <= SrcA + SrcB;
        `ALU_CONTROL_ADDU:
            ALUout <= SrcA + SrcB;
        `ALU_CONTROL_SUBU:
            ALUout <= SrcA - SrcB;
        `ALU_CONTROL_ORI:
            ALUout <= SrcA | SrcB;
        default:
            ALUout <= 0; 
    endcase
end

endmodule