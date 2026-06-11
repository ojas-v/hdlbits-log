module top_module (
    input wire c,
    input wire d,
    output wire [3:0] mux_in
); 

    // Mapping K-map rows directly to MUX inputs using Shannon Expansion
    assign mux_in[0] = c | d;
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = ~d;    
    assign mux_in[3] = c & d; 

endmodule