/*
This combinational circuit is supposed to recognize 8-bit keyboard scancodes for keys 0 through 9. It should indicate whether one of the 10 cases were recognized (valid), and if so, which key was detected. Fix the bug(s).


*/

module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

    always @(*) begin
        // default values to prevent inferred latches
        out = 4'd0;
        valid = 1'b1; 
        
        case (code)
            8'h45: out = 4'd0;
            8'h16: out = 4'd1;
            8'h1e: out = 4'd2;
            8'h26: out = 4'd3; 
            8'h25: out = 4'd4;
            8'h2e: out = 4'd5;
            8'h36: out = 4'd6;
            8'h3d: out = 4'd7;
            8'h3e: out = 4'd8;
            8'h46: out = 4'd9; 
            default: valid = 1'b0; // If it's not a known code, mark invalid
        endcase
    end

endmodule
