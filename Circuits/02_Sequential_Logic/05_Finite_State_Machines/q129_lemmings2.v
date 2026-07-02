module top_module(
    input wire clk,
    input wire areset,    // Freshly brainwashed Lemmings walk left.
    input wire bump_left,
    input wire bump_right,
    input wire ground,
    output wire walk_left,
    output wire walk_right,
    output wire aaah
); 

    // State Encoding
    parameter WALK_LEFT  = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL_LEFT  = 2'b10;
    parameter FALL_RIGHT = 2'b11;
    
    reg [1:0] state, next_state;

    // Next-State Logic (Combinational)
    always @(*) begin
        case (state)
            WALK_LEFT:  next_state = ~ground ? FALL_LEFT  : (bump_left  ? WALK_RIGHT : WALK_LEFT);
            WALK_RIGHT: next_state = ~ground ? FALL_RIGHT : (bump_right ? WALK_LEFT  : WALK_RIGHT);
            
            // While falling, bumps are ignored. We only care about the ground.
            FALL_LEFT:  next_state = ground ? WALK_LEFT  : FALL_LEFT;
            FALL_RIGHT: next_state = ground ? WALK_RIGHT : FALL_RIGHT;
            
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
    assign aaah       = (state == FALL_LEFT) || (state == FALL_RIGHT);

endmodule