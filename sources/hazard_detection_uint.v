`include "head.v"

module hazard_detection_uint(
    input wire [4:0]    id_exe_rt,
    input wire [4:0]    id_exe_rs,
    input wire [4:0]    if_id_rs,
    input wire [4:0]    if_id_rt,
    input wire          id_exe_mem_read,
    input wire          branchD,
    input wire          RegWriteE,
    input wire [4:0]    Write_Reg_AddressE,
    input wire [4:0]    Write_Reg_AddressM,
    input wire          Write_reg_muxM,
    output wire         stall,
    output wire         flush
);
wire lwstall, branchstall;

assign lwstall = ((id_exe_mem_read)
        &&((id_exe_rt==if_id_rs)||(id_exe_rt == if_id_rt)))
        ? 1'b1 : 1'b0;

assign branchstall = ((branchD)&&(RegWriteE)&&
                      ((Write_Reg_AddressE==id_exe_rs)||(Write_Reg_AddressE==id_exe_rt))
                    ||(branchD)&&(Write_reg_muxM)&&
                      ((Write_Reg_AddressM==id_exe_rs)||(Write_Reg_AddressM==id_exe_rt)))?
                    1:0;

assign stall = (lwstall|branchstall);
assign flush = stall;

endmodule