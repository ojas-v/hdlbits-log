/*
The following is the state transition table for a Moore state machine with one input, one output, and four states. Implement this state machine. Include a synchronous reset that resets the FSM to state A. (This is the same problem as Fsm3 but with a synchronous reset.)

State	Next state	Output
in=0	in=1
A	A	B	0
B	C	B	0
C	A	D	0
D	C	B	1
*/

module top_module(
    input wire clk,
    input wire in,
    input wire reset,    // Synchronous reset to state A
    output wire out
);

    // State Encoding (Binary representation)
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    reg [1:0] state, next_state;

    // Next-State Logic (Purely Combinational)
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;
        endcase
    end

    // State Register (Sequential - Synchronous Reset)
    always @(posedge clk) begin
        if (reset) begin
            state <= A;        
        end else begin
            state <= next_state;
        end
    end

    // Output Logic (Combinational)
    assign out = (state == D);

endmodule