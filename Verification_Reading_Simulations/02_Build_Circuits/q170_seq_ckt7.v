module top_module (
    input clk,
    input a,
    output reg q 
);

    // waveform shows q updating only on the rising edge of clk and taking the inverted value of 'a'.
    always @(posedge clk) begin
        q <= ~a;
    end

endmodule
