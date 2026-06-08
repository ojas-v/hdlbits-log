/* q68. Now that you know how to build a full adder, make 3 instances of it to create a 3-bit binary ripple-carry adder. The adder adds two 3-bit numbers and a carry-in to produce a 3-bit sum and carry out. To encourage you to actually instantiate full adders, also output the carry-out from each full adder in the ripple-carry adder. cout[2] is the final carry-out from the last full adder, and is the carry-out you usually see.
*/


`default_nettype none

module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum 
);

    // Stage 0: LSB
    fadd inst_fa0 (
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .cout(cout[0]), // The output carry of Stage 0
        .sum(sum[0])
    );

    // Stage 1: Middle Bit
    fadd inst_fa1 (
        .a(a[1]),
        .b(b[1]),
        .cin(cout[0]),  // Routed directly from Stage 0's carry out!
        .cout(cout[1]),
        .sum(sum[1])
    );

    // Stage 2: MSB
    fadd inst_fa2 (
        .a(a[2]),
        .b(b[2]),
        .cin(cout[1]),  // Routed directly from Stage 1's carry out!
        .cout(cout[2]),
        .sum(sum[2])
    );

endmodule

// The sub-module blueprint (The same logic you built in Q67)
module fadd(
    input a, b, cin,
    output cout, sum
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);
endmodule

