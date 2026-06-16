/*
Flip-Flop 1: The D pin is fed by an XOR gate connected to x and Q1. (D1 = x ^ Q1)
Flip-Flop 2: The D pin is fed by an AND gate connected to x and the inverted output of Q2. (D2 = x .Q2')
Flip-Flop 3: The D pin is fed by an OR gate connected to x and the inverted output of Q3. (D3 = x + Q3')
The Output (z): Driven by a NOR gate connected to the standard outputs of all three flip-flops. (z = {Q1 + Q2 + Q3}')
*/

module top_module (
    input clk,
    input x,
    output z
); 

    // define the outpputs of ffs
    reg q1, q2, q3;
    
    // initialise the flipslops to 0 to prevent x-propagation'
    initial begin
    	q1 = 1'b0;
    	q2 = 1'b0;
    	q3 = 1'b0;
    end
    
    // sequential logic according to the given diagram
    always @(posedge clk) begin
    	q1 <= x ^ q1;
        q2 <= x & ~q2;
        q3 <= x | ~q3;
    end
    
    // final output
    assign z = ~(q1 | q2 | q3);
        
    
endmodule
