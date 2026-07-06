// RISC-V Pipelined Processor: Stage 4 - Memory Access (MEM)
// Author: Brajaraj Pal
// Project: Summer of Science (SoS) 2026

module memory_stage (
    input clk,
    input mem_read,          // Control signal for 'lw' instruction
    input mem_write,         // Control signal for 'sw' instruction
    input [31:0] alu_result, // Address calculated in Execute stage
    input [31:0] write_data, // Data to store (from rs2)
    output [31:0] read_data  // Data loaded from memory
);

    // Data Memory: Array of 256 words (1KB total) for basic testing
    reg [31:0] data_memory [0:255];

    // Synchronous Write Operation (Happens on clock edge)
    always @(posedge clk) begin
        if (mem_write) begin
            // Using word-aligned addressing (shifting right by 2 or dividing by 4)
            data_memory[alu_result[9:2]] <= write_data;
        end
    end

    // Asynchronous Read Operation
    assign read_data = (mem_read) ? data_memory[alu_result[9:2]] : 32'b0;

endmodule
