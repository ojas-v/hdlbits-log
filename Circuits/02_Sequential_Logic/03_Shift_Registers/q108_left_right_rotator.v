/*
Build a 100-bit left/right rotator, with synchronous load and left/right enable. A rotator shifts-in the shifted-out bit from the other end of the register, unlike a shifter that discards the shifted-out bit and shifts in a zero. If enabled, a rotator rotates the bits around and does not modify/discard them.

load: Loads shift register with data[99:0] instead of rotating.
ena[1:0]: Chooses whether and which direction to rotate.
2'b01 rotates right by one bit
2'b10 rotates left by one bit
2'b00 and 2'b11 do not rotate.
q: The contents of the rotator.
*/

/*
THIS SOLN WORKS AS WELL
module top_module(
    input wire clk,
    input wire load,
    input wire ena,
    input wire [1:0] amount,
    input wire [63:0] data,
    output reg [63:0] q
); 

    always @(posedge clk) begin
        if (load) begin
            q <= data;                  // Priority 1: Synchronous Load
        end else if (ena) begin         // Priority 2: Shift Enable
            
            // Nested multiplexer for shift amounts
            if (amount == 2'b00) begin
                q <= q << 1;            // Logical shift left 1 (pulls in 0)
            end else if (amount == 2'b01) begin
                q <= q << 8;            // Logical shift left 8 (pulls in 8 zeros)
            end else if (amount == 2'b10) begin
                q <= {q[63], q[63:1]};  // Arithmetic shift right 1 (sign extend 1 bit)
            end else if (amount == 2'b11) begin
                q <= {{8{q[63]}}, q[63:8]}; // Arithmetic shift right 8 (sign extend 8 bits)
            end
            
        end
    end

endmodule
*/

module top_module(
    input wire clk,
    input wire load,
    input wire [1:0] ena,
    input wire [99:0] data,
    output reg [99:0] q
); 

    always @(posedge clk) begin
        if (load) begin
            q <= data;                 // Synchronous Load
        end else if (ena == 2'b01) begin
            q <= {q[0], q[99:1]};      // Rotate Right
        end else if (ena == 2'b10) begin
            q <= {q[98:0], q[99]};     // Rotate Left
        end
        // If ena is 2'b00 or 2'b11, it falls through and inherently holds its state (q <= q).
    end

endmodule