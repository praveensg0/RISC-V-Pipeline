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

module Mux (a,b,s,c);

    // Inputs
    input [31:0]a,b; // 32-bit input lines
    input s;         // Selector input

    // Output
    output [31:0]c;  // 32-bit output

    // 2-to-1 MUX logic
    assign c = (~s) ? a : b;

endmodule

module Mux_3_by_1 (a,b,c,s,d);

    // Inputs
    input [31:0] a,b,c;  // 32-bit input lines
    input [1:0] s;       // 2-bit selector input

    // Output
    output [31:0] d;     // 32-bit output

    // 3-to-1 MUX logic
    assign d = (s == 2'b00) ? a :
               (s == 2'b01) ? b :
               (s == 2'b10) ? c :
                              32'h00000000; // Default case

endmodule
