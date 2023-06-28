`define LENGTH      32
`define INITIAL_VAL 32'h00000000

//Definition of each operation code
`define ALU_OP_LENGTH       3
`define ALU_CONTROL_LENGTH  4
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
`define OP_XORI         6'b001110

//func
`define FUNC_ADDU       6'b100001
`define FUNC_SUBU       6'b100011
`define FUNC_AND        6'b100100
`define FUNC_XOR        6'b100110
`define FUNC_OR         6'b100101
`define FUNC_NOR        6'b100111
`define FUNC_SLLV       6'b000100
`define FUNC_SRAV       6'b000111
`define FUNC_SRLV       6'b000110

//ALU OP
`define ALU_OP_ADD          3'b000
`define ALU_OP_SUB          3'b001
`define ALU_OP_ORI          3'b010
`define ALU_OP_R_TYPE       3'b011
`define ALU_OP_XORI         3'b100

`define ALU_CONTROL_ADD     4'b0000
`define ALU_CONTROL_ADDU    4'b0001
`define ALU_CONTROL_SUBU    4'b0010
`define ALU_CONTROL_ORI     4'b0011
`define ALU_CONTROL_AND     4'b0100
`define ALU_CONTROL_OR      4'b0101 
`define ALU_CONTROL_NOR     4'b0111 
`define ALU_CONTROL_XOR     4'b1000 
`define ALU_CONTROL_SLLV    4'b1001 
`define ALU_CONTROL_SRAV    4'b1010 
`define ALU_CONTROL_SRLV    4'b1011 
`define ALU_CONTROL_XORI    4'b1100
`define ALU_CONTROL_MULTU   4'b1101 
`define ALU_CONTROL_DIVU    4'b1111
//EXTEND OP
`define EXT_OP_SIGNED   1'b0
`define EXT_OP_UNSIGNED 1'b1
//NPC OP
// `define 