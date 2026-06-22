module top_module(
    input wire clk,
    input wire load,
    input wire ena,
    input wire [1:0] amount,
    input wire [63:0] data,
    output reg [63:0] q
); 

    always @(posedge clk) begin
        if (load) begin
            q <= data;                  // Synchronous Load
        end else if (ena) begin         // Shift Enable
            
            // Nested multiplexer for shift amounts
            if (amount == 2'b00) begin
                q <= q << 1;            // Logical shift left 1 (pulls in 0)
            end else if (amount == 2'b01) begin
                q <= q << 8;            // Logical shift left 8 (pulls in 8 zeros)
            end else if (amount == 2'b10) begin
                q <= {q[63], q[63:1]};  // Arithmetic shift right 1 (sign extend 1 bit)
            end else if (amount == 2'b11) begin
                q <= {{8{q[63]}}, q[63:8]}; // Arithmetic shift right 8 (sign extend 8 bits)
            end
            
        end
    end

endmodule