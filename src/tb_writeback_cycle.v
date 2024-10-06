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

module tb_writeback_cycle();

    // Declare I/O
    reg clk = 1, rst, ResultSrcW;
    reg [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
    wire [31:0] ResultW;

    // Declare the design under test
    writeback_cycle dut (
        .clk(clk), 
        .rst(rst), 
        .ResultSrcW(ResultSrcW), 
        .PCPlus4W(PCPlus4W), 
        .ALU_ResultW(ALU_ResultW), 
        .ReadDataW(ReadDataW), 
        .ResultW(ResultW)
    );

    // Generation of clock
    always begin
        clk = ~clk;
        #50; // Clock period
    end

    // Dump file for waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end

    // Provide the Stimulus
    initial begin
        rst <= 1'b0; // Initial reset state
        #200; // Wait for 200 time units
        rst <= 1'b1; // Deactivate reset
        ResultSrcW <= 1'b0; // Initialize ResultSrcW
        PCPlus4W <= 32'h00000004; // Sample PC+4 value
        ALU_ResultW <= 32'h0000000A; // Sample ALU result
        ReadDataW <= 32'h00000005; // Sample Read data
        #500; // Wait for 500 time units
        $finish; // End the simulation
    end

endmodule
