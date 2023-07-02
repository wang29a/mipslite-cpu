module get_c(
    input [2:0] src,
    // output c
    output [1:0] c
);
wire y_add, y, y_sub;
wire sel_negative, sel_double_negative, sel_positive, sel_double_positive;
assign {y_add, y, y_sub} = src;
assign sel_negative =  y_add & (y & ~y_sub | ~y & y_sub);
assign sel_positive = ~y_add & (y & ~y_sub | ~y & y_sub);
assign sel_double_negative =  y_add & ~y & ~y_sub;
assign sel_double_positive = ~y_add &  y &  y_sub;
// assign c = sel_double_negative | sel_negative;
assign c[1] = sel_double_negative;
assign c[0] = sel_negative;
endmodule