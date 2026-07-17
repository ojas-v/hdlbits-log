module top_module (
    input clk,
    input a,
    output reg [3:0] q
);

    // a synchronous set-to-4 when 'a' is HIGH.
    always @(posedge clk) begin
        if (a) begin
            q <= 4'd4;
        end
        else if (q == 4'd6) begin
            q <= 4'd0;
        end
        else begin
            q <= q + 1'b1;
        end
    end

endmodule