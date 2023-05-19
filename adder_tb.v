`timescale 1ns / 1ps



module adder_tb;

	// Inputs
	reg [15:0] in1;
	reg [15:0] in2;

	// Outputs
	wire [15:0] out_put;

	// Instantiate the Unit Under Test (UUT)
	adder PC_Adder(
.out_put(PC_adder_out) ,.in1(PC_out) ,.in2({15'b000000000000000,1'b1}) );

	initial begin
		in1=10;
		
	
        
		// Add stimulus here

	end
      
endmodule

