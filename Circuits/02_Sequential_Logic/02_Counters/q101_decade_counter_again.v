// Make a decade counter that counts 1 through 10, inclusive. The reset input is synchronous, and should reset the counter to 1.

module top_module (
    input wire clk,
    input wire reset,        // Synchronous active-high reset
    output reg [3:0] q       
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'd1;        
        end else if (q == 4'd10) begin
            q <= 4'd1;        
        end else begin
            q <= q + 1'b1;       
        end
    end

endmodule
