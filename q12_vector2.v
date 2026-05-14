// Question: A 32-bit vector can be viewed as containing 4 bytes (bits [31:24], [23:16], etc.). Build a circuit that will reverse the byte ordering of the 4-byte word.

// AaaaaaaaBbbbbbbbCcccccccDddddddd => DdddddddCcccccccBbbbbbbbAaaaaaaa
// This operation is often used when the endianness of a piece of data needs to be swapped, for example between little-endian x86 systems and the big-endian formats used in many Internet protocols.

/*
module top_module( 
    input [31:0] in,
    output [31:0] out );//

    // assign out[31:24] = ...;
    // Assign the first input as first output
    assign out[31:24] = in[7:0];
    
    //Assign next in order in similar fashion
    assign out[23:16] = in[15:8];
    
    assign out[15:8] = in[23:16];
    assign out[7:0] = in[31:24];

endmodule
*/

`default_nettype none
module top_module( 
    input wire [31:0] in,
    output wire [31:0] out
);

    // Pack the 32-bit output bus using concatenation
    assign out = {in[7:0], in[15:8], in[23:16], in[31:24]};

endmodule
