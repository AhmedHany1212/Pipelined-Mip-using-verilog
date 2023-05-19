`timescale 1ns / 1ps



module mux3_1_tb;

	// Inputs
	reg [4:0] in1;
	reg [4:0] in2;
	reg [4:0] in3;
	reg [1:0] sel;

	// Outputs
	wire [4:0] out1;

	// Instantiate the Unit Under Test (UUT)
	mux_3_1 uut (
		.in1(in1), 
		.in2(in2), 
		.in3(in3), 
		.sel(sel), 
		.out1(out1)
	);

	initial begin
		// Initialize Inputs
		in1=0;
		in2=1;
		in3=2;
		#50;
		sel = 0;
		#50;
		sel = 1;
		#50;
		sel = 2;
		#50;
	$stop;

	
        
		// Add stimulus here

	end
      
endmodule

