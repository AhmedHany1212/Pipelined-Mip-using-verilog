module Forwarding_unit_beq (
output reg   	     ForwardC,ForwardD,
input  wire	 [2:0]   ID_rs, ID_rt,MEM_rd,
input  wire   		 Branch 

);

always@(*)
begin  
	
if(Branch&&(MEM_rd!=0)&&(MEM_rd==ID_rs))
ForwardC=1'b1;
else ForwardC=1'b0;
if(Branch&&(MEM_rd!=0)&&(MEM_rd==ID_rt))
ForwardD=1'b1;
else ForwardD=1'b0;

end
endmodule