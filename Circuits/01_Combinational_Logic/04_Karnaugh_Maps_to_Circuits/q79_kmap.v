module top_module (
    input wire [4:1] x,
    output wire f
);

    // 3-group Sum of Products simplification
    assign f = (~x[4] & ~x[2]) | (x[3] & ~x[1]) | (x[4] & x[3] & x[2]);

endmodule