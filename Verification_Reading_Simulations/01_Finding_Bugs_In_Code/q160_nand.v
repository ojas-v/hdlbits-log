/*
This three-input NAND gate doesn't work. Fix the bug(s).

You must use the provided 5-input AND gate:

module andgate ( output out, input a, input b, input c, input d, input e );

module top_module (input a, input b, input c, output out);//

    andgate inst1 ( a, b, c, out );

endmodule

*/
module top_module (
    input a, 
    input b, 
    input c, 
    output out
);
    wire and_out;
    
    andgate inst1(
        .out(and_out),
        .a(a),
        .b(b),
        .c(c),
        .d(1'b1),
        .e(1'b1)
    );
    
    // Invert the AND to get NAND
    assign out = ~and_out;

endmodule
