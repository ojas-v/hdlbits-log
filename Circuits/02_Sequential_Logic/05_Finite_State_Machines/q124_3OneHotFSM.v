/*
The following is the state transition table for a Moore state machine with one input, one output, and four states. Use the following one-hot state encoding: A=4'b0001, B=4'b0010, C=4'b0100, D=4'b1000.

Derive state transition and output logic equations by inspection assuming a one-hot encoding. Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. (The testbench will test with non-one hot inputs to make sure you're not trying to do something more complicated).
*/

module top_module(
    input wire in,
    input wire [3:0] state,
    output wire [3:0] next_state,
    output wire out
);

    // Next-State Logic 
    assign next_state[0] = (state[0] & ~in) | (state[2] & ~in);
    assign next_state[1] = (state[0] & in)  | (state[1] & in) | (state[3] & in);
    assign next_state[2] = (state[1] & ~in) | (state[3] & ~in);
    assign next_state[3] = (state[2] & in);

    // Output Logic
    assign out = state[3];

endmodule