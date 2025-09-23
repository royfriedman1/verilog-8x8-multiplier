`timescale 1 ns/1 ns

module counter_tb();

	// Wires to connect to DUT
	reg clk, aclr_n;
	wire [1:0] count_out;
	
	// Instantiate unit under test (counter)
	counter counter1 (.clk(clk), .aclr_n(aclr_n), .count_out(count_out));

	// Process to create clock signal
	initial begin
		clk = 0;
		forever clk = #20 ~clk;
	end
	
	// Assign input values to test register behavior
	initial begin
		aclr_n = 1'b0;
		#40 aclr_n = 1'b1;
	end

endmodule