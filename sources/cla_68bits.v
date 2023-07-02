`include "cla_group_16bits.v"
`include "cla_4bits.v"
module cla_68bits(
	input [67:0] A_in,
	input [67:0] B_in,
    input C_1,
	output wire [67:0] S
);
wire [4:0]c;
cla_group_16bits cla16_0(A_in[15:0], B_in[15:0], C_1, c[0], S[15:0]);
cla_group_16bits cla16_1(A_in[31:16], B_in[31:16], c[0], c[1], S[31:16]);
cla_group_16bits cla16_2(A_in[47:32], B_in[47:32], c[1], c[2], S[47:32]);
cla_group_16bits cla16_3(A_in[63:48], B_in[63:48], c[2], c[3], S[63:48]);
cla_4bits cla4_0(A_in[67:64], B_in[67:64], c[3], c[4], S[67:64]);
endmodule

