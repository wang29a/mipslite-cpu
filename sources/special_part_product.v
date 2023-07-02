module s_part_product(
    input  _X,
    input [2:0] src,
    output p
);
wire y_add, y, y_sub;
wire sel_negative,  sel_positive;
wire x_0, x_sub;
assign {y_add, y, y_sub} = src;
assign x_0 = _X;
assign sel_negative =  y_add & (y & ~y_sub | ~y & y_sub);
assign sel_positive = ~y_add & (y & ~y_sub | ~y & y_sub);
assign p = ~(~(sel_negative & ~x_0)  
           & ~(sel_positive & x_0 ) );
endmodule