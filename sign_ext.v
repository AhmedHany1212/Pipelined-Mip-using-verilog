

module sign_ext(
 output reg 	   [15:0] 		out16,    
 input 				[5:0] 		in6,
 input 								sign_extension_mode
);
 

always @*
 begin 
   case(sign_extension_mode)
	 1'b0      :  out16<={{10{in6[5]}},in6[5:0]};
	 1'b1      : out16<={{10'b0000000000},in6[5:0]};
	 default   : out16<={{10'b0000000000},in6[5:0]};
   endcase
 end
 
endmodule 