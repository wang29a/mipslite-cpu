module grp(
    input           clk,
    input           wen,
    input  [4:0]    r1, r2, r3,
    input  [31:0]   WD,
    output [31:0]   RD1, RD2
);
    reg [31:0] reg_file[0:31];
    integer i;
    initial begin
        for (i=0; i<=31; i=i+1) reg_file[i] = 0;
    end

    always @(posedge clk) begin
        if (wen && rd) begin
            reg_file[rd] <= WD;
        end
        else if (wen) begin
            reg_file[rd] <= 0;
        end
    end
    assign RD1 = reg_file[rs];
    assign RD2 = reg_file[rd];
endmodule