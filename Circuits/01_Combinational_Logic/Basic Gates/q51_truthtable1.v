/*
In the previous exercises, we used simple logic gates and combinations of several logic gates. These circuits are examples of combinational circuits. Combinational means the outputs of the circuit is a function (in the mathematics sense) of only its inputs. This means that for any given input value, there is only one possible output value. Thus, one way to describe the behaviour of a combinational function is to explicitly list what the output should be for every possible value of the inputs. This is a truth table.

For a boolean function of N inputs, there are 2N possible input combinations. Each row of the truth table lists one input combination, so there are always 2N rows. The output column shows what the output should be for each input value.


Row	Inputs	Outputs
number	x3	x2	x1	f
0	0	0	0	0
1	0	0	1	0
2	0	1	0	1
3	0	1	1	1
4	1	0	0	0
5	1	0	1	1
6	1	1	0	0
7	1	1	1	1
The above truth table is for a three-input, one-output function. It has 8 rows for each of the 8 possible input combinations, and one output column. There are four inputs combinations where the output is 1, and four where the output is 0.

Create a combinational circuit that implements the above truth table.
*/


/*
===================================================================================================================================================================
APPROACH 1: Brute Force
`default_nettype none
module top_module( 
    input wire x3,
    input wire x2,
    input wire x1,  
    output wire f   
);

    // Each line in this parenthesis block perfectly matches one row 
    // from the truth table where the output 'f' equals 1.
    
    assign f = ( ~x3 &  x2 & ~x1 ) |  // Row 2: 0 1 0
               ( ~x3 &  x2 &  x1 ) |  // Row 3: 0 1 1
               (  x3 & ~x2 &  x1 ) |  // Row 5: 1 0 1
               (  x3 &  x2 &  x1 );   // Row 7: 1 1 1

endmodule
=============================================================================================================================================================================================
*/

/*
==============================================================================================================================================================================================
APPROACH 2: Boolean Minimization
Rows 2 and 3: Notice that in both rows, x3 is 0 and x2 is 1. The x1 bit doesn't matter at all (it's 0 in row 2 and 1 in row 3). This simplifies down to just: (~x3 & x2)

Rows 5 and 7: In both rows, x3 is 1 and x1 is 1. The x2 bit doesn't matter. This simplifies down to just: (x3 & x1)
*/
`default_nettype none
module top_module( 
    input wire x3,
    input wire x2,
    input wire x1,  
    output wire f   
);

    // Minimized logic derived from the truth table
    assign f = (~x3 & x2) | (x3 & x1);

endmodule
/*
===========================================================================================================================================================================================
*/