module cla_4bits_GP(
	input [3:0] A_in,
	input [3:0] B_in,
	output  wire G,
	output  wire P
);
   wire [3:0] p;
   wire [3:0] g;
   assign p[0] = A_in[0] ^ B_in[0];
   assign p[1] = A_in[1] ^ B_in[1];
   assign p[2] = A_in[2] ^ B_in[2];
   assign p[3] = A_in[3] ^ B_in[3];
   assign g[0] = A_in[0] & B_in[0];
   assign g[1] = A_in[1] & B_in[1];
   assign g[2] = A_in[2] & B_in[2];
   assign g[3] = A_in[3] & B_in[3];
   assign P = p[0] & p[1] & p[2] & p[3];
   assign G = g[3] | p[3] & g[2] | p[3] & p[2] & g[1] | p[3] & p[2] & p[1] & g[0];
   
endmodule
