// synthesis verilog_input_version verilog_2001
module top_module(
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);

    // this is for combinational block
	assign out_assign = a & b;
    
    // this is procedural (using assign)
    always @(*) begin
    	out_alwaysblock = a & b;
    
    end
endmodule
