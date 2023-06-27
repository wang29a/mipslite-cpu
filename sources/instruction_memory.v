`include "head.v"
module instruction_memory(
    input wire [`LENGTH-1:0] pc,
    output wire [`LENGTH-1:0] instruction
);

reg[31:0] im[0:`INST_MEM_LENGTH-1];
assign instruction = im[pc];

initial begin
    $readmemh("data.txt", im); // Read hexadecimal values from "data.txt" into memory
end
integer i;

initial begin
    for (i = 0; i < `INST_MEM_LENGTH; i = i + 1)
        $display("IM[%d] = %d", i, im[i]);
end

endmodule