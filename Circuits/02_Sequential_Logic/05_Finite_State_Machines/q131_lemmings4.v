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
    parameter SPLAT      = 3'd6;
    
    reg [2:0] state, next_state;
    reg [4:0] fall_count; // 5-bit counter can hold up to 31 (we only need 20)

    // Next-State Logic (Combinational)
    always @(*) begin
        case (state)
            WALK_LEFT:  next_state = ~ground ? FALL_LEFT  : (dig ? DIG_LEFT  : (bump_left  ? WALK_RIGHT : WALK_LEFT));
            WALK_RIGHT: next_state = ~ground ? FALL_RIGHT : (dig ? DIG_RIGHT : (bump_right ? WALK_LEFT  : WALK_RIGHT));
            
            // Check the timer when the ground returns
            FALL_LEFT:  next_state = ground ? ((fall_count >= 20) ? SPLAT : WALK_LEFT)  : FALL_LEFT;
            FALL_RIGHT: next_state = ground ? ((fall_count >= 20) ? SPLAT : WALK_RIGHT) : FALL_RIGHT;
            
            DIG_LEFT:   next_state = ~ground ? FALL_LEFT  : DIG_LEFT;
            DIG_RIGHT:  next_state = ~ground ? FALL_RIGHT : DIG_RIGHT;
            
            // Dead Lemmings stay dead
            SPLAT:      next_state = SPLAT;
            
            default:    next_state = WALK_LEFT;
        endcase
    end

    // State and Timer Registers (Sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state      <= WALK_LEFT;
            fall_count <= 5'd0;
        end else begin
            state <= next_state;
            
            // Increment ONLY if we are transitioning into or staying in a FALL state
            if (next_state == FALL_LEFT || next_state == FALL_RIGHT) begin
                if (fall_count < 5'd20) begin
                    fall_count <= fall_count + 1; // Cap at 20 to prevent overflow
                end
            end else begin
                fall_count <= 5'd0; // Reset timer instantly when not falling
            end
        end
    end

    // Dead lemmings output 0 for everything, which happens naturally here since 
    assign walk_left  = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah       = (state == FALL_LEFT)  || (state == FALL_RIGHT);
    assign digging    = (state == DIG_LEFT)   || (state == DIG_RIGHT);

endmodule