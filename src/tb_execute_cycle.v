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

module tb_execute_cycle();

    // Declare I/O
    reg clk = 1, rst;
    reg RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    reg [2:0] ALUControlE;
    reg [31:0] RD1_E, RD2_E, Imm_Ext_E, PCE, PCPlus4E, ResultW;
    reg [4:0] RD_E;
    reg [1:0] ForwardA_E, ForwardB_E;
    
    wire PCSrcE;
    wire RegWriteM, MemWriteM, ResultSrcM;
    wire [4:0] RD_M;
    wire [31:0] PCPlus4M, WriteDataM, ALU_ResultM, PCTargetE;

    // Declare the design under test
    execute_cycle dut (
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

    // Generation of clock
    always begin
        clk = ~clk;
        #5; // Toggle every 5 time units
    end

    // Waveform dumping
    initial begin
        $dumpfile("execute_dump.vcd");
        $dumpvars(0);
    end

    // Provide the stimulus
    initial begin
        rst = 1'b1;
        #20;
        rst = 1'b0; // Deactivate reset
        #10;
        rst = 1'b1; // Activate reset

        // Test case setup
        #10;
        RegWriteE = 1'b1;
        ALUSrcE = 1'b1;
        MemWriteE = 1'b0;
        ResultSrcE = 1'b0;
        BranchE = 1'b0;
        ALUControlE = 3'b010; // Example: ADD
        RD1_E = 32'h00000001;
        RD2_E = 32'h00000002;
        Imm_Ext_E = 32'h00000003;
        RD_E = 5'b00001;
        PCE = 32'h00000000;
        PCPlus4E = 32'h00000004;
        ResultW = 32'h00000000;
        ForwardA_E = 2'b00;
        ForwardB_E = 2'b00;

        #50; // Wait and finish
        $finish;
    end

endmodule
