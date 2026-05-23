/*
This exercise is an extension of module_shift. Instead of module ports being only single pins, we now have modules with vectors as ports, to which you will attach wire vectors instead of plain wires. Like everywhere else in Verilog, the vector length of the port does not have to match the wire connecting to it, but this will cause zero-padding or truncation of the vector. This exercise does not use connections with mismatched vector lengths.

You are given a module my_dff8 with two inputs and one output (that implements a set of 8 D flip-flops). Instantiate three of them, then chain them together to make a 8-bit wide shift register of length 3. In addition, create a 4-to-1 multiplexer (not provided) that chooses what to output depending on sel[1:0]: The value at the input d, after the first, after the second, or after the third D flip-flop. (Essentially, sel selects how many cycles to delay the input, from zero to three clock cycles.)

The module provided to you is: module my_dff8 ( input clk, input [7:0] d, output [7:0] q );

The multiplexer is not provided. One possible way to write one is inside an always block with a case statement inside. (See also: mux9to1v)
*/

`default_nettype none
module top_module ( 
    input wire clk, 
    input wire [7:0] d, 
    input wire [1:0] sel, 
    output reg [7:0] q  
);

    // 1. Declare wires to hold the output of each DFF stage
    wire [7:0] q1;
    wire [7:0] q2;
    wire [7:0] q3;
    
    // 2. Instantiate the 3-stage shift register
    my_dff8 dff1 ( .clk(clk), .d(d),  .q(q1) );
    my_dff8 dff2 ( .clk(clk), .d(q1), .q(q2) );
    my_dff8 dff3 ( .clk(clk), .d(q2), .q(q3) );
    
    // 3. The 4-to-1 Multiplexer
    always @(*) begin
        case(sel)
            2'd0: q = d;   // sel = 0: Output the raw input
            2'd1: q = q1;  // sel = 1: Output after 1st DFF
            2'd2: q = q2;  // sel = 2: Output after 2nd DFF
            2'd3: q = q3;  // sel = 3: Output after 3rd DFF
            default: q = 8'b0; 
        endcase
    end

endmodule