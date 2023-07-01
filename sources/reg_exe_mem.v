`include "head.v"
`timescale 1ns / 1ps
module reg_exe_mem(
    input wire                  clk,
    input wire                  rst,
    input wire                  Memwrite_in,
    input wire                  RegWrite_in,
    input wire                  Write_reg_mux_in,
    input wire [`LENGTH-1:0]    ALU_out_in,
    input wire [`LENGTH-1:0]    Write_memory_Data_in,
    input wire                  zero_in,
    input wire [4:0]            Write_Reg_Address_in,
    
    output reg                  Memwrite_out,
    output reg                  RegWrite_out,
    output reg                  Write_reg_mux_out,
    output reg [`LENGTH-1:0]    ALU_out_out,
    output reg [`LENGTH-1:0]    Write_memory_Data_out,
    output reg                  zero_out,
    output reg [4:0]            Write_Reg_Address_out
);

always @(posedge clk) begin
    if (rst) begin
        Memwrite_out            <= 1'b0;
        RegWrite_out            <= 1'b0;
        Write_reg_mux_out       <= 1'b0;
        ALU_out_out             <= `INITIAL_VAL_32;
        Write_memory_Data_out        <= `INITIAL_VAL_32;
        zero_out                <= 1'b0;
        Write_Reg_Address_out   <= `INITIAL_VAL_6;
    end
    else begin
        Memwrite_out            <= Memwrite_in;
        RegWrite_out            <= RegWrite_in;
        ALU_out_out             <= ALU_out_in;
        Write_reg_mux_out       <= Write_reg_mux_in;
        Write_memory_Data_out   <= Write_memory_Data_in;
        zero_out                <= zero_in;
        Write_Reg_Address_out   <= Write_Reg_Address_in;
    end
end

endmodule