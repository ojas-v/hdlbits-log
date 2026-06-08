/*
Create a 4-bit wide, 256-to-1 multiplexer. The 256 4-bit inputs are all packed into a single 1024-bit input vector. sel=0 should select bits in[3:0], sel=1 selects bits in[7:4], sel=2 selects bits in[11:8], etc.

Expected solution length: Around 1–5 lines.
*/
module top_module( 
    input wire [1023:0] in,
    input wire [7:0] sel,
    output wire [3:0] out 
);

    // Start at index (sel * 4), and grab exactly 4 bits going upwards
    assign out = in[sel*4 +: 4];

endmodule