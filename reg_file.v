module reg_file(
    output  [15:0] ReadData1,
    output  [15:0] ReadData2,
    input RegWrite,
    input [2:0] WriteRegister,
    input [2:0] ReadReg1,
    input [2:0] ReadReg2,
    input [15:0] WriteData
    );
    

    reg [15 : 0] mem [7:0];
    integer i;

    initial begin
        for(i =0; i <=7 ; i = i + 1) begin
            mem[i]=8'h00;
        end
    end
    
    always @( *  )
    begin 
	if (RegWrite)
	begin
	   mem[WriteRegister]<=WriteData;
	end
    end
  	 assign ReadData1 = mem[ReadReg1];
	 assign ReadData2 = mem[ReadReg2];

       
     
endmodule