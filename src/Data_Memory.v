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

module Data_Memory(clk, rst, WE, WD, A, RD);

    // Inputs
    input clk, rst, WE;              // Clock, reset, and write enable
    input [31:0] A, WD;              // Address and write data

    // Output
    output [31:0] RD;                // Read data

    reg [31:0] mem [1023:0];         // Memory array (1K x 32-bit)

    // Write operation on rising edge of clock if WE (write enable) is high
    always @ (posedge clk) begin
        if (WE)
            mem[A] <= WD;            // Write data to memory at address A
    end

    // Read operation; if reset is not asserted, RD is zero
    assign RD = (~rst) ? 32'd0 : mem[A];

    // Initialize memory (optional values)
    initial begin
        mem[0] = 32'h00000000;
        // mem[40] = 32'h00000002;   // Example initialization (commented out)
    end

endmodule
