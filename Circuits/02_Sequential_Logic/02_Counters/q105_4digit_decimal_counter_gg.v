module top_module (
    input wire clk,
    input wire reset,         // Synchronous active-high reset
    output wire [3:1] ena,    // The enable cascades
    output reg [15:0] q       // 4 digits, 4 bits each
);

    assign ena[1] = (q[3:0] == 4'd9);
    assign ena[2] = (q[3:0] == 4'd9) && (q[7:4] == 4'd9);
    assign ena[3] = (q[3:0] == 4'd9) && (q[7:4] == 4'd9) && (q[11:8] == 4'd9);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0;
        end else begin
            
            // ONES DIGIT (Always stepping)
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
            end else begin
                q[3:0] <= q[3:0] + 1'b1;
            end

            // TENS DIGIT (Driven by ena[1])
            if (ena[1]) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                end else begin
                    q[7:4] <= q[7:4] + 1'b1;
                end
            end

            // HUNDREDS DIGIT (Driven by ena[2])
            if (ena[2]) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                end else begin
                    q[11:8] <= q[11:8] + 1'b1;
                end
            end

            // THOUSANDS DIGIT (Driven by ena[3])
            if (ena[3]) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end else begin
                    q[15:12] <= q[15:12] + 1'b1;
                end
            end

        end
    end

endmodule