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

module PC_Adder (a, b, c);
    // Inputs
    input [31:0] a, b; // Two 32-bit inputs to be added
    
    // Output
    output [31:0] c;   // 32-bit output result of the addition

    // Adder logic
    assign c = a + b;  // Sum of inputs a and b
    
endmodule
