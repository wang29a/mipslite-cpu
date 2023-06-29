`include "head.v"
module multiplier(
    input wire [`LENGTH-1:0] SrcA, SrcB,
    output wire [`LENGTH*2-1:0] res
);
wire [`LENGTH-1:0] temp[0:`LENGTH];
wire [`LENGTH-2:0] carry[0:`LENGTH];
wire [`LENGTH-1:0] s[0:`LENGTH];
generate
    for (genvar i = 0; i < `LENGTH; i = i + 1) begin
      for(genvar j = 0; j < `LENGTH; j = j + 1)
        assign temp[i][j] = SrcA[j] & SrcB[i]; 
    end
    for(genvar i = 0; i < `LENGTH; i = i + 1)begin
         assign temp[`LENGTH][i] = 1'b0;
    end
    for(genvar i = 0; i < `LENGTH - 1; i = i + 1)begin
        assign carry[0][i] = 0;
    end
    for(genvar i = 0; i < `LENGTH; i = i + 1)begin
        assign s[0][i] = temp[0][i];
    end
    assign res[0] = temp[0][0];
    for(genvar i = 1; i <= `LENGTH; i = i + 1)begin
        for(genvar j = 0; j < `LENGTH - 1; j = j + 1)begin
            assign s[i][j] = temp[i][j] ^ s[i-1][j+1] ^ carry[i-1][j];
            assign carry[i][j] = temp[i][j] & s[i-1][j+1] | (temp[i][j] ^ s[i-1][j+1]) & carry[i-1][j];
        end
        assign s[i][`LENGTH-1] = temp[i][`LENGTH-1];
        assign res[i] = s[i][0];
    end
    for(genvar i = `LENGTH + 1; i <= `LENGTH * 2 - 2; i = i + 1)begin
        assign res[i] = s[`LENGTH][i-`LENGTH];
        end
    assign res[2*`LENGTH-1] = carry[`LENGTH][`LENGTH-2];
endgenerate 
endmodule