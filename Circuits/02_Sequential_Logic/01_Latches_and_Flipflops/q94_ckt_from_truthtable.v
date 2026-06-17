module top_module (
    input clk,
    input j,
    input k,
    output Q); 

    // sequential logic
    always @(posedge clk) begin
        if (j == 0 && k == 0) begin
        	Q <= Q;
        end
        else if (j == 0 && k == 1) begin
        	Q <= 1'b0;
        end
        else if (j == 1 && k == 0) begin
        	Q <= 1'b1;
        end
        else begin
        	Q <= ~Q;
        end
    end
endmodule


/*
CAN ALSO BE IMPLEMENTED USING THIS CODE:

module top_module (
    input wire clk,
    input wire j,
    input wire k,
    output reg Q    
); 

    always @(posedge clk) begin
        // Bundle j and k together to create a 2-bit control signal
        case ({j, k})
            2'b00: Q <= Q;       // Hold
            2'b01: Q <= 1'b0;    // Reset
            2'b10: Q <= 1'b1;    // Set
            2'b11: Q <= ~Q;      // Toggle
        endcase
    end

endmodule
*/