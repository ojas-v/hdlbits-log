// this is very question and without diagram, it cant be explained. so refer the diagram
module top_module (
    input wire clk,
    input wire w, R, E, L,
    output reg Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= R;        
        end else if (E) begin
            Q <= w;        
        end else begin
            Q <= Q;        
        end
    end

endmodule