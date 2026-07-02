module top_module(
    input wire clk,
    input wire areset,    // Freshly brainwashed Lemmings walk left.
    input wire bump_left,
    input wire bump_right,
    output wire walk_left,
    output wire walk_right
); 

    // State Encoding
    parameter LEFT  = 1'b0;
    parameter RIGHT = 1'b1;
    
    reg state, next_state;

    // Next-State Logic (Combinational)
    always @(*) begin
        case (state)
            LEFT:  next_state = bump_left  ? RIGHT : LEFT;
            RIGHT: next_state = bump_right ? LEFT  : RIGHT;
            default: next_state = LEFT;
        endcase
    end

    // State Register (Sequential - Asynchronous Reset)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output Logic (Combinational)
    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule