
module instruction_memory(
    input wire [31:0] pc,
    output wire instruction
);

reg[31:0] im[4095:0];
assign instruction = im[pc];

endmodule