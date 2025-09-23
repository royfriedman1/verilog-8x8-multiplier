`timescale 1 ns/1 ns

module shifter_tb();

	// Wires to connect to DUT
	reg [7:0] inp;
	reg [1:0] shift_cntrl;
	wire [15:0] shift_out;
	
	// Instantiate unit under test (shifter)
	shifter shifter1 (.inp(inp), .shift_cntrl(shift_cntrl), .shift_out(shift_out));

	// Assign values to "inp" and "shift_cntrl" to test shifter block
	initial begin
		shift_cntrl = 4'd0;  	// Initialize shift_cntrl to 0
		inp = 8'hF4;			// Fix inp to f4 hex
		forever
			#50 shift_cntrl = shift_cntrl + 1;  // Create counter on shift control input to cycle through values every 50 ns
	end

endmodule