module top_module ( output reg A, output reg B );

    initial begin
        // Time = 0
        A = 1'b0;
        B = 1'b0;
        
        // Wait 10 units (Time = 10)
        #10 A = 1'b1;
        
        // Wait 5 more units (Time = 15)
        #5  B = 1'b1;
        
        // Wait 5 more units (Time = 20)
        #5  A = 1'b0;
        
        // Wait 20 more units (Time = 40)
        #20 B = 1'b0;
    end

endmodule
