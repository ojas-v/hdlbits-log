module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    parameter A = 1'b0;
    parameter B = 1'b1;
    
    reg state, next_state;
    
    // Internal Datapath Registers
    reg [1:0] cycle;
    reg [1:0] ones;
    reg z_reg;
    
    // Next-State Logic (Control Path)
    always @(*) begin
        case(state)
            A: next_state = s ? B : A;
            B: next_state = B; // Once in B, stay in B indefinitely
            default: next_state = A; // safe default for synthesis
        endcase
    end
    
    // Sequential Logic (State Memory & Datapath Updates)
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            cycle <= 2'd0;
            ones  <= 2'd0;
            z_reg <= 1'b0;
        end else begin
            state <= next_state;
            
            if (state == A) begin
                if (s) begin
                    // Initialize datapath for the jump to State B
                    cycle <= 2'd0;
                    ones  <= 2'd0;
                    z_reg <= 1'b0;
                end else begin
                    z_reg <= 1'b0;
                end
            end 
            else if (state == B) begin
                // A) Manage the 3-cycle block timer
                if (cycle == 2'd2)
                    cycle <= 2'd0;
                else
                    cycle <= cycle + 2'd1;
                
                // B) Accumulate the '1's
                if (cycle == 2'd0)
                    ones <= {1'b0, w};    // Start fresh for the new block
                else
                    ones <= ones + {1'b0, w};     // Add current bit to the running total
                    
                // C) Evaluate the block on its final tick
                if (cycle == 2'd2) begin
                    if (ones + {1'b0, w} == 2'd2) // Add the final incoming bit to the sum
                        z_reg <= 1'b1;
                    else
                        z_reg <= 1'b0;
                end else begin
                    z_reg <= 1'b0;        // Ensure z is only a 1-cycle pulse
                end
            end
        end
    end
    
    // Output Assignment
    assign z = z_reg;

endmodule

