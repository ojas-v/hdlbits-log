module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 

    always@(posedge clk) begin
        if(load) begin
            q <= data;
        end
        else begin
            // next generation is the xor of the left neighbours and right neighbours
            q <= {1'b0, q[511:1]} ^ {q[510:0], 1'b0};
        end
    end
endmodule
