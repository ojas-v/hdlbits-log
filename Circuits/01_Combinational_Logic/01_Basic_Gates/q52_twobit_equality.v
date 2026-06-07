/*
Create a circuit that has two 2-bit inputs A[1:0] and B[1:0], and produces an output z. The value of z should be 1 if A = B, otherwise z should be 0.
*/

`default_nettype none
module top_module ( 
    input wire [1:0] A, 
    input wire [1:0] B, 
    output wire z 
); 

    // The '==' operator directly synthesizes into a hardware comparator
    assign z = (A == B);
    
endmodule