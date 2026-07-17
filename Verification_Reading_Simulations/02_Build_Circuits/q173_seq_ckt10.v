module top_module (
    input clk,
    input a,
    input b,
    output q,
    output reg state
);

    // q is combinational Sum
    assign q = a ^ b ^ state;

    // state is sequential Carry-out (which becomes Carry-in for next clock)
    always @(posedge clk) begin
        if (state) begin
            state <= a | b;
        end else begin
            state <= a & b;
        end
    end

endmodule
