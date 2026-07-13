/*
We want to create a timer with one input that:

is started when a particular input pattern (1101) is detected,
shifts in 4 more bits to determine the duration to delay,
waits for the counters to finish counting, and
notifies the user and waits for the user to acknowledge the timer.
The serial data is available on the data input pin. When the pattern 1101 is received, the circuit must then shift in the next 4 bits, most-significant-bit first. These 4 bits determine the duration of the timer delay. I'll refer to this as the delay[3:0].

After that, the state machine asserts its counting output to indicate it is counting. The state machine must count for exactly (delay[3:0] + 1) * 1000 clock cycles. e.g., delay=0 means count 1000 cycles, and delay=5 means count 6000 cycles. Also output the current remaining time. This should be equal to delay for 1000 cycles, then delay-1 for 1000 cycles, and so on until it is 0 for 1000 cycles. When the circuit isn't counting, the count[3:0] output is don't-care (whatever value is convenient for you to implement).

At that point, the circuit must assert done to notify the user the timer has timed out, and waits until input ack is 1 before being reset to look for the next occurrence of the start sequence (1101).

The circuit should reset into a state where it begins searching for the input sequence 1101.

Here is an example of the expected inputs and outputs. The 'x' states may be slightly confusing to read. They indicate that the FSM should not care about that particular input signal in that cycle. For example, once the 1101 and delay[3:0] have been read, the circuit no longer looks at the data input until it resumes searching after everything else is done. In this example, the circuit counts for 2000 clock cycles because the delay[3:0] value was 4'b0001. The last few cycles starts another count with delay[3:0] = 4'b1110, which will count for 15000 cycles.
*/

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack 
);

    // FSM State Definitions
    parameter S_IDLE = 4'd0, S_1 = 4'd1, S_11 = 4'd2, S_110 = 4'd3;
    parameter S_SHIFT0 = 4'd4, S_SHIFT1 = 4'd5, S_SHIFT2 = 4'd6, S_SHIFT3 = 4'd7; 
    parameter S_COUNTING = 4'd8, S_WAIT_ACK = 4'd9;
    
    reg [3:0] state, next_state;
    reg [3:0] delay_val;
    reg [9:0] counter_1k;
    
    // Internal Control Signals (Connecting FSM to Datapath)
    wire shift_ena = (state == S_SHIFT0) || (state == S_SHIFT1) || 
                     (state == S_SHIFT2) || (state == S_SHIFT3);
    wire count_ena = (state == S_COUNTING);
    wire tick_1k = (counter_1k == 10'd999);
    wire done_counting = (delay_val == 4'd0) && tick_1k;

    // Next State Logic (The Brain)
    always @(*) begin
        case(state)
            S_IDLE:     next_state = data ? S_1 : S_IDLE;
            S_1:        next_state = data ? S_11 : S_IDLE;
            S_11:       next_state = data ? S_11 : S_110;
            S_110:      next_state = data ? S_SHIFT0 : S_IDLE;
            S_SHIFT0:   next_state = S_SHIFT1; 
            S_SHIFT1:   next_state = S_SHIFT2;
            S_SHIFT2:   next_state = S_SHIFT3;
            S_SHIFT3:   next_state = S_COUNTING;
            S_COUNTING: next_state = done_counting ? S_WAIT_ACK : S_COUNTING;
            S_WAIT_ACK: next_state = ack ? S_IDLE : S_WAIT_ACK;
            default:    next_state = S_IDLE;
        endcase
    end
    
    // FSM Memory
    always @(posedge clk) begin
        if (reset) state <= S_IDLE;
        else       state <= next_state;
    end
    
    // Datapath: 1000-Cycle Base Counter
    always @(posedge clk) begin
        if (reset) begin
            counter_1k <= 10'd0;
        end else if (count_ena) begin
            if (tick_1k) counter_1k <= 10'd0;
            else         counter_1k <= counter_1k + 10'd1;
        end else begin
            // Clear the counter when not actively in the COUNTING state
            counter_1k <= 10'd0;
        end
    end
    
    // Datapath: 4-bit Delay Register (Shift / Down-Count)
    always @(posedge clk) begin
        if (reset) begin
            delay_val <= 4'd0;
        end else if (shift_ena) begin
            // Shift left, MSB arrives first into LSB slot
            delay_val <= {delay_val[2:0], data}; 
        end else if (count_ena && tick_1k) begin
            // Decrement every 1000 cycles
            delay_val <= delay_val - 4'd1;
        end
    end
    
    // Continuous Outputs
    assign count = delay_val;
    assign counting = count_ena;
    assign done = (state == S_WAIT_ACK);
    
endmodule