module part_product(
    input [67:0] _X,
    input [2:0] src,
    output [67:0]p,
    output [1:0]c
);
wire y_add, y, y_sub;
wire sel_negative, sel_double_negative, sel_positive, sel_double_positive;
assign {y_add, y, y_sub} = src;
assign sel_negative =  y_add & (y & ~y_sub | ~y & y_sub);
assign sel_positive = ~y_add & (y & ~y_sub | ~y & y_sub);
assign sel_double_negative =  y_add & ~y & ~y_sub;
assign sel_double_positive = ~y_add &  y &  y_sub;
assign p[0] = ~(~(sel_negative & ~_X[0]) & ~(sel_positive & _X[0]));
assign c[1] = sel_double_negative;
assign c[0] = sel_negative;

genvar  i;
generate
    for(i = 1; i < 68; i = i + 1)
    begin:bit
    assign p[i] = ~(~(sel_negative & ~_X[i]) & ~(sel_double_negative & ~_X[i-1]) 
           & ~(sel_positive & _X[i] ) & ~(sel_double_positive &  _X[i-1]));
    end
endgenerate
endmodule