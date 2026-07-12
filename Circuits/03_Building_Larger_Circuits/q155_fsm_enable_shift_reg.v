/*
As part of the FSM for controlling the shift register, we want the ability to enable the shift register for exactly 4 clock cycles whenever the proper bit pattern is detected. We handle sequence detection in Exams/review2015_fsmseq, so this portion of the FSM only handles enabling the shift register for 4 cycles.

Whenever the FSM is reset, assert shift_ena for 4 cycles, then 0 forever (until reset).
*/

module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena
);

    reg [2:0] count;

    // .Counter Logic
    always @(posedge clk) begin
        if (reset) begin
            count <= 3'd0;
        end 
        else if (count < 3'd4) begin
            count <= count + 3'd1;
        end
    end

    // Output is high for count = 0, 1, 2, 3. Drops to 0 when count hits 4.
    assign shift_ena = (count < 3'd4);

endmodule
