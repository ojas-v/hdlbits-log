// Create 8 D flip-flops. All DFFs should be triggered by the positive edge of clk.

module top_module (
    input wire clk,
    input wire [7:0] d,
    output reg [7:0] q   
);

    // Triggered only on the low-to-high transition of the clock
    always @(posedge clk) begin
        q <= d; // Non-blocking assignment
    end

endmodule