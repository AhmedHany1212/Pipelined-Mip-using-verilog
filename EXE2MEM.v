module EXE2MEM #(parameter n=16)(
		output reg [n-1:0] MEM_PC_adder_out,MEM_inst,MEM_ALU_out , MEM_ReadData2 , MEM_ReadData1 ,
		output reg         MEM_MemRead , MEM_MemWrite , MEM_IN , MEM_OUT , MEM_RegWrite  ,
		output reg [1:0]   MEM_MemtoReg ,
		output reg [2:0]   MEM_WriteRegister ,
		input      [n-1:0] PC_adder_out,inst,ALU_out,ReadData2, ReadData1 ,
		input              MemRead,MemWrite , IN,OUT,RegWrite, Branch , Branch_NE, Jump ,Jump_R ,
		input      [1:0]   MemtoReg,
		input      [2:0]   WriteRegister ,
		input              clk,rst
 );


  always @ (posedge clk) begin
    if (rst) begin
      {MEM_PC_adder_out,MEM_inst,MEM_ALU_out , MEM_ReadData2 ,MEM_ReadData1, MEM_MemRead , MEM_MemWrite , MEM_IN,MEM_OUT , MEM_RegWrite   , MEM_MemtoReg ,MEM_WriteRegister} <= 0;
    end
    else begin
	  MEM_PC_adder_out <= PC_adder_out;
      MEM_inst <= inst;
      MEM_ALU_out <= ALU_out;
      MEM_ReadData1 <= ReadData1;
      MEM_ReadData2 <= ReadData2;
      MEM_MemRead <= MemRead;
      MEM_MemWrite <= MemWrite;
      MEM_IN <= IN;
      MEM_OUT <= OUT;
      MEM_RegWrite <= RegWrite;
      MEM_MemtoReg <= MemtoReg;
      MEM_WriteRegister <= WriteRegister;

    end
  end

endmodule  // EXE2MEM