module inst_mem #(parameter n=16)(
    output [n-1:0] inst,
    input [n-1:0] read_address
    );
    reg [n-1:0] rom [20:0];
    
	 //op_codes
	 localparam R_type=4'h0    , 
	           IN    =4'h1    ,
				  OUT   =4'h2    ,
				  JR    =4'h3    ,
				  ADDI  =4'h4    , 
				  ANDI  =4'h5    ,
			     ORI   =4'h6    ,
				  LW    =4'h7    ,
				  SW    =4'h8    ,
				  BEQ   =4'h9    , 
				  BNE   =4'hA    ,
				  J     =4'hB    , 
				  JAL   =4'hC    ,
				  NOP   =4'hE    ,
				  HALT  =4'hF    ;

	//R_TYPE_FUNCTIONS
	localparam ADD_func=3'b000  , 
	           SUB_func=3'b001  , 
				  AND_func=3'b010  , 
				  OR_func=3'b011   , 
				  NOR_func=3'b100  ,
			     XOR_func=3'b101  , 
				  SLL_func=3'b110  , 
				  SRL_func=3'b111  ;  
   			  
 //register file addresses   
	localparam R0=3'b000  ,
	           R1=3'b001  , 
				  R2=3'b010 , 
				  R3=3'b011 , 
				  R4=3'b100 ,
			     R5=3'b101 , 
				  R6=3'b110 , 
				  R7=3'b111 ;  
			 
	 
	  


 initial
  begin

	//check load 
	rom[16'h0] = {LW,R0,R0,6'b000001};//load "1" in register 0
	rom[16'h1] = {LW,R1,R1,6'b000001};//load "1" in register 1
	
	
	rom[16'h2] = {BEQ,R0,R1,6'b000001};
	rom[16'h3] = {NOP,R0,R0,R0,R0};
	rom[16'h4] = {ADDI,R2,R0,6'b000001};//R0=2
	rom[16'h5] = {BNE,R0,R1,6'b000001};
	rom[16'h3] = {NOP,R0,R0,R0,R0};
	rom[16'h4] = {ADDI,R2,R0,6'b000001};//R0=3
	rom[16'h5] = {J,12'b000000001000}; //jump to instruction 8 
	rom[16'h6] = {NOP,R0,R0,R0,R0};
	rom[16'h7] = {NOP,R0,R0,R0,R0};
	rom[16'h8] = {ADDI,R2,R0,6'b000001};//R0=4
	rom[16'h9] = {JR,12'b000000001011};
	rom[16'h10] = {NOP,R0,R0,R0,R0};
	rom[16'h11] = {ADDI,R2,R0,6'b000001};//R0=5
	rom[16'h12] = {JAL,12'b000000001110};
	rom[16'h13] = {NOP,R0,R0,R0,R0};
	rom[16'h14] = {JR,R0,R0,R0,R0};// go to BNE in mem[5] and will not branch
	
	
	
	
	
	
	
	
	/* //check the alu 8 R_TYPE FUNCTIONS
	rom[16'h2] = {R_type,R1,R0,R2,ADD_func};//3 in R2?
	
	rom[16'h3] = {R_type,R1,R0,R3,SUB_func};//1 in R3?
	rom[16'h4] = {R_type,R1,R0,R4,AND_func};//0 in R4?
	rom[16'h5] = {R_type,R1,R0,R5,OR_func};//3 in R5?
	rom[16'h6] = {R_type,R1,R0,R6,NOR_func};//252 in R6?
	rom[16'h7] = {R_type,R1,R0,R7,XOR_func};//3 in R7?
	rom[16'h8] = {R_type,R1,R0,R0,SLL_func};//2 in R0?
	rom[16'h9]= {R_type,R0,R1,R1,SRL_func};//4 in R1?
	 *///check I_TYPE INSTRUCTIONS(ADDI ANDI ORI)
	
	//store in R1(RT) = [R0=RS]
/* 	rom[16'hA]= {ADDI,R0,R1,6'b0};//2 in R0?(mem[2])?
	rom[16'hB]= {ANDI,R2,R1,6'b0};//store 0 in R2
	rom[16'hC]= {ORI,R3,R1,6'b0};
	//check store
	rom[16'hD]= {SW,R2,R6,6'b1}; //mem[1]=252?
	//IN&out ports
	rom[16'hE]= {IN,R5,R5,R5,R5}; //R5=IN_PORT?
   rom[16'hF]= {OUT,R5,R5,R5,R5};
	rom[16'h10]= {NOP,R0,R0,R0,R0};//pc increment
   rom[16'h11]= {NOP,R0,R0,R0,R0};//pc increment
   //???? ??????
	rom[16'h12]= {HALT,12'b0};//STOP	
  */end


    assign   inst = rom[read_address];
endmodule