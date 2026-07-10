/*
Consider a finite state machine that is used to control some type of motor. The FSM has inputs x and y, which come from the motor, and produces outputs f and g, which control the motor. There is also a clock input called clk and a reset input called resetn.

The FSM has to work as follows. As long as the reset input is asserted, the FSM stays in a beginning state, called state A. When the reset signal is de-asserted, then after the next clock edge the FSM has to set the output f to 1 for one clock cycle. Then, the FSM has to monitor the x input. When x has produced the values 1, 0, 1 in three successive clock cycles, then g should be set to 1 on the following clock cycle. While maintaining g = 1 the FSM has to monitor the y input. If y has the value 1 within at most two clock cycles, then the FSM should maintain g = 1 permanently (that is, until reset). But if y does not become 1 within two clock cycles, then the FSM should set g = 0 permanently (until reset).

(The original exam question asked for a state diagram only. But here, implement the FSM.)
*/

module top_module (
    input clk,
    input resetn,    // Synchronous active-low reset
    input x,
    input y,
    output f,
    output g
);

    // State Encoding
    parameter A = 4'd0,  // Idle / Reset state
              B = 4'd1,  // Assert f = 1 for one cycle
              C = 4'd2,  // x-detector: got nothing
              D = 4'd3,  // x-detector: got '1'
              E = 4'd4,  // x-detector: got '10'
              F = 4'd5,  // Assert g = 1, monitor y (Cycle 1)
              G = 4'd6,  // Assert g = 1, monitor y (Cycle 2)
              H = 4'd7,  // Permanent g = 1
              I = 4'd8;  // Permanent g = 0

    reg [3:0] state, next_state;

    // Next-State Logic (Purely Combinational)
    always @(*) begin
        case (state)
            A: next_state = B; 
            B: next_state = C; 
            
            // 101 Sequence Detector Phase
            C: next_state = x ? D : C;
            D: next_state = x ? D : E;
            E: next_state = x ? F : C; // If x=1, Move to Phase 3.
            
            // y Timeout Phase (Max 2 cycles)
            F: next_state = y ? H : G; // Cycle 1 check
            G: next_state = y ? H : I; // Cycle 2 check
            
            // Permanent States
            H: next_state = H;
            I: next_state = I;
            
            default: next_state = A;
        endcase
    end

    // State Memory (Synchronous Active-Low Reset)
    always @(posedge clk) begin
        if (~resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Moore Output Logic
    assign f = (state == B);
    assign g = (state == F) || (state == G) || (state == H);

endmodule
