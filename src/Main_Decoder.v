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

module Main_Decoder(Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

    // Inputs
    input [6:0] Op;                    // Operation code (OpCode)

    // Outputs
    output RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
    output [1:0] ImmSrc, ALUOp;         // Immediate source and ALU operation

    // Control logic for register write
    assign RegWrite = (Op == 7'b0000011 | Op == 7'b0110011 | Op == 7'b0010011) ? 1'b1 : 1'b0;

    // Determines immediate source based on the opcode
    assign ImmSrc = (Op == 7'b0100011) ? 2'b01 : 
                    (Op == 7'b1100011) ? 2'b10 :    
                                         2'b00;

    // ALU source is immediate for load, store, and immediate operations
    assign ALUSrc = (Op == 7'b0000011 | Op == 7'b0100011 | Op == 7'b0010011) ? 1'b1 : 1'b0;

    // Memory write enable for store instructions
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 : 1'b0;

    // Result source selection (memory vs. ALU result)
    assign ResultSrc = (Op == 7'b0000011) ? 1'b1 : 1'b0;

    // Branch control signal for branch instructions
    assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0;

    // ALU operation control signal
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 :   // R-type
                   (Op == 7'b1100011) ? 2'b01 :   // Branch
                                        2'b00;    // Load, Store, Immediate

endmodule
