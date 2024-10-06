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

module tb_decode_cycle();

    // Declare I/O
    reg clk = 1, rst, RegWriteW;
    reg [4:0] RDW;
    reg [31:0] InstrD, PCD, PCPlus4D, ResultW;
    wire RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    wire [2:0] ALUControlE;
    wire [31:0] RD1_E, RD2_E, Imm_Ext_E;
    wire [4:0] RS1_E, RS2_E, RD_E;
    wire [31:0] PCE, PCPlus4E;

    // Declare the design under test
    decode_cycle dut (
        .clk(clk), 
        .rst(rst), 
        .InstrD(InstrD), 
        .PCD(PCD), 
        .PCPlus4D(PCPlus4D), 
        .RegWriteW(RegWriteW), 
        .RDW(RDW), 
        .ResultW(ResultW), 
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
        .RS1_E(RS1_E), 
        .RS2_E(RS2_E)
    );

    // Generation of clock
    always begin
        clk = ~clk;
        #50; // Toggle clock every 50 time units
    end

    // Initial block for waveform dumping
    initial begin
        $dumpfile("decode_dump.vcd");
        $dumpvars(0);
    end

    // Provide the stimulus
    initial begin
        rst <= 1'b0; // Assert reset
        #200;        // Wait for 200 time units
        rst <= 1'b1; // Deassert reset
        
        // Initializing inputs
        InstrD <= 32'h00000000; // Sample instruction
        PCD <= 32'h00000000;    // Program counter data
        PCPlus4D <= 32'h00000004; // Next program counter data
        RegWriteW <= 1'b0;      // Initially, no write to register
        RDW <= 5'b00000;        // Destination register
        ResultW <= 32'h00000000; // Sample result
        #500; // Wait for 500 time units

        // You can add more stimulus here as needed

        $finish; // Finish simulation
    end

endmodule
