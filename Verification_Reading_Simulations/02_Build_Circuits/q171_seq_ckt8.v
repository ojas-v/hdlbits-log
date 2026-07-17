module top_module (
    input clock,
    input a,
    output reg p,
    output reg q 
);

    // p behaves as a Level Sensitive
    always @(*) begin
        if (clock) begin
            p = a;
        end
    end

    // q behaves as a Edge Sensitive
    always @(negedge clock) begin
        q <= a; 
    end

endmodule