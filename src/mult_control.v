`timescale 1 ns/1 ns
//////////////////////////////////////////////////////////////////////////////////
// Module Name: mult_control
// Description: 
//   Finite State Machine (FSM) controller for the 8x8 sequential multiplier.
//   Controls the sequencing of input selection, shifting, clock enable, and clear.
//   States: idle, lsb, mid, msb, calc_done, err.
//
// Notes:
//   - This is the "brain" of the multiplier, deciding which sub-modules are active.
//   - Mix of Mealy (outputs depend on state & inputs) and Moore (state_out).
//////////////////////////////////////////////////////////////////////////////////

// Begin module declaration for "mult_control"
module mult_control (
    input clk, reset_a, start,           // clk = clock, reset_a = async reset, start = control input
    input [1:0] count,                   // counter value from submodule
    output reg [1:0] input_sel, shift_sel, // controls multiplexer and shifter
    output reg [2:0] state_out,          // current FSM state (Moore output)
    output reg done, clk_ena, sclr_n     // done flag, clock enable, synchronous clear (active low)
);

    // State registers
    reg [2:0] current_state, next_state;
    
    // FSM state encoding
    parameter idle=0, lsb=1, mid=2, msb=3, calc_done=4, err=5;

    // Sequential process: update state on rising edge of clk or async reset
    always @(posedge clk, posedge reset_a) begin
        if (reset_a)
            current_state <= idle;    // async reset -> go to idle
        else
            current_state <= next_state;
    end
        
    // Combinational process: next-state logic (based on current state & inputs)
    always @* 
        case (current_state)
            idle : 
                if (start)
                    next_state = lsb;
                else
                    next_state = idle;
            lsb : 
                if (count == 0 && start == 0)
                    next_state = mid;
                else
                    next_state = err;
            mid : 
                if (start == 0 && count == 2)
                    next_state = msb;
                else if (start == 0 && count == 1)
                    next_state = mid;
                else
                    next_state = err;
            msb : 
                if (count == 3 && start == 0)
                    next_state = calc_done;
                else
                    next_state = err;
            calc_done :
                if (!start)
                    next_state = idle;
                else
                    next_state = err;
            err : 
                if (start)
                    next_state = lsb;
                else
                    next_state = err;
        endcase

    // Mealy output logic: depends on state AND inputs
    always @* begin
        // Default values
        input_sel = 2'bxx;
        shift_sel = 2'bxx;
        done = 1'b0;
        clk_ena = 1'b0;
        sclr_n = 1'b1;        

        case (current_state)
            idle : 
                if (start) begin
                    clk_ena = 1'b1;
                    sclr_n = 1'b0;
                end
            lsb : 
                if (count == 0 && start == 0) begin
                    input_sel = 2'd0;
                    shift_sel = 2'd0;
                    clk_ena = 1'b1;
                end
            mid : 
                if (count == 2 && start == 0) begin
                    input_sel = 2'd2;
                    shift_sel = 2'd1;
                    clk_ena = 1'b1;
                end
                else if (count == 1 && start == 0) begin
                    input_sel = 1'd1;
                    shift_sel = 1'd1;
                    clk_ena = 1'b1;
                end
            msb : 
                if (count == 3 && start == 0) begin
                    input_sel = 2'd3;
                    shift_sel = 2'd2;
                    clk_ena = 1'b1;
                end
            calc_done :
                if (!start)
                    done = 1'b1;      // signal completion
            err : 
                if (start) begin
                    clk_ena = 1'b1;
                    sclr_n = 1'b0;   // clear on error recovery
                end
        endcase
    end

    // Moore output logic: state_out depends only on current state
    always @(current_state) begin
        state_out = 3'd0; // default
        case (current_state)
            idle       : ;
            lsb        : state_out = 3'd1;
            mid        : state_out = 3'd2;
            msb        : state_out = 3'd3;
            calc_done  : state_out = 3'd4;
            err        : state_out = 3'd5;
        endcase
    end

endmodule // End module
