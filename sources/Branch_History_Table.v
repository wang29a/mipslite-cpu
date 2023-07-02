`include "head.v"

module Branch_History_Table(
    input wire clk,
    input wire rst,
    input wire jmp,
    input wire [7:0] address,

    output predict,
    output [1:0] state
);
    reg [1:0] BHT[0:8];
    reg [7:0] pre_address;
    reg [1:0] next_state;

    integer i;
    initial begin
        for (i = 0; i < 8; i=i+1) begin
            BHT[i] = 2'b11;
        end
    end
    
    always @(posedge clk) begin
        if (rst) begin
            pre_address <= address;
        end
        else begin
            BHT[pre_address] <= next_state;
        end
    end

    always @( *) begin
        if(jmp) begin
           case (BHT[pre_address])
            2'b11: next_state = 2'b11;
            2'b10: next_state = 2'b11;
            2'b01: next_state = 2'b10;
            2'b00: next_state = 2'b01;
            default: 
                next_state = 2'b11;
           endcase 
        end
        else begin
           case (BHT[pre_address])
            2'b11: next_state = 2'b10;
            2'b10: next_state = 2'b01;
            2'b01: next_state = 2'b00;
            2'b00: next_state = 2'b00;
            default: 
                next_state = 2'b00;
           endcase 
        end
    end

assign predict = (BHT[address][0])&(rst);
assign state = BHT[address];
endmodule
