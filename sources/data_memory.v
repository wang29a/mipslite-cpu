`include "head.v"
module data_memory(
    input wire          clk,
    input wire          wen,

    input wire [`DATA_MEM_ADDRESS+1:2]   address,
    input wire [31:0]   write_data,

    output wire [31:0]  read_data
);

reg [31:0] dm[0:`DATA_MEM_LENGTH-1];

assign read_data = dm[address];

always @(posedge clk) begin
    if (wen) 
        dm[address] <= write_data;
end

// integer i;
initial begin
    $readmemh("data.txt", dm);
end

endmodule