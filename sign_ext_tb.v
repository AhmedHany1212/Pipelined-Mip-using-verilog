`timescale 1ns / 1ps


module sign_ext_tb;

	// Inputs
	reg [5:0] in6;
	reg sign_extension_mode;

	// Outputs
	wire [15:0] out16;

	// Instantiate the Unit Under Test (UUT)
	sign_ext uut (
		.out16(out16), 
		.in6(in6), 
		.sign_extension_mode(sign_extension_mode)
	);

	initial begin
		// Initialize Inputs
		in6 = 0;
		sign_extension_mode = 0;

		// Wait 100 ns for global reset to finish
		#100;
        		in6 = 6'b111111;
		sign_extension_mode = 0;

		#100;
        		in6 = 6'b111111;
		sign_extension_mode = 1;

	end
      
endmodule

