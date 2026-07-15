module top_module (
    input a,
    input b,
    input c,
    input d,
    output q 
);

    // waveform shows an AND of two OR groups
    assign q = (a | b) & (c | d);

endmodule
