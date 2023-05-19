


module demux(
    output 	reg	[15:0] 	out0,
    output  reg  	[15:0] 	out1,
    input 		[15:0] 	in_put,
    input sel
    );


always @*
 begin 
   case(sel)
	 1'b0      :  out0<=in_put;
	 1'b1      : out1<=in_put;
	 default   : begin out1<=16'bz; out0<=16'bz; end
   endcase
 end

endmodule
