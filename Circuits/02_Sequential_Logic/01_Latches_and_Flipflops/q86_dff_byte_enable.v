/*
Create 16 D flip-flops. It's sometimes useful to only modify parts of a group of flip-flops. The byte-enable inputs control whether each byte of the 16 registers should be written to on that cycle. byteena[1] controls the upper byte d[15:8], while byteena[0] controls the lower byte d[7:0].

resetn is a synchronous, active-low reset.

All DFFs should be triggered by the positive edge of clk.
*/

/*
INCORRECT SOLN: SOLN DIDNT RUN
module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);

    always@(posedge clk) begin
        if(!resetn) begin
            q <= 16'h0000;
        end
        else 
            if(byteena[0]) begin
            	q[7:0] <= d[7:0];
        	end
        	if(byteena[1]) begin
            	q[15:8] <= d[15:8];
        	end
    	end
    end
endmodule

*/

// CORRECT SOLN:

module top_module (
    input wire clk,
    input wire resetn,
    input wire [1:0] byteena,
    input wire [15:0] d,
    output reg [15:0] q   // MUST be a reg
);

    always @(posedge clk) begin
        if (!resetn) begin
            // Active-low reset triggers when resetn is 0
            q <= 16'h0000;
        end else begin
            // Independent IF statements for independent byte control
            if (byteena[0]) begin
                q[7:0] <= d[7:0];
            end
            if (byteena[1]) begin
                q[15:8] <= d[15:8];
            end
        end
    end

endmodule