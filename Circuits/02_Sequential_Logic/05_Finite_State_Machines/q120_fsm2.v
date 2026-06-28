module top_module (
    input wire clk,
    input wire reset,    // Synchronous reset to state B
    input wire in,
    output wire out
);

    // State Encoding
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    reg state, next_state;

    // Next-State Logic (Combinational - NEVER clocked!)
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;
        endcase
    end

    // State Register (Sequential - Synchronous Reset)
    always @(posedge clk) begin // Notice: 'reset' is gone from here
        // Because reset is evaluated inside the clocked block, 
        // it is strictly synchronous.
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output Logic (Combinational)
    assign out = (state == B);

endmodule