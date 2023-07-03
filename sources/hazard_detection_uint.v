`include "head.v"
`timescale 1ns / 1ps
module hazard_detection_uint(
    input wire [4:0]    rtE,
    input wire [4:0]    rsE,
    input wire [4:0]    rsD,
    input wire [4:0]    rtD,
    input wire          id_exe_mem_read,
    input wire          branchD,
    input wire          RegWriteE,
    input wire [4:0]    Write_Reg_AddressE,
    input wire [4:0]    Write_Reg_AddressM,
    input wire          Write_reg_muxM,
    output wire         stallF,
    output wire         stallD,
    output wire         flush
);
wire lwstall, branchstall;

assign lwstall = ((id_exe_mem_read)
        &&(((rtE!=0)&&(rtE==rsD))||((rtE!=0)&&(rtE == rtD))))
        ? 1'b1 : 1'b0;

assign branchstall = (branchD&
                    (RegWriteE&
                     ((Write_Reg_AddressE==rsD)|(Write_Reg_AddressE==rtD))) |
                     (Write_reg_muxM&
                     ((Write_Reg_AddressM==rsD)|(Write_Reg_AddressM==rtD))));

assign stallD = (lwstall
                |branchstall
);
assign stallF = stallD;
assign flush = stallD;

endmodule