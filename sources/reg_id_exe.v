`include "head.v"
`timescale 1ns / 1ps
module reg_id_exe(
    input wire                          clk,
    input wire                          rst,
    input wire                          wen,
    input wire                          flush, 
    input wire                          RegDst_in,
    input wire [`ALU_OP_LENGTH-1:0]     ALUOp_in,
    input wire                          Write_reg_mux_in,
    input wire                          Memwrite_in,
    input wire                          Memread_in,
    input wire                          ALUsrc_in,
    input wire                          RegWrite_in,
    input wire [`LENGTH-1:0]            Read_data_1_in,
    input wire [`LENGTH-1:0]            Read_data_2_in,
    input wire [`LENGTH-1:0]            imm_ext_in,
    input wire [4:0]                    rt_in,
    input wire [4:0]                    rd_in,
    input wire [4:0]                    rs_in,

    output reg                          RegDst_out,
    output reg [`ALU_OP_LENGTH-1:0]     ALUOp_out,
    output reg                          Write_reg_mux_out,
    output reg                          Memwrite_out,
    output reg                          Memread_out,
    output reg                          ALUsrc_out,
    output reg                          RegWrite_out,
    output reg [`LENGTH-1:0]            Read_data_1_out,
    output reg [`LENGTH-1:0]            Read_data_2_out,
    output reg [`LENGTH-1:0]            imm_ext_out,
    output reg [4:0]                    rt_out,
    output reg [4:0]                    rd_out,
    output reg [4:0]                    rs_out
);

always @(posedge clk) begin
    if (rst) begin
        RegDst_out          <= 1'b0;
        ALUOp_out           <= 2'b0;
        Write_reg_mux_out   <= 1'b0;
        Memwrite_out        <= 1'b0;
        Memread_out        <= 1'b0;
        ALUsrc_out          <= 1'b0;
        RegWrite_out        <= 1'b0;
        Read_data_1_out     <= `INITIAL_VAL_32;
        Read_data_2_out     <= `INITIAL_VAL_32;
        imm_ext_out         <= `INITIAL_VAL_32;
        rt_out              <= `INITIAL_VAL_6;
        rd_out              <= `INITIAL_VAL_6;
        rs_out              <= `INITIAL_VAL_6;
    end
    else if (flush) begin
        RegDst_out          <= 1'b0;
        ALUOp_out           <= 2'b0;
        Write_reg_mux_out   <= 1'b0;
        Memwrite_out        <= 1'b0;
        Memread_out         <= 1'b0;
        ALUsrc_out          <= 1'b0;
        RegWrite_out        <= 1'b0;
        Read_data_1_out     <= `INITIAL_VAL_32;
        Read_data_2_out     <= `INITIAL_VAL_32;
        imm_ext_out         <= `INITIAL_VAL_32;
        rt_out              <= `INITIAL_VAL_6;
        rd_out              <= `INITIAL_VAL_6;
        rs_out              <= `INITIAL_VAL_6;
    end
    // else if(wen) begin
    else  begin
        RegDst_out          <= RegDst_in;
        ALUOp_out           <= ALUOp_in;
        Write_reg_mux_out   <= Write_reg_mux_in;
        Memwrite_out        <= Memwrite_in;
        Memread_out        <= Memread_in;
        ALUsrc_out          <= ALUsrc_in;
        RegWrite_out        <= RegWrite_in;
        Read_data_1_out     <= Read_data_1_in;
        Read_data_2_out     <= Read_data_2_in;
        imm_ext_out         <= imm_ext_in;
        rt_out              <= rt_in;
        rd_out              <= rd_in;
        rs_out              <= rs_in;
    end
end

endmodule