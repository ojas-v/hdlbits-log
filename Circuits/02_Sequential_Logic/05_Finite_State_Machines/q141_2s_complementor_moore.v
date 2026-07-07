`default_nettype none

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    // One-Hot State Encoding
    parameter A = 2'b01; 
    parameter B = 2'b10;
    
    reg [1:0] state, next_state;
    
    // 1. Next-State Logic (One-Hot Boolean Routing)
    always @(*) begin
        next_state[0] = state[0] & ~x;
        next_state[1] = (state[0] & x) | state[1];
    end
    
    // 2. State Memory (Asynchronous Reset)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // 3. Mealy Output Logic
    // Z is 1 if (we are waiting for first 1 AND receive a 1) 
    // OR (we are inverting AND receive a 0)
    assign z = (state == A && x == 1'b1) || (state == B && x == 1'b0);

endmodule