module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    always@(posedge clk) begin
        if(reset) begin
            q <= 32'h1;
        end
        else begin
            /*
            If we lay out the 32 bits in binary, setting only bits 31, 21, 1, and 0 to 1:
			1000 0000 0010 0000 0000 0000 0000 0011

			Converting this binary string to hexadecimal gives us our mask: 32'h80200003.
			*/
            if(q[0]) begin
                // shift right then xor w mask
                q <= (q >> 1) ^ 32'h80200003;
            end
            else begin
                // right shift as usual
                q <= (q >> 1);
            end
        end
    end

endmodule
