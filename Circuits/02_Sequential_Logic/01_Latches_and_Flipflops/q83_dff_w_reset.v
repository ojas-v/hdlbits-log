// Create 8 D flip-flops with active high synchronous reset. All DFFs should be triggered by the positive edge of clk.

module top_module (
    input wire clk,
    input wire reset,            // Synchronous active-high reset
    input wire [7:0] d,
    output reg [7:0] q
);

    // The sensitivity list ONLY contains the clock. 
    // This forces the reset to be synchronous.
    always @(posedge clk) begin
        if (reset) begin
            q <= 8'h00;          // Active-high reset: clear all 8 bits to 0
        end else begin
            q <= d;              // Otherwise, capture the data
        end
    end

endmodule