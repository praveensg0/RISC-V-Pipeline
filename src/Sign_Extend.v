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

module Sign_Extend (In, ImmSrc, Imm_Ext);
    // Inputs
    input [31:0] In;                // Input value to be extended
    input [1:0] ImmSrc;             // Immediate source selector
    
    // Output
    output [31:0] Imm_Ext;          // Extended immediate value

    // Sign extension logic based on ImmSrc
    assign Imm_Ext =  (ImmSrc == 2'b00) ? {{20{In[31]}}, In[31:20]} : // Type 1 extension
                     (ImmSrc == 2'b01) ? {{20{In[31]}}, In[31:25], In[11:7]} : // Type 2 extension
                     32'h00000000; // Default case

endmodule
