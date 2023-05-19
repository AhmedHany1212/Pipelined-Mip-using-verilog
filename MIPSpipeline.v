module MIPSpipeline #(parameter n=16)(
input 			clk,rst,
input  [n-1:0]	in_port,
output [n-1:0]  out_port
    );
	 

wire [n-1:0] PC_in, PC_out,ID_PC_out,MEM_PC_out,EX_PC_out,PC_adder_out,ID_PC_adder_out,EX_PC_adder_out,MEM_PC_adder_out,WB_PC_adder_out,PC_adder_branch_out,MEM_PC_adder_branch_out;
wire [n-1:0] inst_mux,inst_output,inst,EX_inst,ID_inst,MEM_inst,WB_inst,ReadData_dmem,WB_ReadData_dmem; // Output of Instruction Memory
wire [3:0] opcode,ALU_control; // Opcode
wire [2:0] func,EX_rs,MEM_rs,ID_rs,EX_rt,MEM_rt,ID_rt,MEM_rd,EX_rd,WB_rd,WB_WriteRegister,EX_WriteRegister,MEM_WriteRegister,ALU_OP,EX_ALU_OP,ALU_OP_mux; //  Function

// Extend
wire [5:0] imm; // immediate in I type instruction
wire [n-1:0] sign_ex,EX_sign_ex;
// regfile
wire [n-1:0]  ReadData1,EX_ReadData1, ReadData2,EX_ReadData2,MEM_ReadData2,WriteData;


// ALU
wire [n-1:0] Bus_A_ALU,Bus_B_ALU,ALU_out,MEM_ALU_out,WB_ALU_out;
wire zero,MEM_zero,IF_DWrite,rst_output,IF2ID_EN,ID2EX_EN,PC_EN;

//Control signals 
wire ALUSrc,ALUSrc_mux,EX_ALUSrc,EX_RegWrite,MemRead,EX_MemRead,MemRead_mux,MEM_MemRead,WB_RegWrite,RegWrite,RegWrite_mux,MEM_RegWrite,MemWrite,MemWrite_mux,EX_MemWrite,MEM_MemWrite,Branch,Branch_mux,EX_Branch,MEM_Branch,Branch_NE,EX_Branch_NE,MEM_Branch_NE;
wire  Branch_NE_mux,Jump,EX_Jump,MEM_Jump,Jump_mux,Jump_R,MEM_Jump_R,Jump_R_mux,EX_Jump_R,HALT,EX_HALT,HALT_output,HALT_mux,MEM_HALT,IN,EX_IN,MEM_IN,WB_IN,IN_mux,OUT,OUT_mux,EX_OUT,MEM_OUT,WB_OUT,sign_extension_mode,sign_extension_mode_mux,branch_out,muxsel;
wire [1:0]   MemtoReg,MemtoReg_mux,EX_MemtoReg,MEM_MemtoReg,WB_MemtoReg,REGDst,EX_REGDst,MEM_REGDst,WB_REGDst,REGDst_mux;

//mux 
wire [n-1:0] Mux3_1_Jump_Out,Demux_In,demux_mux,Mux3_1_Jump_In3,MUX2_1_BNE_Out,Mux3_1_rd2_out,Mux3_1_rd1_out,Mux2_1_rd1_out,Mux2_1_rd2_out,Comparator_output;
wire [1:0]	 Mux3_1_Jump_Sel,ForwardA,ForwardB,ForwardC,ForwardD;


//========= Fetch STAGE===========

assign inst_output = Branch | Jump | Branch_NE;

PC PC( //reg delay 1 clk???????
.PC_out(PC_out) ,.PC_in(PC_in) ,.clk(clk) ,.rst(rst) );

inst_mem inst_mem(
.inst(inst) ,.read_address(PC_out) );
//registers in maping?????
adder ADDER_PC(
.out_put(PC_adder_out) ,.in1(PC_out) ,.in2(1) );

mux_2_1 MUX_2_1_inst(
.out1(inst_mux) ,.in1(inst) ,.in2(	{16'hE000}) ,.sel(inst_output) );

//========= IF2ID ===========

IF2ID IF2ID(
.ID_inst(ID_inst) ,.ID_PC_adder_out(ID_PC_adder_out)  ,.inst(inst_mux)  ,.PC_adder_out(PC_adder_out)  ,.clk(clk) ,.rst(rst) ,.IF2ID_EN(IF2ID_EN) );

//========= ID STAGE===========
assign opcode = ID_inst[15:12];
assign imm= ID_inst[5:0];
assign ID_rs = ID_inst[11:9];
assign ID_rt = ID_inst[8:6];


Main_Controller Main_Controller(
.REGDst(REGDst) ,.Branch(Branch) ,.MemRead(MemRead) ,.MemtoReg(MemtoReg) ,.ALU_OP(ALU_OP) ,.MemWrite(MemWrite) ,.ALUSrc(ALUSrc)
,.RegWrite(RegWrite) ,.Jump(Jump) ,.HALT(HALT),.Jump_R(Jump_R) ,.Branch_NE(Branch_NE) ,.IN(IN),.OUT(OUT)
,.sign_extension_mode(sign_extension_mode) ,.opcode(opcode) );

// Forwarding_unit_beq

Forwarding_unit_beq Forwarding_unit_beq(
.ForwardC(ForwardC) ,.ForwardD(ForwardD) ,.ID_rs(ID_rs) ,.ID_rt(ID_rt) ,. MEM_rd(MEM_rd) ,.Branch(Branch)  );


reg_file reg_file(
.ReadData1(ReadData1) ,.ReadData2(ReadData2)  ,.RegWrite(WB_RegWrite) ,. WriteRegister(WB_WriteRegister) ,.ReadReg1(ID_rs) ,.ReadReg2(ID_rt) ,.WriteData(WriteData) );

mux_2_1 MUX2_1_rd1(
.out1(Mux2_1_rd1_out) ,.in1(ReadData1) ,.in2(MEM_ALU_out) ,.sel(ForwardC) );

mux_2_1 MUX2_1_rd2(
.out1(Mux2_1_rd2_out) ,.in1(ReadData2) ,.in2(MEM_ALU_out) ,.sel(ForwardD) );

Comparator Comparator(
.Comparator_output(Comparator_output) ,.in1(Mux2_1_rd1_out) ,.in2(Mux2_1_rd2_out) );

// Hazard_unit

Hazard_unit Hazard_unit(
.PC_EN(PC_EN) ,.IF2ID_EN(IF2ID_EN) ,.ID2EX_EN(ID2EX_EN) ,.EX_rd(EX_rd) ,.ID_rs(ID_rs) ,.ID_rt(ID_rt) ,.EX_rt(EX_rt) ,.Branch(Branch)
,.EX_Regwrite(EX_Regwrite) ,.Branch_NE(Branch_NE) );


sign_ext sign_ext(
.out16(sign_ex) ,.in6(imm) ,.sign_extension_mode(sign_extension_mode) );


adder PC_Adder_Branch(
.out_put(PC_adder_branch_out) ,.in1(ID_PC_adder_out) ,.in2(sign_ex) );

//Jump,bne, JRs

assign Mux3_1_Jump_Sel = {Jump,Jump_R};
assign Mux3_1_Jump_In3 ={ID_PC_adder_out[15:12],ID_inst[11:0]};
assign branch_out =(Branch&Comparator_output)|(Branch_NE&~Comparator_output) ;
assign HALT_output = (HALT |~ PC_EN);



mux_2_1 MUX2_1_BNE(
.out1(MUX2_1_BNE_Out) ,.in1(ID_PC_adder_out) ,.in2(PC_adder_branch_out) ,.sel(branch_out) );

	
Mux3_1_Demux  Mux3_1_Jump(
.out1(Mux3_1_Jump_Out) ,.in1(MUX2_1_BNE_Out) ,.in2(ReadData1) ,.in3(Mux3_1_Jump_In3) ,.sel(Mux3_1_Jump_Sel) );

mux_2_1 Mux_2_1_PC(
.out1(PC_in) ,.in1(Mux3_1_Jump_Out) ,.in2(PC_out) ,.sel(HALT_output) );



//========= ID2EXE ===========

assign rst_output = (rst | ID2EX_EN);

ID2EXE ID2EXE(
.EX_PC_adder_out(EX_PC_adder_out) ,.EX_inst(EX_inst)  ,.EX_ALU_OP(EX_ALU_OP)  ,.EX_ReadData1(EX_ReadData1)  ,.EX_ReadData2(EX_ReadData2)  ,.EX_sign_ex(EX_sign_ex) 
 ,.EX_ALUSrc(EX_ALUSrc),.EX_MemRead(EX_MemRead)
,.EX_MemWrite(EX_MemWrite) ,.EX_IN(EX_IN) ,.EX_OUT(EX_OUT),.EX_RegWrite(EX_RegWrite) ,.EX_MemtoReg(EX_MemtoReg) ,.EX_REGDst(EX_REGDst)
,.PC_adder_out(ID_PC_adder_out) ,.inst(ID_inst)  ,.ALU_OP(ALU_OP),.ReadData1(ReadData1) ,.ReadData2(ReadData2) ,.sign_ex(sign_ex)
,.ALUSrc(ALUSrc) ,.MemRead(MemRead) ,.MemWrite(MemWrite),.IN(IN) ,.OUT (OUT ) ,.RegWrite(RegWrite)
,.MemtoReg(MemtoReg),.REGDst(REGDst) ,.clk(clk) ,.rst(rst_output) );


//==========EX STAGE=========================

assign EX_rs = EX_inst[11:9];
assign EX_rt = EX_inst[8:6];
assign EX_rd = EX_inst[5:3];
assign func = EX_inst[2:0];

mux_3_1  Mux3_1_WriteReg(
.out1(EX_WriteRegister) ,.in1(EX_rt) ,.in2(EX_rd) ,.in3(3'b111) ,.sel(EX_REGDst) );

ALU_Controller ALU_Controller(
.ALU_control(ALU_control) ,.func(func) ,.ALU_OP(EX_ALU_OP) );

// Forwarding_unit

Forwarding_unit Forwarding_unit(
.ForwardA(ForwardA) ,.ForwardB(ForwardB) ,.EX_rs(EX_rs) ,.EX_rt(EX_rt) ,. MEM_rd(MEM_rd) ,.WB_rd(WB_rd) ,.MEM_RegWrite(MEM_RegWrite) ,.WB_RegWrite(WB_RegWrite)  );

Mux3_1_Demux  Mux3_1_rd1(
.out1(Mux3_1_rd1_out) ,.in1(EX_ReadData1) ,.in2(WriteData) ,.in3(MEM_ALU_out) ,.sel(ForwardA) );

Mux3_1_Demux  Mux3_1_rd2(
.out1(Mux3_1_rd2_out) ,.in1(EX_ReadData2) ,.in2(WriteData) ,.in3(MEM_ALU_out) ,.sel(ForwardB) );


mux_2_1 MUX_2_1_ALU(
.out1(Bus_B_ALU) ,.in1(Mux3_1_rd2_out) ,.in2(EX_sign_ex) ,.sel(EX_ALUSrc) );

// ALU

ALU ALU(
.ALU_out(ALU_out) ,.zero(zero) ,.Bus_A_ALU(Mux3_1_rd1_out) ,.Bus_B_ALU(Bus_B_ALU),.ALU_control(ALU_control) );




//========= EXE2MEM ===========

EXE2MEM EXE2MEM(
.MEM_PC_adder_out(MEM_PC_adder_out) ,.MEM_inst(MEM_inst)  ,.MEM_ALU_out(MEM_ALU_out) ,.MEM_ReadData2(MEM_ReadData2),.MEM_ReadData1(MEM_ReadData1)  ,.MEM_MemRead(MEM_MemRead)  ,.MEM_MemWrite(MEM_MemWrite)  ,.MEM_IN(MEM_IN) ,.MEM_OUT(MEM_OUT) 
,.MEM_RegWrite(MEM_RegWrite)  
,.MEM_MemtoReg(MEM_MemtoReg),.MEM_WriteRegister(MEM_WriteRegister)
,.PC_adder_out(EX_PC_adder_out) ,.inst(EX_inst)  ,.ALU_out(ALU_out) ,.ReadData2(Mux3_1_rd2_out) ,.ReadData1(Mux3_1_rd1_out)  ,.MemRead(EX_MemRead)  ,.MemWrite(EX_MemWrite)  ,.IN(EX_IN) ,.OUT(EX_OUT) 
,.RegWrite(EX_RegWrite) 
,.MemtoReg(EX_MemtoReg),.WriteRegister(EX_WriteRegister),.clk(clk) ,.rst(rst) );


//==========MEM STAGE====================

assign MEM_rs = MEM_inst[11:9];
assign MEM_rt = MEM_inst[8:6];
assign MEM_rd = MEM_inst[5:3];

data_mem data_mem(
.ReadData_dmem(ReadData_dmem) ,.MemWrite(MEM_MemWrite) ,.MemRead(MEM_MemRead) ,.address(MEM_ALU_out[7:0]) ,.WriteData_dmem(MEM_ReadData2) );


//========= MEM2WB ===========

MEM2WB MEM2WB(
.WB_MemtoReg(WB_MemtoReg) ,.WB_inst(WB_inst)  ,.WB_PC_adder_out(WB_PC_adder_out)  ,.WB_ReadData_dmem(WB_ReadData_dmem)  ,.WB_ALU_out(WB_ALU_out)  
,.WB_IN(WB_IN) ,.WB_OUT(WB_OUT) ,.WB_RegWrite(WB_RegWrite) ,.WB_WriteRegister(WB_WriteRegister)
 ,.MemtoReg(MEM_MemtoReg) ,.inst(MEM_inst) ,.PC_adder_out(MEM_PC_adder_out),.ReadData_dmem(ReadData_dmem) ,.ALU_out(MEM_ALU_out) 
,.IN(MEM_IN),.OUT(MEM_OUT) ,.WriteRegister(MEM_WriteRegister) ,.RegWrite(MEM_RegWrite) ,.clk(clk) ,.rst(rst) );


//==========WB STAGE====================

assign WB_rd = WB_inst[5:3];

Mux3_1_Demux  Mux3_1_Demux(
.out1(Demux_In) ,.in1(WB_ALU_out) ,.in2(WB_ReadData_dmem) ,.in3(WB_PC_adder_out) ,.sel(WB_MemtoReg) );


demux  Demux_DataOut(
.out0(demux_mux) ,.out1(out_port) ,.in_put(Demux_In) ,.sel(WB_OUT) );

mux_2_1 Mux_2_1_DataIn(
.out1(WriteData) ,.in1(demux_mux) ,.in2(in_port) ,.sel(WB_IN) );

	

endmodule


