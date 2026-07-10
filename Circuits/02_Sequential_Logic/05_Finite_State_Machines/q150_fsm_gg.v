/*
This FSM acts as an arbiter circuit, which controls access to some type of resource by three requesting devices. Each device makes its request for the resource by setting a signal r[i] = 1, where r[i] is either r[1], r[2], or r[3]. Each r[i] is an input signal to the FSM, and represents one of the three devices. The FSM stays in state A as long as there are no requests. When one or more request occurs, then the FSM decides which device receives a grant to use the resource and changes to a state that sets that device’s g[i] signal to 1. Each g[i] is an output from the FSM. There is a priority system, in that device 1 has a higher priority than device 2, and device 3 has the lowest priority. Hence, for example, device 3 will only receive a grant if it is the only device making a request when the FSM is in state A. Once a device, i, is given a grant by the FSM, that device continues to receive the grant as long as its request, r[i] = 1.

Write complete Verilog code that represents this FSM. Use separate always blocks for the state table and the state flip-flops, as done in lectures. Describe the FSM outputs, g[i], using either continuous assignment statement(s) or an always block (at your discretion). Assign any state codes that you wish to use.

*/
module top_module (
    input clk,
    input resetn,    
    input [3:1] r,
    output [3:1] g
); 

    // State Encoding
    parameter A = 2'd0; // Idle
    parameter B = 2'd1; // Grant 1
    parameter C = 2'd2; // Grant 2
    parameter D = 2'd3; // Grant 3
    
    reg [1:0] state, next_state;
    
    // Next-State Logic (Combinational)
    always @(*) begin
        case(state)
            A: begin
                // Priority encoded routing
                if (r[1])      next_state = B;
                else if (r[2]) next_state = C;
                else if (r[3]) next_state = D;
                else           next_state = A;
            end
            
            // Lock-and-release routing
            B: next_state = r[1] ? B : A;
            C: next_state = r[2] ? C : A;
            D: next_state = r[3] ? D : A;
            
            default: next_state = A;
        endcase
    end
    
    // State Memory (Active-Low Synchronous Reset)
    always @(posedge clk) begin
        if (~resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Moore Output Logic
    assign g[1] = (state == B);
    assign g[2] = (state == C);
    assign g[3] = (state == D);

endmodule
