module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Y2 represents the next state being B.
    // The only path into B is from A (y[1]) when w=0.
    assign Y2 = y[1] & ~w;

    // Y4 represents the next state being D.
    // The paths into D are from B, C, E, and F, all requiring w=1.
    assign Y4 = (y[2] | y[3] | y[5] | y[6]) & w;

endmodule
