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

module Control_Unit_Top(Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, funct3, funct7, ALUControl); 

    // Inputs
    input [6:0] Op, funct7;          // Opcode and funct7 field
    input [2:0] funct3;              // funct3 field
    
    // Outputs
    output RegWrite, ALUSrc, MemWrite, ResultSrc, Branch; // Control signals for various stages
    output [1:0] ImmSrc;             // Immediate generation control
    output [2:0] ALUControl;         // ALU control signal

    wire [1:0] ALUOp;                // ALU operation control (intermediate signal)

    // Main decoder to generate high-level control signals based on the opcode
    Main_Decoder Main_Decoder(
        .Op(Op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp)
    );

    // ALU decoder to generate ALU control signals based on funct3, funct7, and ALUOp
    ALU_Decoder ALU_Decoder(
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .op(Op),
        .ALUControl(ALUControl)
    );

endmodule
