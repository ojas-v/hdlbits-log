/*
q66. Create a half adder. A half adder adds two bits (with no carry-in) and produces a sum and carry-out.

Expected solution length: Around 2 lines.
*/


module top_module( 

    input a, b,

    output cout, sum );

    

    assign cout = a & b;

    assign sum = a ^ b;



endmodule

