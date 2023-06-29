`include "head.v"
module reg_mem_wb(
    input wire                  clk,
    input wire                  rst,
    input wire                  RegWrite_in,
    input wire [`LENGTH-1:0]    Read_memory_data_in,
    input wire [4:0]            Write_Reg_Address_in,
    input wire [`LENGTH-1:0]    ALU_out_in,
    input wire                  Write_reg_mux_in,

    output reg                  Write_reg_mux_out,
    output reg                  RegWrite_out,
    output reg [`LENGTH-1:0]    Read_memory_data_out,
    output reg [4:0]            Write_Reg_Address_out,
    output reg [`LENGTH-1:0]    ALU_out_out
);

always @(posedge clk) begin
    if (rst) begin
        RegWrite_out            <= 1'b0;
        Read_memory_data_out    <= `INITIAL_VAL_32;
        Write_Reg_Address_out   <= `INITIAL_VAL_32;
        ALU_out_out             <= `INITIAL_VAL_32;
        Write_reg_mux_out       <= 1'b0;
    end
    else begin
        RegWrite_out            <= RegWrite_in;
        Read_memory_data_out    <= Read_memory_data_in;
        Write_Reg_Address_out   <= Write_Reg_Address_in;
        ALU_out_out             <= ALU_out_in;
        Write_reg_mux_out       <= Write_reg_mux_in;
    end
end

endmodule