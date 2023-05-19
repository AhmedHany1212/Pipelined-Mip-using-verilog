module IF2ID #(parameter n=16)(
		output reg  [n-1:0]  ID_inst , ID_PC_adder_out ,
		input  		[n-1:0]	 inst , PC_adder_out ,
		input          		 clk,rst,IF2ID_EN
 );

  always @ (posedge clk) begin
    if (rst ) begin
      {ID_inst , ID_PC_adder_out} <= 0;
    end
    else if (IF2ID_EN ) begin
      ID_inst <= inst;
      ID_PC_adder_out <= PC_adder_out;
    end
  end
endmodule // IF2ID
