
/*
You are provided a module with the following declaration:

module dut ( input clk ) ;
Write a testbench that creates one instance of module dut (with any instance name), and create a clock signal to drive the module's clk input. The clock has a period of 10 ps. The clock should be initialized to zero with its first transition being 0 to 1.
*/
module top_module ( );
    
    reg clk;
    
    // initialize the clock to 0 at time = 0
    initial begin
        clk = 1'b0;
    end
    
    // toggle the clock every 5 time units (Period = 10)
    always begin
        #5 clk = ~clk;
    end
    
    // instantiate the Device Under Test (DUT) and connect our clock
    dut my_dut (
        .clk(clk)
    );

endmodule

