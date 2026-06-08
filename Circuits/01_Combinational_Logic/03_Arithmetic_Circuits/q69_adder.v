module top_module (
    input wire [3:0] x,
    input wire [3:0] y, 
    output wire [4:0] sum
);

    // The entire 4-bit ripple-carry adder in one line of code
    assign sum = x + y;

endmodule