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

module tb_memory_cycle();

    // Declare I/O
    reg clk = 1, rst;
    reg RegWriteM, MemWriteM, ResultSrcM;
    reg [4:0] RD_M;
    reg [31:0] PCPlus4M, WriteDataM, ALU_ResultM;
    wire RegWriteW, ResultSrcW;
    wire [4:0] RD_W;
    wire [31:0] PCPlus4W, ALU_ResultW, ReadDataW;

    // Declare the design under test
    memory_cycle dut (
        .clk(clk),
        .rst(rst),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .RD_M(RD_M),
        .PCPlus4M(PCPlus4M),
        .WriteDataM(WriteDataM),
        .ALU_ResultM(ALU_ResultM),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .RD_W(RD_W),
        .PCPlus4W(PCPlus4W),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW(ReadDataW)
    );

    // Generation of clock
    always begin
        clk = ~clk;
        #50;
    end

    // Dump waveform
    initial begin
        $dumpfile("memory_dump.vcd");
        $dumpvars(0);
    end

    // Provide the Stimulus
    initial begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;

        // Test Case: Initialize inputs
        RegWriteM <= 1'b0;
        MemWriteM <= 1'b0;
        ResultSrcM <= 1'b0;
        RD_M <= 5'h0;
        PCPlus4M <= 32'h00000000;
        WriteDataM <= 32'hA5A5A5A5; 
        ALU_ResultM <= 32'h00000004; 

        #100;

        // Test Case 1: Write to memory
        MemWriteM <= 1'b1;
        RegWriteM <= 1'b1;
        RD_M <= 5'h1;
        #10;

        // Test Case 2: Read from memory
        MemWriteM <= 1'b0;
        ResultSrcM <= 1'b1;
        #10;

        #500;
        $finish;
    end

endmodule

