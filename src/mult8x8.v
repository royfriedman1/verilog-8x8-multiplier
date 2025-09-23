`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: mult8x8
// Description: 
//   Top-level 8x8 sequential multiplier.
//   - Connects all submodules: mux4, mult4x4, shifter, counter, control FSM,
//     reg16, adder, and seven-segment controller.
//   - Produces a 16-bit product displayed on 7-segment outputs.
//   - Controlled by FSM (mult_control) with start/reset/clock signals.
//
// Notes:
//   - Demonstrates hierarchical design and module re-use.
//   - Core project module integrating datapath and control.
//////////////////////////////////////////////////////////////////////////////////

module mult8x8 (
    input start, reset_a, clk,               // Control inputs
    input [7:0] dataa, datab,                // 8-bit multiplicands
    output seg_a, seg_b, seg_c, seg_d,       // Seven-segment display outputs
    output seg_e, seg_f, seg_g, done_flag,   // More 7-seg outputs + done flag
    output [15:0] product8x8_out             // Final multiplier result
);

    // Internal wires connecting submodules
    wire [3:0] aout, bout;
    wire [7:0] product;
    wire [15:0] shift_out, sum;
    wire [1:0] count, shift;
    wire [2:0] state_out;
    wire clk_ena, sclr_n;
    wire [1:0] sel;

    // MUX for selecting lower/upper 4 bits of operand A
    mux4 u1 (
        .mux_in_a(dataa[3:0]), 
        .mux_in_b(dataa[7:4]), 
        .mux_sel(sel[1]), 
        .mux_out(aout)
    );

    // MUX for selecting lower/upper 4 bits of operand B
    mux4 u2 (
        .mux_in_a(datab[3:0]), 
        .mux_in_b(datab[7:4]), 
        .mux_sel(sel[0]), 
        .mux_out(bout)
    );
    
    // 4x4 multiplier for selected parts of operands
    mult4x4 u3 (
        .dataa(aout), 
        .datab(bout), 
        .product(product)
    );
    
    // Shifter: aligns partial product based on control
    shifter u4 (
        .inp(product[7:0]), 
        .shift_cntrl(shift[1:0]), 
        .shift_out(shift_out[15:0])
    );
    
    // Counter: keeps track of multiplier steps
    counter u5 (
        .clk(clk), 
        .aclr_n(!start), 
        .count_out(count[1:0])
    );
    
    // Control FSM: generates sequencing control signals
    mult_control u6 (
        .clk(clk), 
        .reset_a(reset_a), 
        .start(start), 
        .count(count[1:0]), 
        .input_sel(sel[1:0]), 
        .shift_sel(shift[1:0]), 
        .state_out(state_out[2:0]), 
        .done(done_flag), 
        .clk_ena(clk_ena), 
        .sclr_n(sclr_n)
    );
    
    // 16-bit register: accumulates results
    reg16 u7 (
        .clk(clk), 
        .sclr_n(sclr_n), 
        .clk_ena(clk_ena), 
        .datain(sum[15:0]), 
        .reg_out(product8x8_out[15:0])
    );
    
    // 16-bit adder: adds shifted partial product to accumulator
    adder u8 (
        .dataa(shift_out[15:0]), 
        .datab(product8x8_out[15:0]), 
        .sum(sum[15:0])
    );
    
    // Seven-segment controller: displays current FSM state
    seven_segment_cntrl u9 (
        .inp(state_out), 
        .seg_a(seg_a), 
        .seg_b(seg_b), 
        .seg_c(seg_c), 
        .seg_d(seg_d), 
        .seg_e(seg_e), 
        .seg_f(seg_f), 
        .seg_g(seg_g)
    );  
    
endmodule
