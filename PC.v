
module PC #(parameter n=16)(
    output reg [n-1:0] PC_out,
    input [n-1:0] PC_in,
	 input clk,rst
    );


    always @ (posedge clk )
    begin
        if(rst)
        begin
            PC_out<=16'h0000;
        end
        else 
        begin
             PC_out<=PC_in ;
        end 
    end
endmodule
