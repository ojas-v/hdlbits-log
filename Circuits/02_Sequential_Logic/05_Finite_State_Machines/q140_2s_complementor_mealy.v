module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    // state encoding
    parameter A = 2'd0;
    parameter B = 2'd1;
    parameter C = 2'd2;
    
    reg [3:0] next_state, state;
    
    always@(*) begin
        case(state) 
        	A : next_state = x ? B : A;
        	B : next_state = x ? C : B;
        	C : next_state = x ? C : B;
            
            default: next_state = A;
        endcase
    end
    
    always@(posedge clk or posedge areset) begin
        if(areset) begin
        	state <= A;
        end
        else begin
        	state <= next_state;
        end
    end
    
    assign z = (state == B);
    
endmodule
