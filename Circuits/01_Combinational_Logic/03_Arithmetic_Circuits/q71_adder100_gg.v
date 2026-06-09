/*
Create a 100-bit binary adder. The adder adds two 100-bit numbers and a carry-in to produce a 100-bit sum and carry out.

*/

module top_module( 
    input wire [99:0] a, b,
    input wire cin,
    output wire cout,
    output wire [99:0] sum 
);

    // Internal wire to chain the carry bits between the 100 adders
    wire [99:0] cout_chain;

    // Connect the final carry out of the chain to the top module output
    assign cout = cout_chain[99];

    // Structural generation of 100 full adders
    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin : adder_chain
            if (i == 0) begin
                // Stage 0 takes the initial cin
                fadd inst_fa (
                    .a(a[i]), .b(b[i]), .cin(cin), 
                    .cout(cout_chain[i]), .sum(sum[i])
                );
            end else begin
                // Stages 1-99 take the cin from the previous stage's cout
                fadd inst_fa (
                    .a(a[i]), .b(b[i]), .cin(cout_chain[i-1]), 
                    .cout(cout_chain[i]), .sum(sum[i])
                );
            end
        end
    endgenerate

endmodule

// The sub-module must be defined OUTSIDE the top_module
module fadd(
    input wire a, b, cin,
    output wire cout, sum
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);
endmodule