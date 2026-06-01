/*
A "population count" circuit counts the number of '1's in an input vector. Build a population count circuit for a 255-bit input vector.

*/

`default_nettype none
module top_module( 
    input wire [254:0] in,
    output reg [7:0] out // Must be reg since it's driven procedurally
);

    integer i;
    
    always @(*) begin
        // Reset the counter to 0 before we start checking bits.
        // This guarantees pure combinational logic (no latches).
        out = 8'd0; 
        
        // Loop through exactly 255 bits (indices 0 through 254)
        for(i = 0; i < 255; i = i + 1) begin
            if(in[i] == 1'b1) begin
                out = out + 1'b1; // Increment the count
            end
        end
    end

endmodule