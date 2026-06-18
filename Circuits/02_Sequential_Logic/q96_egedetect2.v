module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);

    // internal register to store the input history
    reg [7:0] in_prev;
    
    // sequential logic
    always@(posedge clk) begin
    	in_prev <= in;
        
        anyedge = in ^ in_prev;
    end
endmodule
