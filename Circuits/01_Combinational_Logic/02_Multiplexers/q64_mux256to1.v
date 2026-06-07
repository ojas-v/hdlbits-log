/*
Create a 1-bit wide, 256-to-1 multiplexer. The 256 inputs are all packed into a single 256-bit input vector. sel=0 should select in[0], sel=1 selects bits in[1], sel=2 selects bits in[2], etc.

Expected solution length: Around 1 line.
*/

module top_module( 
    input wire [255:0] in,
    input wire [7:0] sel,
    output wire out 
);

    assign out = in[sel];

endmodule