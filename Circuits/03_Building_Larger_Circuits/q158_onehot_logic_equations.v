/*
Derive next-state logic equations and output logic equations by inspection assuming the following one-hot encoding is used: (S, S1, S11, S110, B0, B1, B2, B3, Count, Wait) = (10'b0000000001, 10'b0000000010, 10'b0000000100, ... , 10'b1000000000)

Derive state transition and output logic equations by inspection assuming a one-hot encoding. Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. (The testbench will test with non-one hot inputs to make sure you're not trying to do something more complicated. See fsm3onehot for a description of what is meant by deriving logic equations "by inspection" for one-hot state machines.)

Write code that generates the following equations:

B3_next -- next-state logic for state B3
S_next
S1_next
Count_next
Wait_next
done -- output logic
counting
shift_ena
*/

module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
);

    // Next State Logic
    assign B3_next    = state[6];
    assign S_next     = (state[0] & ~d) | (state[1] & ~d) | (state[3] & ~d) | (state[9] & ack);
    assign S1_next    = state[0] & d;
    assign Count_next = state[7] | (state[8] & ~done_counting);
    assign Wait_next  = (state[8] & done_counting) | (state[9] & ~ack);

    // Output Logic
    assign done       = state[9];
    assign counting   = state[8];
    assign shift_ena  = state[4] | state[5] | state[6] | state[7];

endmodule
