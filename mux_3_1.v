`timescale 1ns / 1ps


module mux_3_1 #(parameter n=3)
(
    output 	reg	[n-1:0] 			out1,
    input 	 		[n-1:0] 			in1,
    input  			[n-1:0] 			in2,
    input  			[n-1:0] 			in3,
    input  			[1:0] 			sel
    );

always@(*)
begin 
  case(sel)
   2'b00:out1<=in1;
	2'b01:out1<=in2;
	2'b10:out1<=in3;
	default:out1<=in1;
  endcase
end

endmodule
