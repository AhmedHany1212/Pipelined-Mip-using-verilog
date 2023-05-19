`timescale 1ns / 1ps


module mux_2_1 #(parameter n = 16)
(output 		[n-1:0]		out1,
 input 		[n-1:0]		in1,
 input 		[n-1:0]		in2,
 input             		sel
    );

assign out1=(sel==1)? in2:in1;

endmodule
