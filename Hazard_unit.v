module Hazard_unit (
output reg   		  PC_EN,IF2ID_EN,ID2EX_EN,  
input  wire	 [2:0]    EX_rd,ID_rs,ID_rt,EX_rt,
input  wire   		  Branch,EX_MemRead,EX_Regwrite,Branch_NE
);
//branch
always@(*)
begin
//stall
//branch  //R_type || load instruction
if((Branch&&EX_Regwrite&&((EX_rd==ID_rs)||(EX_rd==ID_rt)))||(Branch&&EX_MemRead&&((EX_rt==ID_rs)||(EX_rt==ID_rt))) || (EX_MemRead&&((EX_rt==ID_rs)||(EX_rt==ID_rt))))
begin// stall the pipeline
ID2EX_EN=1'b1;; // force ID/EX register to 0
IF2ID_EN=0; //stop IF stage
PC_EN=0; //prevent update of PC
end
//BNQ
if((Branch_NE&&EX_Regwrite&&((EX_rd==ID_rs)||(EX_rd==ID_rt)))||(Branch_NE&&EX_MemRead&&((EX_rt==ID_rs)||(EX_rt==ID_rt)))|| (EX_MemRead&&((EX_rt==ID_rs)||(EX_rt==ID_rt))))
begin// stall the pipeline
ID2EX_EN=1'b1;; // force ID/EX register to 0
IF2ID_EN=0; //stop IF stage
PC_EN=0; //prevent update of PC
end
else 
ID2EX_EN=0;IF2ID_EN=1; PC_EN=1;
end
endmodule