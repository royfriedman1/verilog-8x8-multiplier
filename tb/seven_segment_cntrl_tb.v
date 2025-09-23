`timescale 1 ns/1 ns

module seven_segment_cntrl_tb();

	// Wires to connect to DUT
	reg [2:0] inp;
	wire seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g;
	
	// Instantiate unit under test (seven_segment_cntrl)
	seven_segment_cntrl seven_segment_cntrl1 (.inp(inp), .seg_a(seg_a), .seg_b(seg_b),
		.seg_c(seg_c), .seg_d(seg_d), .seg_e(seg_e), .seg_f(seg_f), .seg_g(seg_g));
	
	// Assign values to "inp" to test seven_segment_cntrl block
	initial begin
		inp = 3'd0;  	// Initialize inp to 0
		forever
			#50 inp = inp + 1;  // Set input equal to values 0 - 7 for  50 ns each
	end

endmodule