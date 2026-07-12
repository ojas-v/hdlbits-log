/*
This is the fourth component in a series of five exercises that builds a complex counter out of several smaller circuits. See the final exercise for the overall design.

You may wish to do FSM: Enable shift register and FSM: Sequence recognizer first.

We want to create a timer that:

is started when a particular pattern (1101) is detected,
shifts in 4 more bits to determine the duration to delay,
waits for the counters to finish counting, and
notifies the user and waits for the user to acknowledge the timer.
In this problem, implement just the finite-state machine that controls the timer. The data path (counters and some comparators) are not included here.

The serial data is available on the data input pin. When the pattern 1101 is received, the state machine must then assert output shift_ena for exactly 4 clock cycles.

After that, the state machine asserts its counting output to indicate it is waiting for the counters, and waits until input done_counting is high.

At that point, the state machine must assert done to notify the user the timer has timed out, and waits until input ack is 1 before being reset to look for the next occurrence of the start sequence (1101).

The state machine should reset into a state where it begins searching for the input sequence 1101.

Here is an example of the expected inputs and outputs. The 'x' states may be slightly confusing to read. They indicate that the FSM should not care about that particular input signal in that cycle. For example, once a 1101 pattern is detected, the FSM no longer looks at the data input until it resumes searching after everything else is done.
*/

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    output done,
    input done_counting,
    input ack
);

    // State Encoding
    parameter S_IDLE     = 4'd0,
              S_1        = 4'd1,
              S_11       = 4'd2,
              S_110      = 4'd3,
              S_SHIFT0   = 4'd4,
              S_SHIFT1   = 4'd5,
              S_SHIFT2   = 4'd6,
              S_SHIFT3   = 4'd7,
              S_COUNTING = 4'd8,
              S_DONE     = 4'd9;

    reg [3:0] state, next_state;

    // Next-State Logic
    always @(*) begin
        case (state)
            // Phase 1: Sequence Detector
            S_IDLE:   next_state = data ? S_1 : S_IDLE;
            S_1:      next_state = data ? S_11 : S_IDLE;
            S_11:     next_state = data ? S_11 : S_110; // Overlap catch
            S_110:    next_state = data ? S_SHIFT0 : S_IDLE;

            // Phase 2: 4-Cycle Shift Enable
            S_SHIFT0: next_state = S_SHIFT1; // Unconditional progression
            S_SHIFT1: next_state = S_SHIFT2;
            S_SHIFT2: next_state = S_SHIFT3;
            S_SHIFT3: next_state = S_COUNTING;

            // Phase 3: Wait for Counter
            S_COUNTING: next_state = done_counting ? S_DONE : S_COUNTING;

            // Phase 4: Wait for Acknowledge
            S_DONE:   next_state = ack ? S_IDLE : S_DONE;

            default: next_state = S_IDLE;
        endcase
    end

    // State Memory (Synchronous Reset)
    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Moore Outputs
    assign shift_ena = (state == S_SHIFT0) || (state == S_SHIFT1) || 
                       (state == S_SHIFT2) || (state == S_SHIFT3);
                       
    assign counting  = (state == S_COUNTING);
    assign done      = (state == S_DONE);

endmodule
