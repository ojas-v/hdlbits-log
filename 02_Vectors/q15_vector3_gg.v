// q15. Given several input vectors, concatenate them together then split them up into several output vectors. 
// There are six 5-bit input vectors: a, b, c, d, e, and f, for a total of 30 bits of input. There are four 8-bit output vectors: w, x, y, and z, for 32 bits of output. 
// The output should be a concatenation of the input vectors followed by two 1 bits:

`default_nettype none
module top_module (
    input wire [4:0] a, b, c, d, e, f,
    output wire [7:0] w, x, y, z 
);

    // LHS Concatenation matches the 32-bit RHS payload perfectly
    assign {w, x, y, z} = {a, b, c, d, e, f, 2'b11};

endmodule

/*
In a software program, if you have an empty space in an array, it might just default to null or 0 safely. But in physical hardware, you cannot leave an output pin unconnected.

An unconnected pin is called a "floating" pin. It acts like a tiny radio antenna, picking up random static electricity and electromagnetic noise from the room. It will rapidly and randomly flip between 0 and 1, which will completely corrupt your downstream logic.

To prevent those last two pins from floating, you must physically solder them to a known, permanent voltage.
Tying them to Ground (GND) makes them permanent 0s.
Tying them to the Power Supply (VDD) makes them permanent 1s.
The HDLBits problem specifically requested: "followed by two 1 bits". So, Verilog code (2'b11) told the synthesizer to route the first 30 pins to your input vectors, and permanently wire the last 2 empty pins directly to the power supply.
*/
