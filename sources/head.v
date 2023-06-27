`define LENGTH      32
`define INITIAL_VAL 32'h00000000

//Definition of each operation code
`define ALU_OP_LENGTH       2
`define ALU_CONTROL_LENGTH  3
`define INST_MEM_LENGTH     8
`define DATA_MEM_LENGTH     64

`define INST_MEM_ADDRESS    3
`define DATA_MEM_ADDRESS    6

//Define opcode
`define OP_R_TYPE       6'b000000
`define OP_ORI          6'b001101
`define OP_LW           6'b100011
`define OP_SW           6'b101011
`define OP_BEQ          6'b000100
`define OP_JAL          6'b000011

//func
`define FUNC_ADDU       6'b100001
`define FUNC_SUBU       6'b100011
//ALU OP
`define ALU_OP_ADD          2'b00
`define ALU_OP_SUB          2'b01
`define ALU_OP_ORI          2'b10
`define ALU_OP_R_TYPE       2'b11

`define ALU_CONTROL_ADD     3'b000
`define ALU_CONTROL_ADDU    3'b001
`define ALU_CONTROL_SUBU    3'b010
`define ALU_CONTROL_ORI     3'b011

//EXTEND OP
`define EXT_OP_SIGNED   1'b0
`define EXT_OP_UNSIGNED 1'b1
//NPC OP
// `define 