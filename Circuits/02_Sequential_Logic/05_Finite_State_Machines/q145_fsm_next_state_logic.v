module top_module (
    input [3:1] y,
    input w,
    output Y2
);

    // Y2 is high ONLY when the NEXT state is C (010) or D (011)
    assign Y2 = (y == 3'b001) ||                // State B always goes to C or D
                (y == 3'b101) ||                // State F always goes to C or D
                (y == 3'b010 && w == 1'b1) ||   // State C goes to D only if w=1
                (y == 3'b100 && w == 1'b1);     // State E goes to D only if w=1

endmodule
