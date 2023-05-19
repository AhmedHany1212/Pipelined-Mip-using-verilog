module Main_Controller(REGDst,Branch,MemRead,MemtoReg,ALU_OP,MemWrite,ALUSrc,RegWrite,Jump,HALT,Jump_R,Branch_NE,IN,OUT,sign_extension_mode,opcode);

input				 [3:0]	opcode;
output 		reg [2:0]   ALU_OP;
output 		reg [1:0]   MemtoReg,REGDst;
output 		reg 			ALUSrc;  //R-type signals
output 		reg 			MemRead,MemWrite,RegWrite;
output 		reg 			Branch ,Branch_NE;
output 		reg 			Jump,Jump_R; //J-type signals
output 		reg 			HALT,IN,OUT,sign_extension_mode;

always @ (*)
	begin
		case(opcode)
			4'h0: begin   //R-type operations
						ALU_OP<=3'b111;
						REGDst<=1;
						ALUSrc<=0;
						MemtoReg<=0;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=1;
						Branch<=0;
						Branch_NE<=0;
						Jump<=0;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=0;
						sign_extension_mode<=1'b0;
					end
			4'h1: begin   //IN
						ALU_OP<=3'bxxx;
						REGDst<=1;
						ALUSrc<=1'bX;
						MemtoReg<=2'bXX;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=1;
						Branch<=0;
						Branch_NE<=0;	
						Jump<=0;
						Jump_R<=0;
						HALT<=0;
						IN<=1;
						OUT<=0;
						sign_extension_mode<=1'bx;
					end		
			4'h2:	begin   //out = reg value 
						ALU_OP<=3'b001;
						REGDst<=0;
						ALUSrc<=1'bX;
						MemtoReg<=0;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=0;
						Branch<=0;
						Branch_NE<=0;
						Jump<=0;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=1;
						sign_extension_mode<=1'bx;
					end			
			4'h3:	begin   //Jump to Address in Register
						ALU_OP<=3'bxxx;
						REGDst<=2'bXX;
						ALUSrc<=1'bX;
						MemtoReg<=2'bXX;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=0;
						Branch<=1'bX;
						Branch_NE<=1'bX;
						Jump<=0;
						Jump_R<=1;
						HALT<=0;
						IN<=0;
						OUT<=0;
						sign_extension_mode<=1'bx;						
					end			
			4'h4:	begin   //ADDI
						ALU_OP<=3'b000;
						REGDst<=0;
						ALUSrc<=1;
						MemtoReg<=0;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=1;
						Branch<=0;
						Branch_NE<=0;		
						Jump<=0;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=0;		
						sign_extension_mode<=0;						
					end			
			4'h5:	begin   //ANDI
						ALU_OP<=3'b101;
						REGDst<=0;
						ALUSrc<=1;
						MemtoReg<=0;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=1;
						Branch<=0;
						Branch_NE<=0;
						Jump<=0;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=0;		
						sign_extension_mode<=1;												
					end			
			4'h6:	begin   //ORI
						ALU_OP<=3'b110;
						REGDst<=0;
						ALUSrc<=1;
						MemtoReg<=0;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=1;
						Branch<=0;
						Branch_NE<=0;	
						Jump<=0;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=0;		
						sign_extension_mode<=1;																		
					end			
			4'h7:	begin   //LW
						ALU_OP<=3'b000;
						REGDst<=0;
						ALUSrc<=1;
						MemtoReg<=1;
						MemRead<=1;
						MemWrite<=0;
						RegWrite<=1;
						Branch<=0;
						Branch_NE<=0;
						Jump<=0;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=0;
						sign_extension_mode<=0;						
					end		
			4'h8:	begin   //SW
						ALU_OP<=3'b000;
						REGDst<=2'bxx;
						ALUSrc<=1;
						MemtoReg<=2'bxx;
						MemRead<=0;
						MemWrite<=1;
						RegWrite<=0;
						Branch<=0;
						Branch_NE<=0;
						Jump<=0;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=0;		
						sign_extension_mode<=0;												
					end		
			4'h9:	begin   //BEQ
						ALU_OP<=3'b010;
						REGDst<=2'bxx;
						ALUSrc<=0;
						MemtoReg<=2'bxx;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=0;
						Branch<=1;
						Branch_NE<=0;
						Jump<=0;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=0;		
						sign_extension_mode<=0;												
					end		
			4'hA:	begin   //BNE
						ALU_OP<=3'b010;
						REGDst<=2'bxx;
						ALUSrc<=0;
						MemtoReg<=2'bxx;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=0;
						Branch<=0;
						Branch_NE<=1;
						Jump<=0;
						Jump_R<=0;
						HALT<=0;	
						IN<=0;
						OUT<=0;
						sign_extension_mode<=0;																		
					end		
			4'hB:	begin   //JUMP
						ALU_OP<=3'bxxx;
						REGDst<=2'bxx;
						ALUSrc<=1'bx;
						MemtoReg<=2'bxx;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=0;
						Branch<=0;
						Branch_NE<=0;
						Jump<=1;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=0;	
						sign_extension_mode<=1'bx;																		
					end	
			4'hC:	begin   //Jump and Link
						ALU_OP<=3'bxxx;
						REGDst<=2;
						ALUSrc<=1'bx;
						MemtoReg<=2;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=1;
						Branch<=1'bx;
						Branch_NE<=1'bx;
						Jump<=1;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=0;	
						sign_extension_mode<=1'bx;																								
					end	
			4'hE:	begin   //NOP					
						ALU_OP<=3'bxxx;
						REGDst<=2'bxx;
						ALUSrc<=1'bx;
						MemtoReg<=2'bxx;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=0;
						Branch<=0;
						Branch_NE<=0;
						Jump<=0;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=0;		
						sign_extension_mode<=1'bx;																								
					end			
			4'hF:	begin   //HALT
						ALU_OP<=3'bxxx;
						REGDst<=2'bxx;
						ALUSrc<=1'bx;
						MemtoReg<=2'bxx;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=0;
						Branch<=0;
						Branch_NE<=0;
						Jump<=0;
						Jump_R<=0;
						HALT<=1;
						IN<=0;
						OUT<=0;		
						sign_extension_mode<=1'bx;																								
					end	
			default: begin   
						ALU_OP<=3'bxxx;
						REGDst<=2'bxx;
						ALUSrc<=1'bx;
						MemtoReg<=2'bxx;
						MemRead<=0;
						MemWrite<=0;
						RegWrite<=0;
						Branch<=0;
						Branch_NE<=0;
						Jump<=0;
						Jump_R<=0;
						HALT<=0;
						IN<=0;
						OUT<=0;			
						sign_extension_mode<=1'bx;																								
					end	
		endcase
	end	
endmodule

