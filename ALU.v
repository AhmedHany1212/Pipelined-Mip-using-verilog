module ALU (
output reg   [15:0]   ALU_out,
output wire           zero,
input  wire	 [15:0]   Bus_A_ALU, Bus_B_ALU,
input  wire  [3:0]    ALU_control

);

parameter ADD=4'b0000  , SUB=4'b0001 , AND=4'b0010 , OR=4'b0011 , NOR=4'b0100,
			 XOR=4'b0101 , SLL=4'b0110, SRL=4'b0111,  ADDI=4'b0000 , ANDI=4'b0010, 
             ORI=4'b0011,  pass_aluA=4'b1000;


always@(*)
begin
case(ALU_control)
	ADD:
		ALU_out=Bus_A_ALU+Bus_B_ALU;
	SUB:
		ALU_out=Bus_A_ALU-Bus_B_ALU;
	AND:
		ALU_out=Bus_A_ALU&Bus_B_ALU;
	OR:
		ALU_out=Bus_A_ALU|Bus_B_ALU;
	NOR:
		ALU_out=~(Bus_A_ALU|Bus_B_ALU);
	XOR:
		ALU_out=Bus_A_ALU^Bus_B_ALU;
	SLL:
		ALU_out=Bus_A_ALU<<1;// ={IN1[14:0],0};
	SRL:
		ALU_out=Bus_A_ALU>>1; //{0,IN1[15:1]};
	pass_aluA:
	     ALU_out=Bus_A_ALU;
	default:
		ALU_out=16'hxxxx;
endcase 
end
assign zero= (ALU_out==16'h0000)? 1'b1: 1'b0; //zero flag



endmodule