module top_module ();

    // declare signals
    reg clk;
    reg reset;
    reg t;
    wire q;

    tff my_tff (
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );

    initial begin
        clk = 1'b0;
    end
    
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // reset HIGH to put the T-Flip Flop in a known state (q = 0)
        reset = 1'b1;
        t = 1'b0;
        
        // Wait for one full clock cycle (Time = 10)
        #10;
        
        reset = 1'b0;
        t = 1'b1;
        
    end

endmodule
