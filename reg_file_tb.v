`timescale 1ns / 1ps


module reg_file_tb;

	// Inputs
	reg clk;
	reg RegWrite;
	reg [2:0] WriteRegister;
	reg [2:0] ReadReg1;
	reg [2:0] ReadReg2;
	reg [15:0] WriteData;

	// Outputs
	wire [15:0] ReadData1;
	wire [15:0] ReadData2;


	// Instantiate the Unit Under Test (UUT)
	reg_file uut (
		.clk(clk), 
		.RegWrite(RegWrite), 
		.WriteRegister(WriteRegister), 
		.ReadReg1(ReadReg1), 
		.ReadReg2(ReadReg2), 
		.WriteData(WriteData), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		RegWrite = 0;
		WriteRegister = 0;
		ReadReg1 = 0;
		ReadReg2 = 0;
		WriteData = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here		
		RegWrite=1;
		WriteRegister=7;
		WriteData=8'h11;
		#100;
		ReadReg1=7;
	end
	always #50 clk=~clk;
      
endmodule
