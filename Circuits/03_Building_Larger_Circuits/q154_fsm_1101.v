/*
Build a finite-state machine that searches for the sequence 1101 in an input bit stream. When the sequence is found, it should set start_shifting to 1, forever, until reset. Getting stuck in the final state is intended to model going to other states in a bigger FSM that is not yet implemented. We will be extending this FSM in the next few exercises.
*/

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    // state encoding
    parameter S0 = 3'd0;
    parameter S1 = 3'd1;
    parameter S2 = 3'd2;
    parameter S3 = 3'd3;
    parameter S4 = 3'd4;

    reg[2:0] state, next_state;
    
    // next state logic
    always@(*) begin
        case(state)
        	S0: next_state = data ? S1 : S0;
        	S1: next_state = data ? S2 : S0;
        	S2: next_state = data ? S2 : S3;
        	S3: next_state = data ? S4 : S0;
        	S4: next_state = S4;
            default:  next_state = S0;            
        endcase
    end
    
    // sequential state logic
    always@(posedge clk) begin
        if(reset) begin
            state <= S0;
        end
        else begin
            state <= next_state;
        end
    end
    
    // final output
    assign start_shifting = (state == S4);
    
endmodule
