/*
This 4-to-1 multiplexer doesn't work. Fix the bug(s).

You are provided with a bug-free 2-to-1 multiplexer:

module mux2 (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output [7:0] out
);
*/

module top_module (
    input [1:0] sel,
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output [7:0] out  
); 
    
    wire [7:0] out0, out1;
    
    // First stage muxes driven by sel[0]
    mux2 u0 ( 
        .sel(sel[0]), 
        .a(a), 
        .b(b), 
        .out(out0) 
    );
    
    mux2 u1 ( 
        .sel(sel[0]), 
        .a(c), 
        .b(d), 
        .out(out1) 
    );
    
    // Second stage mux driven by sel[1]
    mux2 u2 ( 
        .sel(sel[1]), 
        .a(out0), 
        .b(out1), 
        .out(out) 
    );

endmodule
