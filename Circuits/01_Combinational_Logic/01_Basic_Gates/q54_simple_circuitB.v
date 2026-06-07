/*
according to waveform:
x = 0, y = 0; z = 1
x = 1, y = 0; z = 0
x = 0, y = 1; z = 0 
x = 1, y = 1; z = 1

this is xnor gate
*/

module top_module ( input x, input y, output z );

    assign z = ~(x^y);
endmodule
