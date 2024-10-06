// Copyright 2024 Praveen S G

//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at

//        http://www.apache.org/licenses/LICENSE-2.0

//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

module tb_execute_cycle;

    // Declare testbench signals
    reg clk;
    reg rst;
    reg RegWriteE;
    reg ALUSrcE;
    reg MemWriteE;
    reg ResultSrcE;
    reg BranchE;
    reg [2:0] ALUControlE;
    reg [31:0] RD1_E;
    reg [31:0] RD2_E;
    reg [31:0] Imm_Ext_E;
    reg [4:0] RD_E;
    reg [31:0] PCE;
    reg [31:0] PCPlus4E;
    reg [31:0] ResultW;
    reg [1:0] ForwardA_E;
    reg [1:0] ForwardB_E;

    // Declare output signals
    wire PCSrcE;
    wire RegWriteM;
    wire MemWriteM;
    wire ResultSrcM;
    wire [4:0] RD_M;
    wire [31:0] PCPlus4M;
    wire [31:0] WriteDataM;
    wire [31:0] ALU_ResultM;
    wire [31:0] PCTargetE;

    // Instantiate the execute_cycle module
    execute_cycle uut (
        .clk(clk),
        .rst(rst),
        .RegWriteE(RegWriteE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .Imm_Ext_E(Imm_Ext_E),
        .RD_E(RD_E),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .ResultW(ResultW),
        .ForwardA_E(ForwardA_E),
        .ForwardB_E(ForwardB_E),
        .PCSrcE(PCSrcE),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .RD_M(RD_M),
        .PCPlus4M(PCPlus4M),
        .WriteDataM(WriteDataM),
        .ALU_ResultM(ALU_ResultM),
        .PCTargetE(PCTargetE)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test procedure
    initial begin
        // Initialize signals
        rst = 1;
        RegWriteE = 0;
        ALUSrcE = 0;
        MemWriteE = 0;
        ResultSrcE = 0;
        BranchE = 0;
        ALUControlE = 3'b000; // ALU operation code
        RD1_E = 32'h00000001; // Sample data
        RD2_E = 32'h00000002; // Sample data
        Imm_Ext_E = 32'h00000003; // Sample immediate value
        RD_E = 5'b00001; // Sample register destination
        PCE = 32'h00000000; // Sample PC value
        PCPlus4E = 32'h00000004; // Sample PC+4 value
        ResultW = 32'h00000000; // Result from Write stage
        ForwardA_E = 2'b00; // No forwarding
        ForwardB_E = 2'b00; // No forwarding

        // Apply reset
        #10;
        rst = 0; // Deactivate reset
        #10;
        rst = 1; // Activate reset

        // Test 1: Basic ALU operation
        #10;
        RegWriteE = 1;
        ALUSrcE = 1; // Use immediate value for ALU
        MemWriteE = 0;
        ResultSrcE = 0; // Example: Result goes to register
        BranchE = 0;
        ALUControlE = 3'b010; // Example: ADD operation
        
        #10; // Wait for clock edge
        // Check ALU result
        if (ALU_ResultM == (RD1_E + Imm_Ext_E)) 
            $display("Test 1 passed: ALU Result = %h", ALU_ResultM);
        else 
            $display("Test 1 failed: ALU Result = %h, expected %h", ALU_ResultM, RD1_E + Imm_Ext_E);
        
        // Test 2: Branch taken (example)
        #10;
        RegWriteE = 1;
        ALUSrcE = 0; // Use second register
        MemWriteE = 0;
        ResultSrcE = 0; 
        BranchE = 1; // Enable branching
        ALUControlE = 3'b110; // Example: Compare for branching
        
        #10; // Wait for clock edge
        // Check PCSrc
        if (PCSrcE)
            $display("Test 2 passed: Branch taken, PC Source = %b", PCSrcE);
        else
            $display("Test 2 failed: Branch not taken, PC Source = %b", PCSrcE);

        // Additional test cases can be added here

        // Finish the simulation
        #50;
        $finish;
    end

endmodule
