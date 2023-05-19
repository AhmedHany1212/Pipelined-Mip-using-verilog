`timescale 1ns / 1ps

module ALU_Controller_tb;
	// Inputs
	reg [2:0] func;
	reg [2:0] ALU_OP;
	// Outputs
	wire [3:0] ALU_control;
	integer k;
	// Instantiate the Unit Under Test (UUT)
	ALU_Controller ALUCONT (
		.func(func), 
		.ALU_OP(ALU_OP), 
		.ALU_control(ALU_control)
	);

	initial begin
	$monitor ("time: %d , ALU_OP=%b , func=%d , ALU_control=%b",$time,	ALU_OP,func,ALU_control);

	#10 ALU_OP=3'b00;
	#10 ALU_OP=3'b01;
	#10 ALU_OP=3'b10;
	#10  ALU_OP=3'b11;
	for (k=0;k<8;k=k+1)
		begin func=k; #10; end
	#10 ALU_OP=3'bZZ;
	#10 ALU_OP=3'b00; func=3'bZZZ;
	#10 $finish;
	end
      
endmodule

