/* remove bugs
*/
module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output [7:0] out  
);

    // sel = 1 outputs 'a', sel = 0 outputs 'b'
    assign out = sel ? a : b;

endmodule
