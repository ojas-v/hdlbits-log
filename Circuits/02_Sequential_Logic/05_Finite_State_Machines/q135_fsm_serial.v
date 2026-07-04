/*
In many (older) serial communications protocols, each data byte is sent along with a start bit and a stop bit, to help the receiver delimit bytes from the stream of bits. One common scheme is to use one start bit (0), 8 data bits, and 1 stop bit (1). The line is also at logic 1 when nothing is being transmitted (idle).

Design a finite state machine that will identify when bytes have been correctly received when given a stream of bits. It needs to identify the start bit, wait for all 8 data bits, then verify that the stop bit was correct. If the stop bit does not appear when expected, the FSM must wait until it finds a stop bit before attempting to receive the next byte.
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    // state encoding
    parameter IDLE  = 4'd0;
    parameter D1    = 4'd1;
    parameter D2    = 4'd2;
    parameter D3    = 4'd3;
    parameter D4    = 4'd4;
    parameter D5    = 4'd5;
    parameter D6    = 4'd6;
    parameter D7    = 4'd7;
    parameter D8    = 4'd8;
    parameter STOP  = 4'd9;
    parameter DONE  = 4'd10;
    parameter ERROR = 4'd11;
    
    reg [3:0] next_state, state;
    
    // combinational logic
    always @(*) begin
        case(state) // Removed the erroneous 'begin'
            // base condition
            IDLE: next_state = in ? IDLE : D1;
            
            // next state traversal
            D1 : next_state = D2;
            D2 : next_state = D3;
            D3 : next_state = D4;
            D4 : next_state = D5;
            D5 : next_state = D6;
            D6 : next_state = D7;
            D7 : next_state = D8;
            D8 : next_state = STOP;
            
            // framing verification
            // If the stop bit is valid (1), go to DONE. Else, wait in ERROR.
            STOP: next_state = in ? DONE : ERROR;
            
            // contiguous packet handling
            // If in == 0, it is the start bit of the next byte!
            DONE: next_state = in ? IDLE : D1;
            
            // wait until it finds a stop bit (or idle state 1)
            ERROR: next_state = in ? IDLE : ERROR;
            
            // default case
            default: next_state = IDLE;      
            
        endcase
    end
    
    // state reg
    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // combinational output
    assign done = (state == DONE);
    
endmodule