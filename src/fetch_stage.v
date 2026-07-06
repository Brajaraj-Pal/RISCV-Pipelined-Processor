// RISC-V Pipelined Processor: Stage 1 - Instruction Fetch (IF)
// Author: Brajaraj Pal
// Project: Summer of Science (SoS) 2026

module fetch_stage (
    input clk,
    input reset,
    input pc_src,                  // Branch decision from later stages (Hazard handling)
    input [31:0] branch_target,    // Target address for branch/jump
    input pc_write,                // Hazard mitigation: stall control
    output reg [31:0] pc_out,      // Current PC to instruction memory
    output [31:0] pc_plus_4        // Next sequential PC
);

    reg [31:0] pc_reg;

    // Next PC logic with MUX for branch targeting
    wire [31:0] next_pc = pc_src ? branch_target : (pc_reg + 4);

    // PC Update block (Sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_reg <= 32'b0;
        end else if (pc_write) begin
            pc_reg <= next_pc;
        end
    end

    // Assign outputs
    assign pc_out = pc_reg;
    assign pc_plus_4 = pc_reg + 4;

endmodule
