module top_module (
    input wire [3:0] SW,
    input wire [3:0] KEY,
    output wire [3:0] LEDR
); 

    // MUX3: MSB, the serial input comes from external pin KEY[3]
    MUXDFF dff3 (
        .clk(KEY[0]),
        .w(KEY[3]),
        .R(SW[3]),
        .E(KEY[1]),
        .L(KEY[2]),
        .q(LEDR[3])
    );

    // MUX2: the serial input comes from prev o/p pin LEDR[3]
    MUXDFF dff2 (
        .clk(KEY[0]),
        .w(LEDR[3]),
        .R(SW[2]),
        .E(KEY[1]),
        .L(KEY[2]),
        .q(LEDR[2])
    );

    // MUX1: the serial input comes from prev o/p pin LEDR[2]
    MUXDFF dff1 (
        .clk(KEY[0]),
        .w(LEDR[2]),
        .R(SW[1]),
        .E(KEY[1]),
        .L(KEY[2]),
        .q(LEDR[1])
    );

    // MUX0: LSB, the serial input comes from prev o/p pin LEDR[1]
    MUXDFF dff0 (
        .clk(KEY[0]),
        .w(LEDR[1]),
        .R(SW[0]),
        .E(KEY[1]),
        .L(KEY[2]),
        .q(LEDR[0])  
    );

endmodule


// Sub-module definition
module MUXDFF (
    input wire clk,
    input wire w,
    input wire R,
    input wire E,
    input wire L,
    output reg q      
);

    always @(posedge clk) begin
        // Synchronous load
        if (L) begin
            q <= R;
        end
        // Shift enable
        else if (E) begin
            q <= w;
        end
        // If neither L nor E is high, it inherently holds its state (q <= q)
    end

endmodule