`include "head.v"
module extend(
    input [15:0]        imm16,
    input               ext_op,
    output reg[31:0]    ext_out
);

always @(*) begin
    case (ext_op)
        0:
            ext_out <= {16'b0, imm16};
        1:
            ext_out <= {{16{imm16[15]}}, imm16};
        default:
            ext_out <= {16'b0, imm16};
    endcase
end

endmodule