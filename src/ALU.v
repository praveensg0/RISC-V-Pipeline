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


// ALU module to perform arithmetic and logical operations
module ALU(A, B, Result, ALUControl, OverFlow, Carry, Zero, Negative);

    // Inputs
    input [31:0] A, B;           // 32-bit input operands A and B
    input [2:0] ALUControl;      // 3-bit ALU control signal to select the operation

    // Outputs
    output Carry, OverFlow, Zero, Negative;  // Status flags
    output [31:0] Result;                    // 32-bit output result

    // Internal wires
    wire Cout;               // Carry out wire for arithmetic operations
    wire [31:0] Sum;         // Intermediate sum result for addition/subtraction

    // Compute the sum or difference based on ALUControl[0]
    // If ALUControl[0] is 0, it performs addition (A + B)
    // If ALUControl[0] is 1, it performs subtraction (A - B) using two's complement
    assign Sum = (ALUControl[0] == 1'b0) ? A + B :   // Add A + B
                                          (A + ((~B) + 1));  // Subtract A - B using two's complement

    // Select the final result based on ALUControl
    // ALUControl == 3'b000 or 3'b001 -> Addition or Subtraction (Sum)
    // ALUControl == 3'b010 -> AND operation
    // ALUControl == 3'b011 -> OR operation
    // ALUControl == 3'b101 -> Set on Less Than (SLT)
    assign {Cout, Result} = (ALUControl == 3'b000) ? Sum :      // Addition
                            (ALUControl == 3'b001) ? Sum :      // Subtraction
                            (ALUControl == 3'b010) ? A & B :    // AND
                            (ALUControl == 3'b011) ? A | B :    // OR
                            (ALUControl == 3'b101) ? {{32{1'b0}}, (Sum[31])} : // SLT (set on less than)
                            {33{1'b0}};  // Default to zero if no match

    // Overflow flag is set when there is a signed overflow in addition/subtraction
    // Check if the sign of Sum differs from A, and ALUControl indicates addition/subtraction
    assign OverFlow = ((Sum[31] ^ A[31]) & 
                      (~(ALUControl[0] ^ B[31] ^ A[31])) & 
                      (~ALUControl[1]));

    // Carry flag is set during addition/subtraction when there is an unsigned carry out
    assign Carry = ((~ALUControl[1]) & Cout);

    // Zero flag is set if the result is zero
    assign Zero = &(~Result);

    // Negative flag is set if the most significant bit (MSB) of the result is 1 (indicating a negative number)
    assign Negative = Result[31];

endmodule
