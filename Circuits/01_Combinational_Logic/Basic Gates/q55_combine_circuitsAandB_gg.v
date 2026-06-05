/*
Taken from 2015 midterm question 4

See mt2015_q4a and mt2015_q4b for the submodules used here. The top-level design consists of two instantiations each of subcircuits A and B, as shown below.
*/
`default_nettype none

module top_module (
    input wire x,
    input wire y,
    output wire z
);

    // Intermediate routing wires
    wire z_a1, z_b1, z_a2, z_b2;

    // Structural Instantiation: Two of A, Two of B
    A inst_a1 ( .x(x), .y(y), .z(z_a1) );
    B inst_b1 ( .x(x), .y(y), .z(z_b1) );
    
    A inst_a2 ( .x(x), .y(y), .z(z_a2) );
    B inst_b2 ( .x(x), .y(y), .z(z_b2) );

    // Top-level routing
    assign z = (z_a1 | z_b1) ^ (z_a2 & z_b2);

endmodule

// Include the submodules below so the compiler can link them
module A (
    input wire x,
    input wire y,
    output wire z
);
    assign z = x & ~y; // Minimized from (x^y) & x
endmodule

module B (
    input wire x,
    input wire y,
    output wire z
);
    assign z = ~(x^y);
endmodule