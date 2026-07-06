// RISC-V Pipelined Processor: Stage 5 - Write-Back (WB)
// Author: Brajaraj Pal
// Project: Summer of Science (SoS) 2026

module writeback_stage (
    input [31:0] alu_result,  // Data from Execute stage
    input [31:0] read_data,   // Data from Memory stage
    input mem_to_reg,         // Control signal: 1 for Mem->Reg (lw), 0 for ALU->Reg (R-type)
    output [31:0] write_data  // Data to be written into the Register File
);

    // Multiplexer to select data source for Write-Back
    assign write_data = mem_to_reg ? read_data : alu_result;

endmodule
