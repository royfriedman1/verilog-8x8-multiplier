`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: mux4
// Description: 
//   2-to-1 multiplexer, 4-bit wide.
//   - Selects between mux_in_a and mux_in_b according to mux_sel.
//   - If mux_sel=0 → output = mux_in_a.
//   - If mux_sel=1 → output = mux_in_b.
//
// Notes:
//   Used in the 8x8 multiplier top-level design to select
//   either the lower or upper 4 bits of the operands.
//////////////////////////////////////////////////////////////////////////////////

module mux4(
        input [3:0] mux_in_a, mux_in_b,  // 4-bit input options
        input mux_sel,                   // select line (0 = a, 1 = b)
        output reg [3:0] mux_out         // 4-bit output
    );
     
    // Combinational logic: output depends only on inputs
    always @(mux_in_a, mux_in_b, mux_sel)
        begin
            case (mux_sel)
                1'b0 : mux_out = mux_in_a;       // select input a
                1'b1 : mux_out = mux_in_b;       // select input b
                default : mux_out = 3'b000;      // default (should not happen)
            endcase
        end

endmodule
