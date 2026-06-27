module top_module (
    input wire clk,
    input wire areset,    // Asynchronous reset to state B
    input wire in,
    output wire out
);

    // State Encoding
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    reg state, next_state;

    // Next-State Logic (Combinational)
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;
        endcase
    end

    // State Register (Sequential)
    always @(posedge clk or posedge areset) begin
        // Asynchronous reset overrides the clock
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output Logic (Combinational)
    // Moore machine: output depends purely on the current state.
    assign out = (state == B);

endmodule