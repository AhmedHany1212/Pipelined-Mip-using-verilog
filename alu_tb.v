module Alu_tb;

	// Inputs
	reg [15:0] Bus_A_ALU;
	reg [15:0] Bus_B_ALU;
	reg [3:0] ALU_control;

	// Outputs
	wire [15:0] ALU_out;
	wire zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.Bus_A_ALU(Bus_A_ALU), 
		.Bus_B_ALU(Bus_B_ALU), 
		.ALU_control(ALU_control), 
		.ALU_out(ALU_out), 
		.zero(zero)
	);
integer i;
	initial begin
		// Initialize Inputs
		Bus_A_ALU = 0;
		Bus_B_ALU = 0;
		ALU_control = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		Bus_A_ALU=16'hC000;
		IN2=16'hFFFF;
		for(i=0;i<=8;i=i+1)
			begin
				ALU_control=i; #5;
				$display("func=%d  Aluout_tb=%b zero=%b",ALU_control,ALU_out,zero);
			end

	end
      
endmodule