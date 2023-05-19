`timescale 1ns / 1ps


module inst_mem_tb;

	// Inputs
	reg [15:0] read_address;

	// Outputs
	wire [15:0] inst;

	// Instantiate the Unit Under Test (UUT)
	inst_mem uut (
		.read_address(read_address), 
		.inst(inst)
	);

	initial begin
		// Initialize Inputs
		read_address = 0;

		// Wait 100 ns for global reset to finish
		#100;
		read_address=7;
        
		// Add stimulus here

	end
      
endmodule

