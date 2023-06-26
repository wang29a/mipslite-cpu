`include "head.v"
module alu(
    input [31:0] SrcA, SrcB,
    input [`ALU_OP_LENGTH-1:0] alu_op,
    output reg [31:0] ALUout
);

always @(*) begin
    case (alu_op)
        `ALU_OP_ADDU: 
            ALUout <= SrcA + SrcB;
        `ALU_OP_SUBU:
            ALUout <= SrcA - SrcB;
        `ALU_OP_OR:
            ALUout <= SrcA | SrcB;
        default :
            ALUout <= 0; 
    endcase
end

endmodule