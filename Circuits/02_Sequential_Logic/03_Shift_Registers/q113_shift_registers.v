`default_nettype none

module top_module (
    input wire clk,
    input wire resetn,   // Synchronous active-low reset
    input wire in,
    output wire out
);

    reg [3:0] q;
    
    // final output is driven by the last flip-flop of the chain 
    assign out = q[0];
    
    always @(posedge clk) begin
        if (!resetn) begin         // Active-low reset check
            q <= 4'b0000;
        end else begin
            // Shift right, in goes at MSB
            q <= {in, q[3:1]};
        end
    end

endmodule