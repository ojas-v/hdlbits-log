/*
Given four unsigned numbers, find the minimum. Unsigned numbers can be compared with 
standard comparison operators (a < b). Use the conditional operator to make two-way 
min circuits, then compose a few of them to create a 4-way min circuit. You'll 
probably want some wire vectors for the intermediate results.


*/

module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    // declare wires
    wire [7:0] min_ab;
    wire [7:0] min_cd;
    
    // assign intermediate_result1 = compare? true: false;
    assign min_ab = (a<b) ? a : b;
    
    assign min_cd = (c<d) ? c : d;
    
    assign min = (min_ab < min_cd) ? min_ab : min_cd;
    
   
endmodule
