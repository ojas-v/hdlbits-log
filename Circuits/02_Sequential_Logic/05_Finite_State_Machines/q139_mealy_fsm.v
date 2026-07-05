
//Implement a Mealy-type finite state machine that recognizes the sequence "101" on an input signal named x. Your FSM should have an output signal, z, that is asserted to logic-1 when the "101" sequence is detected. Your FSM should also have an active-low asynchronous reset. You may only have 3 states in your state machine. Your FSM should recognize overlapping sequences.


module top_module (
    input wire clk,
    input wire aresetn,    // Active-low asynchronous reset
    input wire x,
    output wire z
);

    parameter S0 = 2'b00; // Idle
    parameter S1 = 2'b01; // Got '1'
    parameter S2 = 2'b10; // Got '10'

    reg [1:0] state, next_state;

    always @(*) begin
        case (state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S1 : S2;
            S2: next_state = x ? S1 : S0; // On x=1, overlap routes us back to S1
            default: next_state = S0;
        endcase
    end

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Mealy Output Logic (Combinational)
    // Output depends on BOTH the current state (S2) AND current input (x=1)
    assign z = (state == S2) && (x == 1'b1);

endmodule

