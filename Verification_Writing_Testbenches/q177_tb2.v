module top_module();

    // declare signals
    reg clk;
    reg in;
    reg [2:0] s;
    
    wire out;

    q7 my_dut (
        .clk(clk),
        .in(in),
        .s(s),
        .out(out)
    );

    initial begin
        clk = 1'b0;
    end
    
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Time = 0
        in = 1'b0;
        s  = 3'd2;
        
        // Time = 10
        #10;
        s  = 3'd6;
        
        // Time = 20
        #10;
        in = 1'b1;
        s  = 3'd2;
        
        // Time = 30
        #10;
        in = 1'b0;
        s  = 3'd7;
        
        // Time = 40
        #10;
        in = 1'b1;
        s  = 3'd0;
        
        // Wait 30 time units from the last change at t=40
        #30;
        in = 1'b0;
    end

endmodule