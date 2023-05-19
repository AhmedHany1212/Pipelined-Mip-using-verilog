`timescale 1ns / 1ps


module mux_2_1_tb;

	// Inputs
	reg [31:0] in1;
	reg [31:0] in2;
	reg sel;

	// Outputs
	wire [31:0] out1;

	// Instantiate the Unit Under Test (UUT)
	mux_2_1 uut (
		.in1(in1), 
		.in2(in2), 
		.sel(sel), 
		.out1(out1)
	);

	initial begin
		// Initialize Inputs
		#50;
		in1 = 100;
		in2 = 200;
		sel = 0;

#50;
		in1 = 100;
		in2 = 200;
		sel = 1;


	end
      
endmodule

