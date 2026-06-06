/*

q59. You are given a four-bit input vector in[3:0]. We want to know some relationships between each bit and its neighbour:
out_both: Each bit of this output vector should indicate whether both the corresponding input bit and its neighbour to the left (higher index) are '1'. For example, out_both[2] should indicate if in[2] and in[3] are both 1. Since in[3] has no neighbour to the left, the answer is obvious so we don't need to know out_both[3].
out_any: Each bit of this output vector should indicate whether any of the corresponding input bit and its neighbour to the right are '1'. For example, out_any[2] should indicate if either in[2] or in[1] are 1. Since in[0] has no neighbour to the right, the answer is obvious so we don't need to know out_any[0].
out_different: Each bit of this output vector should indicate whether the corresponding input bit is different from its neighbour to the left. For example, out_different[2] should indicate if in[2] is different from in[3]. For this part, treat the vector as wrapping around, so in[3]'s neighbour to the left is in[0].

==========================================================================================================
APPROACH 1: 
`default_nettype none
module top_module( 
    input wire [3:0] in,
    output reg [2:0] out_both,      // Must be reg because it's in an always block
    output reg [3:1] out_any,       // Must be reg
    output reg [3:0] out_different  // Must be reg
);

    integer i;

    always @(*) begin
        
        // 1. out_both runs from bit 0 to 2
        for (i = 0; i < 3; i = i + 1) begin
            out_both[i] = in[i] & in[i+1];
        end

        // 2. out_any runs from bit 1 to 3
        for (i = 1; i < 4; i = i + 1) begin
            out_any[i] = in[i] | in[i-1];
        end

        // 3. out_different runs from 0 to 3, with wrap-around logic
        for (i = 0; i < 4; i = i + 1) begin
            if (i == 3)
                out_different[i] = in[3] ^ in[0]; // Wrap around to the beginning
            else
                out_different[i] = in[i] ^ in[i+1];
        end
        
    end

endmodule
==================================================================================================
*/

module top_module( 
    input wire [3:0] in,
    output wire [2:0] out_both,
    output wire [3:1] out_any,
    output wire [3:0] out_different 
);

    // 3 parallel AND gates
    assign out_both = in[2:0] & in[3:1];
    
    // 3 parallel OR gates
    assign out_any = in[3:1] | in[2:0];
    
    // 4 parallel XOR gates, using concatenation { } for the wrap-around routing
    assign out_different = in[3:0] ^ {in[0], in[3:1]};

endmodule