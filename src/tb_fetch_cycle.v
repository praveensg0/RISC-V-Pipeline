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

module tb();

    // Declare I/O
    reg clk =1, rst, PCSrcE;
    reg [31:0] PCTargetE;
    wire [31:0] InstrD, PCD, PCPlus4D;

    // Declare the design under test
    fetch_cycle dut (
                    .clk(clk), 
                    .rst(rst), 
                    .PCSrcE(PCSrcE), 
                    .PCTargetE(PCTargetE), 
                    .InstrD(InstrD), 
                    .PCD(PCD), 
                    .PCPlus4D(PCPlus4D)
                    );
    
    // Generation of clocl
    always begin
        clk = ~clk;
        #50;
    end

    // Generation of clocl
    initial begin
        $dumpfile("fetch_dump.vcd");
        $dumpvars(0);
    end

    // Provide the Stimulus
    initial begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;
        PCSrcE <= 1'b0;
        PCTargetE <= 32'h00000000;
        #500;
        $finish;
    end

endmodule
