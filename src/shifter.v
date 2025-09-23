`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: shifter
// Description: 
//   Shifts an 8-bit input into a 16-bit output according to control signal.
//   - shift_cntrl = 00 or 11 → no shift
//   - shift_cntrl = 01       → shift left by 4 bits
//   - shift_cntrl = 10       → shift left by 8 bits
//
// Notes:
//   - Used in the 8x8 multiplier datapath to align partial products
//     before they are added into the accumulator.
//////////////////////////////////////////////////////////////////////////////////

module shifter(
        input [7:0] inp,                 // 8-bit input (partial product)
        input [1:0] shift_cntrl,         // control: determines shift amount
        output reg [15:0] shift_out      // shifted 16-bit result
    );
        
    always @(inp, shift_cntrl) begin
        shift_out = 16'h0000;            // initialize output

        case (shift_cntrl)
            2'b00, 2'b11 : shift_out = inp + shift_out;       // no shift
            2'b01        : shift_out = (inp << 4) + shift_out;// shift left by 4
            2'b10        : shift_out = (inp << 8) + shift_out;// shift left by 8
            default      : shift_out = 16'h0000;              // default case
        endcase
    end
    
endmodule
