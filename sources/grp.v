`include "head.v"
module grp(
    input           clk,
    input           wen,
    input  [4:0]    r1, r2, r3,
    input  [31:0]   WD,
    output reg [31:0]   RD1, RD2
);
    reg [31:0] reg_file[0:31];
    // integer i;
    // initial begin
    //     for (i=0; i<=31; i=i+1) reg_file[i] = 0;
    // end

    always @(posedge clk) begin
        // RD1 <= (r1 == 5'b00000) ? `INITIAL_VAL_32 :reg_file[r1];
        // RD2 <= (r2 == 5'b00000) ? `INITIAL_VAL_32 :reg_file[r2];        
        if (wen & clk) begin
            reg_file[r3] <= WD;
        end
    end

    always @(*) begin
        if (wen && (r3 == r1) && (r1 != 5'b00000)) begin
           RD1 = WD;
        end
        else if (r1 != 5'b00000) begin
           RD1 = reg_file[r1];
        end
        else begin
           RD1 = `INITIAL_VAL_32; 
        end
        if (wen && (r3 == r2) && (r2 != 5'b00000)) begin
           RD2 = WD;
        end
        else if (r1 != 5'b00000) begin
           RD2 = reg_file[r2];
        end
        else begin
           RD2 = `INITIAL_VAL_32; 
        end
    end

    // assign RD1 = (r1 == 5'b00000) ? `INITIAL_VAL_32 :reg_file[r1];
    // assign RD2 = (r2 == 5'b00000) ? `INITIAL_VAL_32 :reg_file[r2];
endmodule