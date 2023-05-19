module ALU_Controller(ALU_control,func,ALU_OP);
input [2:0] func;
input [2:0] ALU_OP;
output reg [3:0] ALU_control;

parameter ADD=4'b0000  , SUB=4'b0001 , AND=4'b0010 , OR=4'b0011 , NOR=4'b0100,
			 XOR=4'b0101 , SLL=4'b0110, SRL=4'b0111,  ADDI=4'b0000 , ANDI=4'b0010, 
             ORI=4'b0011,  pass_aluA=4'b1000;
always @ (*)
	begin
		case (ALU_OP)
			3'b000: ALU_control<=ADDI;
		   3'b001: ALU_control<=pass_aluA;
			3'b010: ALU_control<=SUB;
			3'b101: ALU_control<=ANDI;			
			3'b110: ALU_control<=ORI;	
			3'b111: 	begin
							case (func)
								3'b000: 	ALU_control<=ADD;
								3'b001: 	ALU_control<=SUB;
								3'b010: 	ALU_control<=AND;
								3'b011: 	ALU_control<=OR;
								3'b100: 	ALU_control<=NOR;
								3'b101:	ALU_control<=XOR;
								3'b110:	ALU_control<=SLL;
								3'b111:	ALU_control<=SRL;
								default:	ALU_control<=3'bzzz;
							endcase		
						end				
			default:	ALU_control<=3'bzzz;	
		endcase			
	end

endmodule
