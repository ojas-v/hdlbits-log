/*
Given the state-assigned table shown below, implement the logic functions Y[0] and z.

Present state
y[2:0]	Next state Y[2:0]	Output z
x=0	x=1
000	000	001	0
001	001	100	0
010	010	001	0
011	001	010	1
100	011	100	1
*/

module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    // LOGIC FUNCTION FOR Y0, IT HAS FOUR CASES
    assign Y0 = (y == 3'b000 && x == 1'b1) ||
        		(y == 3'b001 && x == 1'b0) ||
        		(y == 3'b010 && x == 1'b1) ||
        		(y == 3'b011 && x == 1'b0) ||
        		(y == 3'b100 && x == 1'b0);

	// LOGIC FOR OUTPUT z
    assign z = (y == 3'b011 || y == 3'b100);
    
endmodule
