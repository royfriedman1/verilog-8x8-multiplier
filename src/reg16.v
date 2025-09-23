`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: reg16
// Description: 
//   16-bit register with synchronous clear and clock enable.
//   - On rising edge of clk:
//       * If clk_ena=1 → register can update.
//       * If sclr_n=0 → clear register to 0.
//       * Else → load new data from datain.
//
// Notes:
//   Used in the 8x8 multiplier as an accumulator for partial sums.
//////////////////////////////////////////////////////////////////////////////////

module reg16(
        input clk, sclr_n, clk_ena,      // clk = clock, sclr_n = sync clear (active low), clk_ena = enable
        input [15:0] datain,             // data input
        output reg [15:0] reg_out        // data output
    );
     
    // Synchronous process: triggered on rising edge of clk
    always @(posedge clk)
        begin
            if (clk_ena) begin                // only update when enabled
                if (!sclr_n)                  // synchronous clear
                    reg_out <= 16'h0000;      // reset register to 0
                else
                    reg_out <= datain;        // load new value
            end
        end
            
endmodule
