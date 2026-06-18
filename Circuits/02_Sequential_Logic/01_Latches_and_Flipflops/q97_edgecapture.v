module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

    // register to store the previous inputs
    reg [31:0] in_prev;
    
    // sequential logic
    always@(posedge clk) begin
    	// storing the current the current input  to serve as history to future inputs
        in_prev <= in;
        
        // reset logic (sync reset)
        if(reset) begin
            out <= 32'b0;
        end
        
        // out will be one of already one or if any falling edge is detected
        else begin
            out <= out | (~in & in_prev);
        end
    end
endmodule
