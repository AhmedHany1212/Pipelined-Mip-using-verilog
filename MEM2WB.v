module MEM2WB #(parameter n=16)(
		output reg [1:0]    WB_MemtoReg,
		output reg [n-1:0]  WB_inst,WB_PC_adder_out,WB_ReadData_dmem,WB_ALU_out,
		output reg          WB_IN,WB_OUT,WB_RegWrite, 
		output reg [2:0]    WB_WriteRegister ,
		input      [1:0]    MemtoReg,
		input      [n-1:0]  inst,PC_adder_out,ReadData_dmem,ALU_out,
		input               IN,OUT,RegWrite, 
		input      [2:0]    WriteRegister ,
		input               clk,rst
 );


  always @ (posedge clk) begin
    if (rst) begin
      {WB_MemtoReg ,WB_inst, WB_PC_adder_out , WB_ReadData_dmem , WB_ALU_out , WB_IN , WB_OUT , WB_RegWrite,WB_WriteRegister} <= 0;
    end
    else begin
      WB_MemtoReg <= MemtoReg;
      WB_inst <= inst;
      WB_PC_adder_out <= PC_adder_out;
      WB_ReadData_dmem <= ReadData_dmem;
      WB_ALU_out <= ALU_out;
      WB_IN <= IN;
      WB_OUT <= OUT;
      WB_RegWrite <= RegWrite;
      WB_WriteRegister <= WriteRegister;

    end
  end

endmodule  // MEM2WB