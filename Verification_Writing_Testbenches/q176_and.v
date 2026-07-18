module top_module();

    // declare signals
    reg [1:0] in;
    wire out;

    // instantiate the given AND gate module
    andgate my_dut (
        .in(in),
        .out(out)
    );

    initial begin
        in = 2'b00; // Time = 0
        
        #10;
        in = 2'b01; // Time = 10
        
        #10;
        in = 2'b10; // Time = 20
        
        #10;
        in = 2'b11; // Time = 30
    end

endmodule
