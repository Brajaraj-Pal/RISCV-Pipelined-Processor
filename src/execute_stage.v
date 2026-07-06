// RISC-V Pipelined Processor: Stage 3 - Execute (EX)
// Author: Brajaraj Pal
// Project: Summer of Science (SoS) 2026

module execute_stage (
    input [31:0] read_data1,
    input [31:0] read_data2,
    input [31:0] imm_ext,
    input alu_src,            // Control signal to select between rs2 and immediate
    input [3:0] alu_control,  // Control signal for ALU operation
    output reg [31:0] alu_result,
    output zero               // Used for branch evaluation
);

    // ALU input multiplexer: selects between register data and sign-extended immediate
    wire [31:0] alu_in2 = alu_src ? imm_ext : read_data2;

    // ALU Logic
    always @(*) begin
        case (alu_control)
            4'b0000: alu_result = read_data1 & alu_in2; // AND
            4'b0001: alu_result = read_data1 | alu_in2; // OR
            4'b0010: alu_result = read_data1 + alu_in2; // ADD
            4'b0110: alu_result = read_data1 - alu_in2; // SUB
            default: alu_result = 32'b0; // Default case
        endcase
    end

    // Zero flag generation for conditional branches
    assign zero = (alu_result == 32'b0) ? 1'b1 : 1'b0;

endmodule
