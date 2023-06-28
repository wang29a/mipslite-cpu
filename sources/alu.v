`include "head.v"
module alu(
    input [31:0] SrcA, SrcB,
    input [`ALU_CONTROL_LENGTH-1:0] alu_cont,
    output reg [31:0] ALUout,
    // output reg [31:0] LO, HI;
);
reg [63:0] temp;
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
        `ALU_CONTROL_AND:
            ALUout <= SrcA & SrcB;
        `ALU_CONTROL_NOR:
            ALUout <= ~(SrcA | SrcB);
        `ALU_CONTROL_XOR:
            ALUout <= SrcA ^ SrcB;
        `ALU_CONTROL_OR:
            ALUout <= SrcA | SrcB;
        `ALU_CONTROL_SLLV:
            ALUout <= SrcB << SrcA;
        `ALU_CONTROL_SRAV:
            ALUout <= SrcB >>> SrcA;
        `ALU_CONTROL_SRLV:
            ALUout <= SrcB >> SrcA;
        // `ALU_CONTROL_MULTU:begin
        //     temp <= SrcA * SrcB;
        //     LO <= temp[31:0];
        //     HI <= temp[63:32];
        // end
        // `ALU_CONTROL_DIVU:begin
        //     LO <= SrcA / SrcB;
        //     HI <= SrcA % SrcB;
        // end
        default:
            ALUout <= 0; 
    endcase
end

endmodule