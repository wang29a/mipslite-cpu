`include "head.v"
module instruction_memory(
    input wire [`INST_MEM_ADDRESS+1:2] instruction_address,
    output wire [`LENGTH-1:0] instruction
);

reg[31:0] im[0:`INST_MEM_LENGTH-1];
assign instruction = im[instruction_address];

initial begin
    $readmemh("inst_2.txt", im); // Read hexadecimal values from "data.txt" into memory
end
integer i;

initial begin
    for (i = 0; i < `INST_MEM_LENGTH; i = i + 1)
        $display("IM[%d] = %x", i, im[i]);
end

endmodule