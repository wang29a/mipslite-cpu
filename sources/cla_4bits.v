module cla_4bits(
	input [3:0] A_in,
	input [3:0] B_in,
    input C_1,
    output CO,
	output [3:0] S
);
    wire [3:0] C;
    assign C[0] = (A_in[0] & B_in[0]) || ((A_in[0] ^ B_in[0]) & C_1);
    assign C[1] = (A_in[1] & B_in[1]) || ((A_in[1] ^ B_in[1]) & C[0]);
    assign C[2] = (A_in[2] & B_in[2]) || ((A_in[2] ^ B_in[2]) & C[1]);
    assign C[3] = (A_in[3] & B_in[3]) || ((A_in[3] ^ B_in[3]) & C[2]);
    assign CO = C[3];
    assign S[0] = A_in[0] ^ B_in[0] ^ C_1;
    assign S[1] = A_in[1] ^ B_in[1] ^ C[0];
    assign S[2] = A_in[2] ^ B_in[2] ^ C[1];
    assign S[3] = A_in[3] ^ B_in[3] ^ C[2];
endmodule
