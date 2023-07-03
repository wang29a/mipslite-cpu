`define LENGTH      32
`define INITIAL_VAL 32'h00000000

//Definition of each operation code
`define ALU_OP_LENGTH       3
`define ALU_CONTROL_LENGTH  5
`define INST_MEM_LENGTH     64
`define DATA_MEM_LENGTH     64

`define INST_MEM_ADDRESS    6
`define DATA_MEM_ADDRESS    6

//Define opcode
`define OP_R_TYPE       6'b000000
`define OP_ORI          6'b001101
`define OP_LW           6'b100011
`define OP_SW           6'b101011
`define OP_BEQ          6'b000100
`define OP_JAL          6'b000011
`define OP_XORI         6'b001110
`define OP_ANDI         6'b001100
`define OP_ADDI         6'b001000

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
`define FUNC_MULTU      6'b011001 
`define FUNC_DIVU       6'b011011 
`define FUNC_MFHI       6'b010000 
`define FUNC_MFLO       6'b010010
`define FUNC_MTHI       6'b010001
`define FUNC_MTLO       6'b010011 
`define FUNC_MULT       6'b011000
//ALU OP
// `define ALU_OP_ADD          3'b000
// `define ALU_OP_SUB          3'b001
`define ALU_OP_ORI          3'b010
`define ALU_OP_R_TYPE       3'b011
`define ALU_OP_XORI         3'b100
`define ALU_OP_ANDI         3'b101
`define ALU_OP_ADDI         3'b110

`define ALU_CONTROL_ADD     5'b00000
`define ALU_CONTROL_ADDU    5'b00001
`define ALU_CONTROL_SUBU    5'b00010
`define ALU_CONTROL_ORI     5'b00011
`define ALU_CONTROL_AND     5'b00100
`define ALU_CONTROL_OR      5'b00101 
`define ALU_CONTROL_NOR     5'b00111 
`define ALU_CONTROL_XOR     5'b01000 
`define ALU_CONTROL_SLLV    5'b01001 
`define ALU_CONTROL_SRAV    5'b01010 
`define ALU_CONTROL_SRLV    5'b01011 
`define ALU_CONTROL_XORI    5'b01100
`define ALU_CONTROL_MULTU   5'b01101 
`define ALU_CONTROL_DIVU    5'b01111
`define ALU_CONTROL_MTHI    5'b10000
`define ALU_CONTROL_MTLO    5'b10001 
`define ALU_CONTROL_MFHI    5'b10010 
`define ALU_CONTROL_MFLO    5'b10011
`define ALU_CONTROL_ANDI    5'b10100
`define ALU_CONTROL_ADDI    5'b10101
`define ALU_CONTROL_MULT    5'b10110
//EXTEND OP
`define EXT_OP_SIGNED   1'b0
`define EXT_OP_UNSIGNED 1'b1
//NPC OP
// `define 

//define initial values
`define INITIAL_VAL_32      32'h00000000
`define INITIAL_VAL_6       6'b000000
