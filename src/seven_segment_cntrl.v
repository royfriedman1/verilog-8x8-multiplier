`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: seven_segment_cntrl
// Description: 
//   7-segment display controller.
//   Maps a 3-bit binary input (FSM state) to a corresponding 7-segment pattern.
//   Supports display of 0, 1, 2, 3 and ERROR.
//
// Notes:
//   - Output order: {a, b, c, d, e, f, g}
//   - Used to show the current state of the multiplier FSM on a 7-segment display.
//////////////////////////////////////////////////////////////////////////////////

module seven_segment_cntrl(
        input [2:0] inp,                // 3-bit input (state encoding)
        output seg_a, seg_b, seg_c,     // 7-segment outputs
               seg_d, seg_e, seg_f, seg_g
    );
     
    // 7-segment codes (active-high, {a,b,c,d,e,f,g})
    parameter ZERO   = 7'b1111110; // digit "0"
    parameter ONE    = 7'b0110000; // digit "1"
    parameter TWO    = 7'b1101101; // digit "2"
    parameter THREE  = 7'b1111001; // digit "3"
    parameter ERROR  = 7'b1001111; // display "error"
 
    reg [6:0] seg; // internal register holding {a, b, c, d, e, f, g}
    
    // Combinational logic: select pattern based on input
    always @(*) begin
        case (inp)
            3'b000: seg = ZERO;
            3'b001: seg = ONE;
            3'b010: seg = TWO;
            3'b011: seg = THREE;
            default: seg = ERROR; // invalid state -> error pattern
        endcase
    end
    
    // Assign bits of seg to individual outputs
    assign seg_a = seg[6];
    assign seg_b = seg[5];
    assign seg_c = seg[4];
    assign seg_d = seg[3];
    assign seg_e = seg[2];
    assign seg_f = seg[1];
    assign seg_g = seg[0];

endmodule
