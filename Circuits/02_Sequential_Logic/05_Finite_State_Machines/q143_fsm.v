/*
Given the state-assigned table shown below, implement the finite-state machine. Reset should reset the FSM to state 000.

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
    input reset,   // Synchronous reset
    input x,
    output z
);

    // State Encoding
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    reg [2:0] state, next_state;

    // Next-State Logic (Combinational)
    always @(*) begin
        case (state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S4 : S1;
            S2: next_state = x ? S1 : S2;
            S3: next_state = x ? S2 : S1;
            S4: next_state = x ? S4 : S3;
            default: next_state = S0; // Catch-all for illegal states
        endcase
    end

    // State Memory (Strictly Synchronous Reset)
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Moore Output Logic
    assign z = (state == S3) || (state == S4);

endmodule
