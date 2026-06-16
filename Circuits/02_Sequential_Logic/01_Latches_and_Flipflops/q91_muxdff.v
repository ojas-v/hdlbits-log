/*
Taken from ECE253 2015 midterm question 5

Consider the sequential circuit below:



Assume that you want to implement hierarchical Verilog code for this circuit, using three instantiations of a submodule that has a flip-flop and multiplexer in it. Write a Verilog module (containing one flip-flop and multiplexer) named top_module for this submodule.


*/

module top_module (
    input wire clk,
    input wire L,
    input wire r_in,
    input wire q_in,
    output reg Q   // Must be a reg to infer the flip-flop
);

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;  // MUX selects the parallel load input
        end else begin
            Q <= q_in;  // MUX selects the serial shift input
        end
    end

endmodule