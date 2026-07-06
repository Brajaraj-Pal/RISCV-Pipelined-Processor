// RISC-V Pipelined Processor: Pipeline Registers (IF/ID, ID/EX, EX/MEM, MEM/WB)
// Author: Brajaraj Pal
// Project: Summer of Science (SoS) 2026

module pipeline_registers (
    input clk,
    input reset,
    
    // IF/ID Register
    input [31:0] if_pc,
    input [31:0] if_instr,
    output reg [31:0] id_pc,
    output reg [31:0] id_instr,
    
    // ID/EX Register
    input [31:0] id_read_data1,
    input [31:0] id_read_data2,
    input [31:0] id_imm_ext,
    input [4:0] id_rs1,
    input [4:0] id_rs2,
    input [4:0] id_rd,
    output reg [31:0] ex_read_data1,
    output reg [31:0] ex_read_data2,
    output reg [31:0] ex_imm_ext,
    output reg [4:0] ex_rs1,
    output reg [4:0] ex_rs2,
    output reg [4:0] ex_rd
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Clear all registers on reset
            id_pc <= 32'b0; id_instr <= 32'b0;
            ex_read_data1 <= 32'b0; ex_read_data2 <= 32'b0; ex_imm_ext <= 32'b0;
            ex_rs1 <= 5'b0; ex_rs2 <= 5'b0; ex_rd <= 5'b0;
        end else begin
            // Transfer data on clock edge
            id_pc <= if_pc; 
            id_instr <= if_instr;
            
            ex_read_data1 <= id_read_data1; 
            ex_read_data2 <= id_read_data2; 
            ex_imm_ext <= id_imm_ext;
            ex_rs1 <= id_rs1; 
            ex_rs2 <= id_rs2; 
            ex_rd <= id_rd;
        end
    end

endmodule
