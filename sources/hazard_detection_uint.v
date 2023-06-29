`include "head.v"

module hazard_detection_uint(
    input wire [4:0]    id_exe_rt,
    input wire [4:0]    if_id_rs,
    input wire [4:0]    if_id_rt,
    input wire          id_exe_mem_read,
    output wire         stall
);

assign stall = ((id_exe_mem_read)
        &&((id_exe_rt==if_id_rs)||(id_exe_rt == if_id_rt)))
        ? 1'b0 : 1'b1;

endmodule