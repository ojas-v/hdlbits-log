*/
You are provided with a BCD one-digit adder named bcd_fadd that adds two BCD digits and carry-in, and produces a sum and carry-out.

module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
Instantiate 100 copies of bcd_fadd to create a 100-digit BCD ripple-carry adder. 
Your adder should add two 100-digit BCD numbers (packed into 400-bit vectors) and a carry-in to produce a 100-digit sum and carry out.
*/

`default_nettype none
module top_module( 
    input wire [399:0] a, b,
    input wire cin,
    output wire cout,
    output wire [399:0] sum 
);

    wire [99:0] carry;
    assign cout = carry[99];

    // (Base Case)
    bcd_fadd adder_0 (
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .cout(carry[0]),
        .sum(sum[3:0])
    );

    genvar i; // Just a dummy variable for the compiler's copy-paste job
    
    generate
        for (i = 1; i < 100; i = i + 1) begin : bcd_chain
            // 3. Place the next 99 chips
            bcd_fadd adder_i (
                .a(a[4*i+3 : 4*i]),     
                .b(b[4*i+3 : 4*i]),     
                .cin(carry[i-1]),       
                .cout(carry[i]),        
                .sum(sum[4*i+3 : 4*i])  
            );
        end
    endgenerate

endmodule

