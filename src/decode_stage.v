// RISC-V Pipelined Processor: Stage 2 - Instruction Decode (ID)
// Author: Brajaraj Pal
// Project: Summer of Science (SoS) 2026

module decode_stage (
    input clk,
    input reset,
    input [31:0] instruction,
    input [31:0] write_data,
    input reg_write,           // Control signal from Write-Back stage
    input [4:0] write_reg,     // Destination register from Write-Back
    output [31:0] read_data1,
    output [31:0] read_data2,
    output [31:0] imm_ext      // Sign-extended immediate
);

    // 32 General Purpose Registers (x0 is hardwired to 0)
    reg [31:0] registers [31:0];

    // Read Ports (Asynchronous read for faster decode)
    wire [4:0] rs1 = instruction[19:15];
    wire [4:0] rs2 = instruction[24:20];
    
    assign read_data1 = (rs1 == 5'b0) ? 32'b0 : registers[rs1];
    assign read_data2 = (rs2 == 5'b0) ? 32'b0 : registers[rs2];

    // Write Port (Synchronous write, happens on falling edge to help with data hazards)
    always @(negedge clk) begin
        if (reg_write && write_reg != 5'b0) begin
            registers[write_reg] <= write_data;
        end
    end

    // Basic Sign Extension (for I-type instructions as starting point)
    assign imm_ext = {{20{instruction[31]}}, instruction[31:20]};

endmodule
