
module data_memory(
    input wire          clk,
    input wire          wen,

    input wire [31:0]   address,
    input wire [31:0]   write_data,

    output wire [31:0]  read_data
);

reg [31:0] dm[4095:0];

assign read_data = dm[address];

always @(posedge clk) begin
    if (wen) 
        dm[address] <= write_data;
end

endmodule