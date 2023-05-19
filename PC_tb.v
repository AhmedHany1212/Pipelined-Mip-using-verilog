`timescale 1ns / 1ps


module PC_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [15:0] PC_in;

	// Outputs
	wire [15:0] PC_out;

	// Instantiate the Unit Under Test (UUT)
	PC uut (
		.clk(clk), 
		.rst(rst), 
		.PC_in(PC_in), 
		.PC_out(PC_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		PC_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		PC_in=16'h1111;
		#100;
		rst=1;
	end
	always #50 clk=~clk;
      
endmodule


