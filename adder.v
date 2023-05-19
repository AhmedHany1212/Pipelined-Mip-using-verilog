`timescale 1ns / 1ps


module adder #(parameter n=16)(
    output [n-1:0] out_put,
    input [n-1:0] in1,
    input [n-1:0] in2
    );


assign out_put = in1 + in2;

endmodule
