/*
An adder-subtractor can be built from an adder by optionally negating one of the inputs, which is equivalent to inverting the input then adding 1. The net result is a circuit that can do two operations: (a + b + 0) and (a + ~b + 1). See Wikipedia if you want a more detailed explanation of how this circuit works.

Build the adder-subtractor below.

You are provided with a 16-bit adder module, which you need to instantiate twice:

module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );

Use a 32-bit wide XOR gate to invert the b input whenever sub is 1. (This can also be viewed as b[31:0] XORed with sub replicated 32 times. See replication operator.). Also connect the sub input to the carry-in of the adder.

*/

module top_module(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire sub,
    output wire [31:0] sum
);

    // 1. Declare the physical wires
    wire carry_connect;
    wire [31:0] b_xor;

    // 2. XOR
    // If sub = 0, b_xor = b. 
    // If sub = 1, b_xor = ~b.
    assign b_xor = b ^ {32{sub}};

    // 3. Lower 16-bit Adder
    add16 lower_adder (
        .a(a[15:0]),
        .b(b_xor[15:0]),
        .cin(sub),               
        .sum(sum[15:0]),
        .cout(carry_connect)     // Pass the carry up the chain
    );

    // 4. Upper 16-bit Adder
    add16 upper_adder (
        .a(a[31:16]),
        .b(b_xor[31:16]),
        .cin(carry_connect),     
        .sum(sum[31:16]),
        .cout()                  // Ignore final carry out
    );

endmodule
