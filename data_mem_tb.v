`timescale 1ns / 1ps


module data_mem_tb;

	// Inputs
	reg clk;
	reg MemWrite;
	reg MemRead;
	reg [7:0] address;
	reg [15:0] WriteData_dmem;

	// Outputs
	wire [15:0] ReadData_dmem;

	// Instantiate the Unit Under Test (UUT)
	data_mem uut (
		.clk(clk), 
		.MemWrite(MemWrite),
		.MemRead(MemRead), 		
		.address(address), 
		.WriteData_dmem(WriteData_dmem), 
		.ReadData_dmem(ReadData_dmem)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		MemWrite = 0;
		MemRead = 0;
		address = 0;
		WriteData_dmem = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here		
		MemWrite=1;
		address=7;
		WriteData_dmem=8'h11;
		#100;
		MemRead=1;
		MemWrite=0;
		address=7;
	end
	always #50 clk=~clk;
      
endmodule
