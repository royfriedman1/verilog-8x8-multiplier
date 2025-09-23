`timescale 1 ns/1 ns

module adder_tb();

	// Wires and variables to connect to DUT
	reg [15:0] dataa, datab;
	wire [15:0] sum;
	
	// Instantiate unit under test (adder)
	adder adder1 (.dataa(dataa), .datab(datab), .sum(sum));

	// Assign values to "dataa" and "datab" to test adder block
	initial begin
		dataa = 16'd8;
		datab = 16'd5;
		#20 dataa = 16'd0;
		datab = 16'd1;
		#10 dataa = 16'd10;
		datab = 16'd5;
	end

endmodule
