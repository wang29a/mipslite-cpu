`include "head.v"
`include "part_product-template.v"
`include "special_part_product.v"
`include "get_c.v"
`include "switch.v"
`include "walloc_17bits-template.v"
`include "cla_68bits.v"
module multiplier(
    input sign,
    input [31:0] _X,
    input [31:0] _Y,
    output  [63:0] res
);
wire [67:0] part_p [0:16];
wire [67:0] part_p_pre[0:16];
reg [67:0] extend_X;
reg [67:0] move_ex[0:16];
reg [34:0] Y;
// wire [1:0]C[0:16];
wire [67:0]C;
integer i, j;
always @(*) 
begin
    if(sign == 1'b0)
    begin
        extend_X = {36'b0, _X};
        Y = {2'b0, _Y, 1'b0};
    end
    else
    begin
      extend_X = {{36{_X[31]}}, _X};
      Y = {{2{_Y[31]}}, _Y, 1'b0};
    end  
    
end
part_product p0(extend_X, Y[2:0], part_p_pre[0], C[1:0]);
assign part_p[0] = part_p_pre[0] << (0);
part_product p1(extend_X, Y[4:2], part_p_pre[1], C[3:2]);
assign part_p[1] = part_p_pre[1] << (2);
part_product p2(extend_X, Y[6:4], part_p_pre[2], C[5:4]);
assign part_p[2] = part_p_pre[2] << (4);
part_product p3(extend_X, Y[8:6], part_p_pre[3], C[7:6]);
assign part_p[3] = part_p_pre[3] << (6);
part_product p4(extend_X, Y[10:8], part_p_pre[4], C[9:8]);
assign part_p[4] = part_p_pre[4] << (8);
part_product p5(extend_X, Y[12:10], part_p_pre[5], C[11:10]);
assign part_p[5] = part_p_pre[5] << (10);
part_product p6(extend_X, Y[14:12], part_p_pre[6], C[13:12]);
assign part_p[6] = part_p_pre[6] << (12);
part_product p7(extend_X, Y[16:14], part_p_pre[7], C[15:14]);
assign part_p[7] = part_p_pre[7] << (14);
part_product p8(extend_X, Y[18:16], part_p_pre[8], C[17:16]);
assign part_p[8] = part_p_pre[8] << (16);
part_product p9(extend_X, Y[20:18], part_p_pre[9], C[19:18]);
assign part_p[9] = part_p_pre[9] << (18);
part_product p10(extend_X, Y[22:20], part_p_pre[10], C[21:20]);
assign part_p[10] = part_p_pre[10] << (20);
part_product p11(extend_X, Y[24:22], part_p_pre[11], C[23:22]);
assign part_p[11] = part_p_pre[11] << (22);
part_product p12(extend_X, Y[26:24], part_p_pre[12], C[25:24]);
assign part_p[12] = part_p_pre[12] << (24);
part_product p13(extend_X, Y[28:26], part_p_pre[13], C[27:26]);
assign part_p[13] = part_p_pre[13] << (26);
part_product p14(extend_X, Y[30:28], part_p_pre[14], C[29:28]);
assign part_p[14] = part_p_pre[14] << (28);
part_product p15(extend_X, Y[32:30], part_p_pre[15], C[31:30]);
assign part_p[15] = part_p_pre[15] << (30);
part_product p16(extend_X, Y[34:32], part_p_pre[16], C[33:32]);
assign part_p[16] = part_p_pre[16] << (32);

assign C[67:34] = 0;

wire [16:0] new_p[0:67];
switch sw(part_p[0], part_p[1], part_p[2], part_p[3], part_p[4], part_p[5], part_p[6], part_p[7], part_p[8], part_p[9], part_p[10], part_p[11], part_p[12], part_p[13], part_p[14], part_p[15], part_p[16], new_p[0], new_p[1], new_p[2], new_p[3], new_p[4], new_p[5], new_p[6], new_p[7], new_p[8], new_p[9], new_p[10], new_p[11], new_p[12], new_p[13], new_p[14], new_p[15], new_p[16], new_p[17], new_p[18], new_p[19], new_p[20], new_p[21], new_p[22], new_p[23], new_p[24], new_p[25], new_p[26], new_p[27], new_p[28], new_p[29], new_p[30], new_p[31], new_p[32], new_p[33], new_p[34], new_p[35], new_p[36], new_p[37], new_p[38], new_p[39], new_p[40], new_p[41], new_p[42], new_p[43], new_p[44], new_p[45], new_p[46], new_p[47], new_p[48], new_p[49], new_p[50], new_p[51], new_p[52], new_p[53], new_p[54], new_p[55], new_p[56], new_p[57], new_p[58], new_p[59], new_p[60], new_p[61], new_p[62], new_p[63], new_p[64], new_p[65], new_p[66], new_p[67]);

wire [67:0] s, carry;
wire [13:0] cout [0:67];
walloc_17bits w17_0(new_p[0], 14'b0, cout[0], carry[0], s[0]);
walloc_17bits w17_1(new_p[1], cout[0], cout[1], carry[1], s[1]);
walloc_17bits w17_2(new_p[2], cout[1], cout[2], carry[2], s[2]);
walloc_17bits w17_3(new_p[3], cout[2], cout[3], carry[3], s[3]);
walloc_17bits w17_4(new_p[4], cout[3], cout[4], carry[4], s[4]);
walloc_17bits w17_5(new_p[5], cout[4], cout[5], carry[5], s[5]);
walloc_17bits w17_6(new_p[6], cout[5], cout[6], carry[6], s[6]);
walloc_17bits w17_7(new_p[7], cout[6], cout[7], carry[7], s[7]);
walloc_17bits w17_8(new_p[8], cout[7], cout[8], carry[8], s[8]);
walloc_17bits w17_9(new_p[9], cout[8], cout[9], carry[9], s[9]);
walloc_17bits w17_10(new_p[10], cout[9], cout[10], carry[10], s[10]);
walloc_17bits w17_11(new_p[11], cout[10], cout[11], carry[11], s[11]);
walloc_17bits w17_12(new_p[12], cout[11], cout[12], carry[12], s[12]);
walloc_17bits w17_13(new_p[13], cout[12], cout[13], carry[13], s[13]);
walloc_17bits w17_14(new_p[14], cout[13], cout[14], carry[14], s[14]);
walloc_17bits w17_15(new_p[15], cout[14], cout[15], carry[15], s[15]);
walloc_17bits w17_16(new_p[16], cout[15], cout[16], carry[16], s[16]);
walloc_17bits w17_17(new_p[17], cout[16], cout[17], carry[17], s[17]);
walloc_17bits w17_18(new_p[18], cout[17], cout[18], carry[18], s[18]);
walloc_17bits w17_19(new_p[19], cout[18], cout[19], carry[19], s[19]);
walloc_17bits w17_20(new_p[20], cout[19], cout[20], carry[20], s[20]);
walloc_17bits w17_21(new_p[21], cout[20], cout[21], carry[21], s[21]);
walloc_17bits w17_22(new_p[22], cout[21], cout[22], carry[22], s[22]);
walloc_17bits w17_23(new_p[23], cout[22], cout[23], carry[23], s[23]);
walloc_17bits w17_24(new_p[24], cout[23], cout[24], carry[24], s[24]);
walloc_17bits w17_25(new_p[25], cout[24], cout[25], carry[25], s[25]);
walloc_17bits w17_26(new_p[26], cout[25], cout[26], carry[26], s[26]);
walloc_17bits w17_27(new_p[27], cout[26], cout[27], carry[27], s[27]);
walloc_17bits w17_28(new_p[28], cout[27], cout[28], carry[28], s[28]);
walloc_17bits w17_29(new_p[29], cout[28], cout[29], carry[29], s[29]);
walloc_17bits w17_30(new_p[30], cout[29], cout[30], carry[30], s[30]);
walloc_17bits w17_31(new_p[31], cout[30], cout[31], carry[31], s[31]);
walloc_17bits w17_32(new_p[32], cout[31], cout[32], carry[32], s[32]);
walloc_17bits w17_33(new_p[33], cout[32], cout[33], carry[33], s[33]);
walloc_17bits w17_34(new_p[34], cout[33], cout[34], carry[34], s[34]);
walloc_17bits w17_35(new_p[35], cout[34], cout[35], carry[35], s[35]);
walloc_17bits w17_36(new_p[36], cout[35], cout[36], carry[36], s[36]);
walloc_17bits w17_37(new_p[37], cout[36], cout[37], carry[37], s[37]);
walloc_17bits w17_38(new_p[38], cout[37], cout[38], carry[38], s[38]);
walloc_17bits w17_39(new_p[39], cout[38], cout[39], carry[39], s[39]);
walloc_17bits w17_40(new_p[40], cout[39], cout[40], carry[40], s[40]);
walloc_17bits w17_41(new_p[41], cout[40], cout[41], carry[41], s[41]);
walloc_17bits w17_42(new_p[42], cout[41], cout[42], carry[42], s[42]);
walloc_17bits w17_43(new_p[43], cout[42], cout[43], carry[43], s[43]);
walloc_17bits w17_44(new_p[44], cout[43], cout[44], carry[44], s[44]);
walloc_17bits w17_45(new_p[45], cout[44], cout[45], carry[45], s[45]);
walloc_17bits w17_46(new_p[46], cout[45], cout[46], carry[46], s[46]);
walloc_17bits w17_47(new_p[47], cout[46], cout[47], carry[47], s[47]);
walloc_17bits w17_48(new_p[48], cout[47], cout[48], carry[48], s[48]);
walloc_17bits w17_49(new_p[49], cout[48], cout[49], carry[49], s[49]);
walloc_17bits w17_50(new_p[50], cout[49], cout[50], carry[50], s[50]);
walloc_17bits w17_51(new_p[51], cout[50], cout[51], carry[51], s[51]);
walloc_17bits w17_52(new_p[52], cout[51], cout[52], carry[52], s[52]);
walloc_17bits w17_53(new_p[53], cout[52], cout[53], carry[53], s[53]);
walloc_17bits w17_54(new_p[54], cout[53], cout[54], carry[54], s[54]);
walloc_17bits w17_55(new_p[55], cout[54], cout[55], carry[55], s[55]);
walloc_17bits w17_56(new_p[56], cout[55], cout[56], carry[56], s[56]);
walloc_17bits w17_57(new_p[57], cout[56], cout[57], carry[57], s[57]);
walloc_17bits w17_58(new_p[58], cout[57], cout[58], carry[58], s[58]);
walloc_17bits w17_59(new_p[59], cout[58], cout[59], carry[59], s[59]);
walloc_17bits w17_60(new_p[60], cout[59], cout[60], carry[60], s[60]);
walloc_17bits w17_61(new_p[61], cout[60], cout[61], carry[61], s[61]);
walloc_17bits w17_62(new_p[62], cout[61], cout[62], carry[62], s[62]);
walloc_17bits w17_63(new_p[63], cout[62], cout[63], carry[63], s[63]);
walloc_17bits w17_64(new_p[64], cout[63], cout[64], carry[64], s[64]);
walloc_17bits w17_65(new_p[65], cout[64], cout[65], carry[65], s[65]);
walloc_17bits w17_66(new_p[66], cout[65], cout[66], carry[66], s[66]);
walloc_17bits w17_67(new_p[67], cout[66], cout[67], carry[67], s[67]);

wire [67:0] temp, ttemp;
cla_68bits cla68_0(s[67:0], {carry[66:0], 1'b0}, 1'b0, temp[67:0]);
cla_68bits cla68_1(temp, C, 1'b0, ttemp);
assign res = ttemp[63:0];
endmodule