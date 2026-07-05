/*
Synchronous HDLC framing involves decoding a continuous bit stream of data to look for bit patterns that indicate the beginning and end of frames (packets). Seeing exactly 6 consecutive 1s (i.e., 01111110) is a "flag" that indicate frame boundaries. To avoid the data stream from accidentally containing "flags", the sender inserts a zero after every 5 consecutive 1s which the receiver must detect and discard. We also need to signal an error if there are 7 or more consecutive 1s.

Create a finite state machine to recognize these three sequences:

0111110: Signal a bit needs to be discarded (disc).
01111110: Flag the beginning/end of a frame (flag).
01111111...: Error (7 or more 1s) (err).
When the FSM is reset, it should be in a state that behaves as though the previous input were 0.

*/

module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    // state encoding
    parameter NONE = 4'd0;
    parameter ONE = 4'd1;
    parameter TWO = 4'd2;
    parameter THREE = 4'd3;
    parameter FOUR = 4'd4;
    parameter FIVE = 4'd5;
    parameter SIX = 4'd6;
    parameter ERROR = 4'd7;
    parameter DISC = 4'd8;
    parameter FLAG = 4'd9;
    
    reg[3:0] state, next_state;
    
    always@(*) begin
        case(state)
        	// counting chain
            NONE: next_state = in ? ONE : NONE;
            ONE: next_state = in ? TWO : NONE;
            TWO: next_state = in ? THREE : NONE;
            THREE: next_state = in ? FOUR : NONE;
            FOUR: next_state = in ? FIVE : NONE;
            
            // branching states
            FIVE: next_state = in ? SIX : DISC;
            SIX: next_state = in ? ERROR : FLAG;
            
            // action states
            ERROR: next_state = in ? ERROR : NONE;
            FLAG: next_state = in ? ONE : NONE;
            DISC: next_state = in ? ONE : NONE;
            
            default: next_state = NONE;
        endcase
    end
    
    // state register
    always@(posedge clk) begin
        if(reset) begin
        	state <= NONE;
        end
        else begin
        	state <= next_state;
        end
    end
    
    // final output(moore)
    assign disc = (state == DISC);
    assign flag = (state == FLAG);
    assign err = (state == ERROR);
endmodule
