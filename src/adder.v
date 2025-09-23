`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: adder
// Design: 16-bit Adder
// Description: 
//   Simple combinational 16-bit adder. 
//   Takes two 16-bit inputs (dataa, datab) and produces their sum.
// 
// Notes:
//   - Used as a building block in the 8x8 sequential multiplier.
//   - Synthesizable in any standard Verilog toolchain.
//////////////////////////////////////////////////////////////////////////////////

module adder (
    input  [15:0] dataa,   // First operand
    input  [15:0] datab,   // Second operand
    output [15:0] sum      // Sum = dataa + datab
);

    // Continuous assignment: sum is updated whenever dataa or datab change
    assign sum = dataa + datab;

endmodule
