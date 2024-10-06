//    Modifications made by Praveen S G in 2024.

// Copyright 2023 MERL-DSU

//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at

//        http://www.apache.org/licenses/LICENSE-2.0

//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

module PC_Module(clk,rst,PC,PC_Next);
    // Inputs
    input clk, rst;             // Clock and reset signals
    input [31:0] PC_Next;      // Next program counter value
    
    // Output
    output [31:0] PC;          // Current program counter value
    reg [31:0] PC;             // Register to hold the program counter value

    // Program Counter logic
    always @(posedge clk) begin
        if (rst == 1'b0)        // On reset
            PC <= {32{1'b0}};   // Set PC to 0
        else
            PC <= PC_Next;      // Update PC with next value
    end
endmodule
