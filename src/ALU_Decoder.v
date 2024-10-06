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

module ALU_Decoder(ALUOp, funct3, funct7, op, ALUControl);

    // Inputs
    input [1:0] ALUOp;           // ALU operation control bits
    input [2:0] funct3;          // 3-bit function code
    input [6:0] funct7, op;      // 7-bit function code and opcode
    
    // Output
    output [2:0] ALUControl;     // 3-bit ALU control signal

    // ALU control logic
    // Selects the ALU operation based on ALUOp, funct3, funct7, and op
    assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :                     // Load/Store (ADD)
                        (ALUOp == 2'b01) ? 3'b001 :                     // Branch (SUB)
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & 
                        ({op[5], funct7[5]} == 2'b11)) ? 3'b001 :       // SUB
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & 
                        ({op[5], funct7[5]} != 2'b11)) ? 3'b000 :       // ADD
                        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 : // SLT
                        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 : // OR
                        ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : // AND
                                                                 3'b000 ;   // Default

endmodule
