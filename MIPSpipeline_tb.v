`timescale 1ns / 1ps


module MIPSpipeline_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [15:0] in_port;

	// Outputs
	wire [15:0] out_port;

	// Instantiate the Unit Under Test (UUT)
	MIPSpipeline uut (
		.clk(clk), 
		.rst(rst), 
		.in_port(in_port), 
		.out_port(out_port)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		in_port = 3;
		#1100 rst=0;
		// Wait 100 ns for global reset to finish

		// Add stimulus here

	end
      
			always #50 clk=~clk;
			
		//always #1000 rst=~rst;


endmodule

