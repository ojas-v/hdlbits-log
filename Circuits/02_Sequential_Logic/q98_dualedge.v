module top_module (
    input clk,
    input d,
    output q
);

    // creating two internal registers to store data
    reg p_reg;
    reg n_reg;
    
    // positive capture
    always@(posedge clk) begin
        p_reg <= (d ^ n_reg);
    end
    
    // negative capture
    always@(negedge clk) begin
    	n_reg <= (d ^ p_reg);
    end
    
    // final output
    assign q = p_reg ^ n_reg;
endmodule
