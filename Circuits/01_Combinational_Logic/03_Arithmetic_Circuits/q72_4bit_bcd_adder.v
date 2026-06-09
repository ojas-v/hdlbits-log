/*
You are provided with a BCD (binary-coded decimal) one-digit adder named bcd_fadd that adds two BCD digits and carry-in, and produces a sum and carry-out.

module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
Instantiate 4 copies of bcd_fadd to create a 4-digit BCD ripple-carry adder. Your adder should add two 4-digit BCD numbers (packed into 16-bit vectors) and a carry-in to produce a 4-digit sum and carry out.


module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
        
        // declare temp sum to store temp variable
        reg [4:0] temp_sum;
        
        always @(*) begin
        	temp_sum = a+b+cin;
            
            if(temp_sum > 5'd9) begin
            	sum = temp_sum + 4'b0110;
                cout = 1'b1;
            end
            else begin
            	sum  = temp_sum[3:0];           
            	cout = 1'b0;                    
        	end
        end
    endmodule
        
endmodule

*/

module top_module ( 
    input wire [15:0] a, b,
    input wire cin,
    output wire cout,
    output wire [15:0] sum 
);

    // Intermediate routing wires to daisy-chain the carry signal
    wire cout0, cout1, cout2;

    // Stage 0: Ones digit (Bits 3:0)
    bcd_fadd inst0 (
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .cout(cout0),
        .sum(sum[3:0])
    );

    // Stage 1: Tens digit (Bits 7:4)
    bcd_fadd inst1 (
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(cout0),      // Carry from Stage 0
        .cout(cout1),
        .sum(sum[7:4])
    );

    // Stage 2: Hundreds digit (Bits 11:8)
    bcd_fadd inst2 (
        .a(a[11:8]),
        .b(b[11:8]),
        .cin(cout1),      // Carry from Stage 1
        .cout(cout2),
        .sum(sum[11:8])
    );

    // Stage 3: Thousands digit (Bits 15:12)
    bcd_fadd inst3 (
        .a(a[15:12]),
        .b(b[15:12]),
        .cin(cout2),      // Carry from Stage 2
        .cout(cout),      // Final carry out to the top-level pin
        .sum(sum[15:12])
    );

endmodule