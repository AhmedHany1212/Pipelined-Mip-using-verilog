module Comparator #(parameter n=16) (
output reg   Comparator_output ,
input  wire	 [n-1:0] in1, 
input  wire  [n-1:0] in2
);

always@(*)
begin
Comparator_output=0;
if(in1 == in2 )
begin
Comparator_output=1; 
end
else ;
end

endmodule