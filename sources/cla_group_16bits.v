`include "cla_4bits_GP.v"
module cla_group_16bits(
	input [15:0] A_in,
	input [15:0] B_in,
    input C_1,
 	output wire CO,
	output wire [15:0] S
);
wire [3:0] _p;
wire [3:0] _g;
wire [3:0] c;
wire [3:0] useless_c;
cla_4bits_GP clGP0(.A_in(A_in[3:0]), .B_in(B_in[3:0]), .G(_g[0]), .P(_p[0]));
cla_4bits_GP claGP1(.A_in(A_in[7:4]), .B_in(B_in[7:4]), .G(_g[1]), .P(_p[1]));
cla_4bits_GP claGP2(.A_in(A_in[11:8]), .B_in(B_in[11:8]), .G(_g[2]), .P(_p[2]));
cla_4bits_GP claGP3(.A_in(A_in[15:12]), .B_in(B_in[15:12]), .G(_g[3]), .P(_p[3]));
assign c[0] = _g[0] | _p[0] & C_1;
assign c[1] = _g[1] | _p[1] & c[0];
assign c[2] = _g[2] | _p[2] & c[1];
assign c[3] = _g[3] | _p[3] & c[2];
assign CO = c[3];
cla_4bits cla0(.A_in(A_in[3:0]), .B_in(B_in[3:0]), .C_1(C_1), .CO(useless_c[0]), .S(S[3:0]));
cla_4bits cla1(.A_in(A_in[7:4]), .B_in(B_in[7:4]), .C_1(c[0]), .CO(useless_c[1]), .S(S[7:4]));
cla_4bits cla2(.A_in(A_in[11:8]), .B_in(B_in[11:8]), .C_1(c[1]), .CO(useless_c[2]), .S(S[11:8]));
cla_4bits cla3(.A_in(A_in[15:12]), .B_in(B_in[15:12]), .C_1(c[2]), .CO(useless_c[3]), .S(S[15:12]));

endmodule
