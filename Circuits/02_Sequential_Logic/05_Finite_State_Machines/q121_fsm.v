`default_nettype none

module top_module(
    input wire clk,
    input wire areset,    // Asynchronous reset to OFF
    input wire j,
    input wire k,
    output wire out
);

    // 1. State Encoding
    parameter OFF = 1'b0;
    parameter ON  = 1'b1;

    reg state, next_state;

    // 2. Next-State Logic (Combinational)
    always @(*) begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON:  next_state = k ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    // 3. State Register (Sequential)
    // For asynchronous reset, the reset signal MUST be in the sensitivity list.
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // 4. Output Logic (Combinational)
    // Moore machine: the output strictly depends on the current state.
    assign out = (state == ON);

endmodule