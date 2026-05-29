/*
Build a priority encoder for 8-bit inputs. Given an 8-bit vector, the output should report the first (least significant) bit in the vector that is 1. Report zero if the input vector has no bits that are high. For example, the input 8'b10010000 should output 3'd4, because bit[4] is first bit that is high.

From the previous exercise (always_case2), there would be 256 cases in the case statement. We can reduce this (down to 9 cases) if the case items in the case statement supported don't-care bits. This is what casez is for: It treats bits that have the value z as don't-care in the comparison.

For example, this would implement the 4-input priority encoder from the previous exercise:

always @(*) begin
    casez (in[3:0])
        4'bzzz1: out = 0;   // in[3:1] can be anything
        4'bzz1z: out = 1;
        4'bz1zz: out = 2;
        4'b1zzz: out = 3;
        default: out = 0;
    endcase
end
A case statement behaves as though each item is checked sequentially (in reality, a big combinational logic function). Notice how there are certain inputs (e.g., 4'b1111) that will match more than one case item. The first match is chosen (so 4'b1111 matches the first item, out = 0, but not any of the later ones).

There is also a similar casex that treats both x and z as don't-care. I don't see much purpose to using it over casez.
The digit ? is a synonym for z. so 2'bz0 is the same as 2'b?0
It may be less error-prone to explicitly specify the priority behaviour rather than rely on the ordering of the case items. For example, the following will still behave the same way if some of the case items were reordered, because any bit pattern can only match at most one case item:

    casez (in[3:0])
        4'bzzz1: ...
        4'bzz10: ...
        4'bz100: ...
        4'b1000: ...
        default: ...
    endcase
*/

`default_nettype none
module top_module (
    input wire [7:0] in,
    output reg [2:0] pos
);

    always @(*) begin
        // casez allows the use of '?' for "Don't Care" bits
        casez (in)
            8'b???????1: pos = 3'd0; // Bit 0 is high. We don't care about bits 7 down to 1.
            8'b??????10: pos = 3'd1; // Bit 1 is high. Bit 0 MUST be low.
            8'b?????100: pos = 3'd2; // Bit 2 is high. Bits 1,0 MUST be low.
            8'b????1000: pos = 3'd3; // Bit 3 is high...
            8'b???10000: pos = 3'd4; 
            8'b??100000: pos = 3'd5;
            8'b?1000000: pos = 3'd6;
            8'b10000000: pos = 3'd7; // Bit 7 is high. All other bits MUST be low.
            
            default: pos = 3'd0;
        endcase
    end

endmodule