/*
We want to add parity checking to the serial receiver. Parity checking adds one extra bit after each data byte. We will use odd parity, where the number of 1s in the 9 bits received must be odd. For example, 101001011 satisfies odd parity (there are 5 1s), but 001001011 does not.

Change your FSM and datapath to perform odd parity checking. Assert the done signal only if a byte is correctly received and its parity check passes. Like the serial receiver FSM, this FSM needs to identify the start bit, wait for all 9 (data and parity) bits, then verify that the stop bit was correct. If the stop bit does not appear when expected, the FSM must wait until it finds a stop bit before attempting to receive the next byte.

You are provided with the following module that can be used to calculate the parity of the input stream (It's a TFF with reset). The intended use is that it should be given the input bit stream, and reset at appropriate times so it counts the number of 1 bits in each byte.

module parity (
    input clk,
    input reset,
    input in,
    output reg odd);

    always @(posedge clk)
        if (reset) odd <= 0;
        else if (in) odd <= ~odd;

endmodule

Note that the serial protocol sends the least significant bit first, and the parity bit after the 8 data bits.
*/

module parity (
    input clk,
    input reset,
    input in,
    output reg odd
);

    always @(posedge clk)
        if (reset)
            odd <= 0;
        else if (in)
            odd <= ~odd;

endmodule

module top_module(
    input wire clk,
    input wire in,
    input wire reset,
    output reg [7:0] out_byte,
    output wire done
); 

    // State Encoding
    parameter IDLE = 4'd0;
    parameter D1 = 4'd1;
    parameter D2 = 4'd2;
    parameter D3 = 4'd3;
    parameter D4 = 4'd4;
    parameter D5 = 4'd5;
    parameter D6 = 4'd6;
    parameter D7 = 4'd7;
    parameter D8 = 4'd8;
    parameter PARITY = 4'd9;   
    parameter STOP = 4'd10;
    parameter DONE = 4'd11;
    parameter ERROR = 4'd12;
    
    reg [3:0] state, next_state;
    
    // Parity Module Wires
    wire odd;
    wire parity_rst;
    
    //  Reset Logic
    // Reset the running tally whenever we are not actively receiving a payload
    assign parity_rst = reset || (state == IDLE) || (state == DONE) || (state == ERROR);
    
    // Instantiate the Parity Module
    parity u_parity (
        .clk(clk),
        .reset(parity_rst),
        .in(in),
        .odd(odd)
    );

    // Combinational Next-State Logic
    always @(*) begin
        case(state)
            IDLE:   next_state = in ? IDLE : D1;
            
            D1: next_state = D2;
            D2: next_state = D3;
            D3: next_state = D4;
            D4: next_state = D5;
            D5: next_state = D6;
            D6: next_state = D7;
            D7: next_state = D8;
            D8: next_state = PARITY; 
            PARITY: next_state = STOP;   
            
            // Evaluate both the stop bit AND the parity output
            STOP: begin
                if (in == 1'b0) 
                    next_state = ERROR;                 // Framing error (missing stop bit)
                else if (odd == 1'b1)
                    next_state = DONE;                  // Success
                else
                    next_state = IDLE;                  // Parity error (drop the packet)
            end
            
            DONE: next_state = in ? IDLE : D1;        // Handle contiguous packets
            ERROR: next_state = in ? IDLE : ERROR;     // Wait for line to go idle
            default: next_state = IDLE;      
        endcase
    end
    
    // Sequential Logic (State Memory & Datapath)
    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
            out_byte <= 8'd0;
        end
        else begin
            state <= next_state;
            
            // STRICTLY shift only during data states. 
            if (state >= D1 && state <= D8) begin
                out_byte <= {in, out_byte[7:1]};
            end
        end
    end
    
    // Output Logic
    assign done = (state == DONE);

endmodule
