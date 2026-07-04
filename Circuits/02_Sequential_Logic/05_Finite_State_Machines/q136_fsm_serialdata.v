/*
Now that you have a finite state machine that can identify when bytes are correctly received in a serial bitstream, add a datapath that will output the correctly-received data byte. out_byte needs to be valid when done is 1, and is don't-care otherwise.

Note that the serial protocol sends the least significant bit first.
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    
    reg [7:0] out_byte;
    
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
    
    // state memory and data path
    always@(posedge clk) begin
        if(reset) begin
        	state <= IDLE;
            out_byte = 8'd0;
        end
        else begin
        	state <= next_state;
            
            if (state == D1 || state == D2 || state == D3 || state == D4 || 
                state == D5 || state == D6 || state == D7 || state == D8) begin
                
                out_byte <= {in, out_byte[7:1]};
                
            end
        end
    end
    
    // output logic
    assign done = (state == DONE);

endmodule
