module data_mem(
    output reg [15:0] ReadData_dmem,
    input MemWrite,
    input MemRead,
    input [7:0] address,
    input [15:0] WriteData_dmem
    );

    reg [15 : 0] mem [255:0];
    integer i;
    initial begin
        for(i =0; i <=255 ; i = i + 1) begin
            mem[i]=i;
        end
    end

    always @( *  )
    begin 
	if (MemWrite & !MemRead )
	begin
	   mem[address]<=WriteData_dmem;
	end
	else if(!MemWrite& MemRead)
	begin
	   ReadData_dmem <= mem[address];
	end
	else
	begin
		ReadData_dmem<=0;
	end
    end

endmodule