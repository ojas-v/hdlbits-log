module top_module(
    input wire clk,
    input wire areset,    // Freshly brainwashed Lemmings walk left.
    input wire bump_left,
    input wire bump_right,
    input wire ground,
    input wire dig,
    output wire walk_left,
    output wire walk_right,
    output wire aaah,
    output wire digging
); 

    // State Encoding
    parameter WALK_LEFT  = 3'd0;
    parameter WALK_RIGHT = 3'd1;
    parameter FALL_LEFT  = 3'd2;
    parameter FALL_RIGHT = 3'd3;
    parameter DIG_LEFT   = 3'd4;
    parameter DIG_RIGHT  = 3'd5;
    
    reg [2:0] state, next_state;

    // Next-State Logic (Combinational)
    always @(*) begin
        case (state)
            // Priority: Fall -> Dig -> Bump
            WALK_LEFT:  next_state = ~ground ? FALL_LEFT  : (dig ? DIG_LEFT  : (bump_left  ? WALK_RIGHT : WALK_LEFT));
            WALK_RIGHT: next_state = ~ground ? FALL_RIGHT : (dig ? DIG_RIGHT : (bump_right ? WALK_LEFT  : WALK_RIGHT));
            
            // Falling ignores everything except the ground returning
            FALL_LEFT:  next_state = ground ? WALK_LEFT  : FALL_LEFT;
            FALL_RIGHT: next_state = ground ? WALK_RIGHT : FALL_RIGHT;
            
            // Digging ignores everything until the ground disappears
            DIG_LEFT:   next_state = ~ground ? FALL_LEFT  : DIG_LEFT;
            DIG_RIGHT:  next_state = ~ground ? FALL_RIGHT : DIG_RIGHT;
            
            default: next_state = WALK_LEFT;
        endcase
    end

    // State Register (Sequential - Asynchronous Reset)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output Logic (Combinational)
    assign walk_left  = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah       = (state == FALL_LEFT)  || (state == FALL_RIGHT);
    assign digging    = (state == DIG_LEFT)   || (state == DIG_RIGHT);

endmodule