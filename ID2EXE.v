module ID2EXE #(parameter n=16)(
		output reg  [n-1:0] EX_PC_adder_out,EX_inst, 
		output reg [2:0]	 EX_ALU_OP,
		output reg [n-1:0] EX_ReadData1,
		output reg [n-1:0] EX_ReadData2,
		output reg [n-1:0] EX_sign_ex,
		output reg        EX_ALUSrc , EX_MemRead ,EX_MemWrite,EX_IN,EX_OUT,EX_RegWrite,
		output reg [1:0]   EX_MemtoReg,EX_REGDst,
		input   	  [n-1:0] PC_adder_out,inst,
		input   	  [2:0]	 ALU_OP,
		input   	  [n-1:0] ReadData1,
		input   	  [n-1:0] ReadData2,
		input   	  [n-1:0] sign_ex,
		input     	          ALUSrc , MemRead , MemWrite , IN , OUT , RegWrite ,
		input  	  [1:0]   MemtoReg,REGDst,
		input              clk,rst
 );

  always @ (posedge clk) begin
    if (rst) begin
      {EX_PC_adder_out,EX_inst, EX_ALU_OP , EX_ReadData1 , EX_ReadData2 , EX_sign_ex  , EX_ALUSrc , EX_MemRead , EX_MemWrite , EX_IN , EX_OUT , EX_RegWrite  , EX_MemtoReg , EX_REGDst} <= 0;
    end
    else begin
      EX_PC_adder_out <= PC_adder_out;
      EX_inst <= inst;
      EX_ALU_OP <= ALU_OP;
      EX_ReadData1 <= ReadData1;
      EX_ReadData2 <= ReadData2;
      EX_sign_ex <= sign_ex;
      EX_ALUSrc <= ALUSrc;
      EX_MemRead <= MemRead;
      EX_MemWrite <= MemWrite;
      EX_IN <= IN;
      EX_OUT <= OUT;
      EX_RegWrite <= RegWrite;
      EX_MemtoReg <= MemtoReg;
      EX_REGDst <= REGDst;
    end
  end

endmodule  // ID2EXE
