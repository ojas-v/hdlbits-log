/*
Now that you have a state machine that will identify three-byte messages in a PS/2 byte stream, add a datapath that will also output the 24-bit (3 byte) message whenever a packet is received (out_bytes[23:16] is the first byte, out_bytes[15:8] is the second byte, etc.).

out_bytes needs to be valid whenever the done signal is asserted. You may output anything at other times (i.e., don't-care).

*/

module top_module(
    input wire clk,
    input wire [7:0] in,
    input wire reset,    // Synchronous reset
    output reg [23:0] out_bytes,
    output wire done
);

    // State Encoding
    parameter BYTE1 = 2'd0;
    parameter BYTE2 = 2'd1;
    parameter BYTE3 = 2'd2;
    parameter DONE  = 2'd3;

    reg [1:0] state, next_state;

    // Next-State Logic (Combinational Control Path)
    always @(*) begin
        case (state)
            BYTE1: next_state = in[3] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = in[3] ? BYTE2 : BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // State Memory & Datapath (Sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= BYTE1;
            out_bytes <= 24'b0; 
        end else begin
            state <= next_state;
            
            // The Datapath: An unconditional 24-bit left-shift register
            out_bytes <= {out_bytes[15:0], in};
        end
    end

    // Output Logic
    assign done = (state == DONE);

endmodule
