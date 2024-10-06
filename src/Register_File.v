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

module Register_File(clk, rst, WE3, WD3, A1, A2, A3, RD1, RD2);
    // Inputs
    input clk, rst, WE3;               // Clock, reset, and write enable
    input [4:0] A1, A2, A3;            // Register addresses
    input [31:0] WD3;                  // Data to write to the register
    
    // Outputs
    output [31:0] RD1, RD2;            // Read data outputs

    reg [31:0] Register [31:0];        // 32 general-purpose registers

    // Write logic for registers
    always @(posedge clk) begin
        if (WE3 & (A3 != 5'h00))        // Write data if enabled and address is not 0
            Register[A3] <= WD3;
    end

    // Read logic for registers
    assign RD1 = (rst == 1'b0) ? 32'd0 : Register[A1];  // Read data from register A1
    assign RD2 = (rst == 1'b0) ? 32'd0 : Register[A2];  // Read data from register A2

    initial begin
        Register[0] = 32'h00000000;  // Initialize register 0 to zero
    end

endmodule
