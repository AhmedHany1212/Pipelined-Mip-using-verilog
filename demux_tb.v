`timescale 1ns / 1ps



module demux_tb;

	// Inputs
	reg sel;
	reg [15:0] in_put;

	// Outputs
	wire [15:0] out0;
	wire [15:0] out1;

	// Instantiate the Unit Under Test (UUT)
	demux uut (
		.sel(sel), 
		.in_put(in_put), 
		.out0(out0), 
		.out1(out1)
	);

	initial begin
		// Initialize Inputs
		sel = 0;
		in_put = 100;
		#50;
      sel = 0;
		in_put = 200;
		#50;
		sel = 0;
		in_put = 300;
		#50;
		sel = 0;
		in_put = 400;
		#50;
		sel = 0;
		in_put = 500;
		#50;
		
        
		// Add stimulus here

	end
      
endmodule

