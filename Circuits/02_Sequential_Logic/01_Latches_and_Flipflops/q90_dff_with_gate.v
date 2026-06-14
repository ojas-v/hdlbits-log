module top_module (
    input clk,
    input in, 
    output out);

    // declare wire
    wire w1;
    
    // wire functionality
    assign w1 = in ^ out;
    
    always @(posedge clk) begin
        out <= w1;
    end
            
endmodule
