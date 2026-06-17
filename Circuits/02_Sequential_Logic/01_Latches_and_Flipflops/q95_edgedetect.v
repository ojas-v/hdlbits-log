module top_module (
    input wire clk,
    input wire [8:1] in,
    output reg [8:1] pedge
);

    // Internal register to store the history of the input signal
    reg [8:1] in_prev;

    always @(posedge clk) begin
        in_prev <= in;
        
        pedge <= in & ~in_prev;
    end

endmodule