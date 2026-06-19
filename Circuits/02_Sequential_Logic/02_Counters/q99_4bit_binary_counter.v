module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);

    always @(posedge clk) begin
        if(reset)begin
            q <= 4'b0000;
        end
        else begin
        	// q += 1'b1; this is a blocking assignment, instead use the one below
            q <= q + 1'b1;  
        end
    end
endmodule
