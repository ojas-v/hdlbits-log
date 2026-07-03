/*
The PS/2 mouse protocol sends messages that are three bytes long. However, within a continuous byte stream, it's not obvious where messages start and end. The only indication is that the first byte of each three byte message always has bit[3]=1 (but bit[3] of the other two bytes may be 1 or 0 depending on data).

We want a finite state machine that will search for message boundaries when given an input byte stream. The algorithm we'll use is to discard bytes until we see one with bit[3]=1. We then assume that this is byte 1 of a message, and signal the receipt of a message once all 3 bytes have been received (done).

The FSM should signal done in the cycle immediately after the third byte of each message was successfully received.
*/

module top_module(
    input wire clk,
    input wire [7:0] in,
    input wire reset,    // Synchronous reset
    output wire done
);

    // 1. State Encoding
    parameter BYTE1 = 2'd0;
    parameter BYTE2 = 2'd1;
    parameter BYTE3 = 2'd2;
    parameter DONE  = 2'd3;

    reg [1:0] state, next_state;

    // Next-State Logic (Combinational)
    always @(*) begin
        case (state)
            // Search for the sync bit
            BYTE1: next_state = in[3] ? BYTE2 : BYTE1;
            
            // Blindly consume payload bytes
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            
            // Assert done, but immediately evaluate the next incoming byte
            DONE:  next_state = in[3] ? BYTE2 : BYTE1;
            
            default: next_state = BYTE1;
        endcase
    end

    // State Register (Synchronous Reset)
    always @(posedge clk) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Output Logic (Combinational)
    assign done = (state == DONE);

endmodule