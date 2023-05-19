module Forwarding_unit (
output reg   [1:0]   ForwardA,ForwardB,
input  wire	 [2:0]   EX_rs, EX_rt,MEM_rd,WB_rd,
input  wire   		 MEM_RegWrite,WB_RegWrite 

);

always@(*)
begin  
 
// EX Hazard
if((MEM_rd==EX_rs)&&(MEM_rd!=0)&&(MEM_RegWrite))
	ForwardA=2'b10;
// MEM Hazard
else if((WB_rd==EX_rs)&&(WB_rd!=0)&&(WB_RegWrite)
&&!((MEM_rd==EX_rs)&&(MEM_rd!=0)&&(MEM_RegWrite)))// for double Data Hazard
	ForwardA=2'b01;
	else ForwardA=2'b00; ;
// EX Hazard
if((MEM_rd==EX_rt)&&(MEM_rd!=0)&&(MEM_RegWrite))
	ForwardB=2'b10;
//MEM Hazard
else if((WB_rd==EX_rt)&&(WB_rd!=0)&&(WB_RegWrite)&&!((MEM_rd==EX_rt)&&(MEM_rd!=0)&&(MEM_RegWrite)))
	ForwardB=2'b01;
	else  ForwardB=2'b00;;
end
endmodule