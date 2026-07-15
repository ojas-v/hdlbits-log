module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // waveform represents an even-parity checker (inverted XOR)
    assign q = ~(a ^ b ^ c ^ d);

endmodule
