/*
Consider the state diagram shown below.

Write complete Verilog code that represents this FSM. Use separate always blocks for the state table and the state flip-flops, as done in lectures. Describe the FSM output, which is called z, using either continuous assignment statement(s) or an always block (at your discretion). Assign any state codes that you wish to use.
*/

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    // State Encoding
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;
    
	reg [2:0] state, next_state;

    // next state logic
    always @(*) begin
        case (state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
            default: next_state = A; // Safety catch-all
        endcase
    end
    
    // State Memory (Strictly Synchronous Reset)
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Moore Output Logic 
    assign z = (state == E) || (state == F);
endmodule
