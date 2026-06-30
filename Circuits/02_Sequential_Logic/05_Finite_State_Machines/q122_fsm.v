module top_module(
    input wire clk,
    input wire reset,    // Synchronous reset to OFF
    input wire j,
    input wire k,
    output wire out
);

    // State Encoding
    parameter OFF = 1'b0;
    parameter ON  = 1'b1;

    reg state, next_state;

    // Next-State Logic (Combinational)
    always @(*) begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON:  next_state = k ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    assign out = (state == ON);

endmodule