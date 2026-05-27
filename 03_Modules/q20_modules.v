`default_nettype none
module top_module ( 
    input a, 
    input b, 
    output out 
);

    // Route your local wires (a, b, out) to its physical ports (in1, in2, out).
    
    mod_a inst1 (
        .in1(a),   // Route top-level input 'a' into mod_a's 'in1' pin
        .in2(b),   // Route top-level input 'b' into mod_a's 'in2' pin
        .out(out)  // Route mod_a's 'out' pin to top-level output 'out'
    );

endmodule