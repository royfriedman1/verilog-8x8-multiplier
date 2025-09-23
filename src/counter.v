`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: counter
// Description: 
//   2-bit up-counter with asynchronous clear (active-low).
//   - Resets to 0 when aclr_n = 0 (asynchronous).
//   - Increments by 1 on each rising clock edge.
// Notes:
//   Used inside the 8x8 multiplier project for control sequencing.
//////////////////////////////////////////////////////////////////////////////////

module counter(
        input clk, aclr_n,          // clk = clock input, aclr_n = asynchronous clear (active low)
        output reg [1:0] count_out  // 2-bit counter output
    );
    
    // always block sensitive to rising edge of clk and falling edge of aclr_n
    always @(posedge clk , negedge aclr_n)
        begin
            if (!aclr_n)             // if aclr_n = 0, reset counter asynchronously
                count_out <= 2'b00;  // reset counter to 0
            else begin
                count_out <= count_out + 1'b1; // otherwise increment counter by 1
            end
        end

endmodule
