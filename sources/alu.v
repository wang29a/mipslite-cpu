`include "head.v"
`include "multiplier.v"
module alu(
    input [31:0] SrcA, SrcB,
    input [`ALU_CONTROL_LENGTH-1:0] alu_cont,
    input [`LENGTH-1:0] LO, HI,
    output reg [31:0] ALUout,
    output reg [31:0] Write_LO, Write_HI,
    output reg W_HILO,
    output zero
);
wire [63:0] temp;
reg [31:0] srca, srcb;
assign zero = (ALUout == 32'h00000000) ? 1 : 0;
reg sign;
multiplier mul(sign, srca, srcb, temp);

always @(*) begin
    case (alu_cont)
        `ALU_CONTROL_ADDI: 
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
        `ALU_CONTROL_MULTU:begin
            sign <= 1'b0;
            srca <= SrcA;
            srcb <= SrcB;
            Write_LO <= temp[31:0];
            Write_HI <= temp[63:32];
            W_HILO <= 1'b1;
        end
        `ALU_CONTROL_DIVU:begin
            Write_LO <= SrcA / SrcB;
            Write_HI <= SrcA % SrcB;
            W_HILO <= 1'b1;
        end
        `ALU_CONTROL_MFHI:
            ALUout <= HI;
        `ALU_CONTROL_MFLO:
            ALUout <= LO;
        `ALU_CONTROL_MTHI:begin
            Write_HI <= SrcA;
            Write_LO <= LO;
            W_HILO <= 1'b1;
        end
        `ALU_CONTROL_MTLO:begin
            Write_LO <= SrcA;
            Write_HI <= HI;
            W_HILO <= 1'b1;
        end
        `ALU_CONTROL_XORI:
            ALUout <= SrcA ^ SrcB;
        `ALU_CONTROL_ANDI:
            ALUout <= SrcA & SrcB;
        `ALU_CONTROL_MULT:begin
            sign <= 1'b1;
            srca <= SrcA;
            srcb <= SrcB;
            Write_LO <= temp[31:0];
            Write_HI <= temp[63:32];
            W_HILO <= 1'b1;
        end
        default:
            ALUout <= 0; 
    endcase
end

endmodule