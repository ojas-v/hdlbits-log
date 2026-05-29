// Build a circuit that has two 3-bit inputs that computes the bitwise-OR of the two vectors, the logical-OR of the two vectors, and the inverse (NOT) of both vectors. 
// Place the inverse of b in the upper half of out_not (i.e., bits [5:3]), and the inverse of a in the lower half.

`default_nettype none
module top_module( 
    input wire [2:0] a,
    input wire [2:0] b,
    output wire [2:0] out_or_bitwise,
    output wire out_or_logical,
    output wire [5:0] out_not
);

    // Three parallel OR gates
    assign out_or_bitwise = a | b;
    
    // One massive 6-input OR reduction tree
    assign out_or_logical = a || b;
    
    // Invert both buses, then physically bundle them. b goes in the upper half [5:3].
    assign out_not = {~b, ~a};

endmodule
