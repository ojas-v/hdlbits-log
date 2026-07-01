module top_module (
    input wire clk,
    input wire reset,
    input wire [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State Encoding
    parameter BELOW_S1 = 3'd0;
    parameter S1_UP    = 3'd1;
    parameter S1_DOWN  = 3'd2;
    parameter S2_UP    = 3'd3;
    parameter S2_DOWN  = 3'd4;
    parameter ABOVE_S3 = 3'd5;

    reg [2:0] state, next_state;

    // Next-State Logic (Combinational)
    always @(*) begin
        case (state)
            BELOW_S1: next_state = s[1] ? S1_UP : BELOW_S1;
            
            S1_UP:    next_state = s[2] ? S2_UP : (s[1] ? S1_UP : BELOW_S1);
            S1_DOWN:  next_state = s[2] ? S2_UP : (s[1] ? S1_DOWN : BELOW_S1);
            
            S2_UP:    next_state = s[3] ? ABOVE_S3 : (s[2] ? S2_UP : S1_DOWN);
            S2_DOWN:  next_state = s[3] ? ABOVE_S3 : (s[2] ? S2_DOWN : S1_DOWN);
            
            ABOVE_S3: next_state = s[3] ? ABOVE_S3 : S2_DOWN;
            
            default:  next_state = BELOW_S1;
        endcase
    end

    // State Register (Synchronous Reset)
    always @(posedge clk) begin
        if (reset) begin
            state <= BELOW_S1;
        end else begin
            state <= next_state;
        end
    end

    // Output Logic (Combinational)
    always @(*) begin
        case (state)
            BELOW_S1: {fr3, fr2, fr1, dfr} = 4'b1111;
            S1_UP:    {fr3, fr2, fr1, dfr} = 4'b0110;
            S1_DOWN:  {fr3, fr2, fr1, dfr} = 4'b0111;
            S2_UP:    {fr3, fr2, fr1, dfr} = 4'b0010;
            S2_DOWN:  {fr3, fr2, fr1, dfr} = 4'b0011;
            ABOVE_S3: {fr3, fr2, fr1, dfr} = 4'b0000;
            default:  {fr3, fr2, fr1, dfr} = 4'b1111;
        endcase
    end

endmodule