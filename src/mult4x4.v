`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: mult4x4
// Description: 
//   Combinational 4x4 multiplier.
//   Multiplies two 4-bit unsigned inputs and produces an 8-bit product.
//
// Notes:
//   - Pure combinational logic (no clock).
//   - Used as a building block in the hierarchical design
//     of the 8x8 sequential multiplier.
//////////////////////////////////////////////////////////////////////////////////

module mult4x4(
        input [3:0] dataa, datab,   // 4-bit inputs to be multiplied
        output [7:0] product        // 8-bit product output
    );
    
    // Continuous assignment: product = dataa * datab
    assign product = dataa * datab;  

endmodule
