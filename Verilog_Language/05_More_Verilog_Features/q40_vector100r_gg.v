/*
Given a 100-bit input vector [99:0], reverse its bit ordering.
*/

`default_nettype none
module top_module( 
    input wire [99:0] in,
    output reg [99:0] out // Must be reg because it's driven inside an always block
);
    
    // loop variables are declared as integers
    integer i;
    
    always @(*) begin
        for (i = 0; i < 100; i = i + 1) begin
            out[i] = in[99 - i];
        end
    end

endmodule