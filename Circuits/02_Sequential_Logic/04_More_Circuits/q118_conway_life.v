/*
Conway's Game of Life is a two-dimensional cellular automaton.

The "game" is played on a two-dimensional grid of cells, where each cell is either 1 (alive) or 0 (dead). At each time step, each cell changes state depending on how many neighbours it has:

0-1 neighbour: Cell becomes 0.
2 neighbours: Cell state does not change.
3 neighbours: Cell becomes 1.
4+ neighbours: Cell becomes 0.
The game is formulated for an infinite grid. In this circuit, we will use a 16x16 grid. To make things more interesting, we will use a 16x16 toroid, where the sides wrap around to the other side of the grid. For example, the corner cell (0,0) has 8 neighbours: (15,1), (15,0), (15,15), (0,1), (0,15), (1,1), (1,0), and (1,15). The 16x16 grid is represented by a length 256 vector, where each row of 16 cells is represented by a sub-vector: q[15:0] is row 0, q[31:16] is row 1, etc. (This tool accepts SystemVerilog, so you may use 2D vectors if you wish.)

load: Loads data into q at the next clock edge, for loading initial state.
q: The 16x16 current state of the game, updated every clock cycle.
The game state should advance by one timestep every clock cycle.

John Conway, mathematician and creator of the Game of Life cellular automaton, passed away from COVID-19 on April 11, 2020.

*/

`default_nettype none

module top_module(
    input wire clk,
    input wire load,
    input wire [255:0] data,
    output reg [255:0] q
);

    // Combinational wire/reg for the next generation
    reg [255:0] next_q;
    
    // Loop variables (must be declared as integers for synthesis tools to unroll)
    integer i, r, c;
    integer r_u, r_d, c_l, c_r;
    integer neighbors;

    // Combinational Block: Calculate the next state for all 256 cells
    always @(*) begin
        for (i = 0; i < 256; i = i + 1) begin
            // 1. Map 1D index to 2D coordinates
            r = i / 16;
            c = i % 16;

            // 2. Calculate toroidal wrap-around boundaries
            r_u = (r == 0) ? 15 : r - 1;
            r_d = (r == 15) ? 0 : r + 1;
            c_l = (c == 0) ? 15 : c - 1;
            c_r = (c == 15) ? 0 : c + 1;

            // 3. Count living neighbors (8 surrounding cells)
            neighbors = q[r_u*16 + c_l] + q[r_u*16 + c] + q[r_u*16 + c_r] +
                        q[r*16 + c_l]                   + q[r*16 + c_r] +
                        q[r_d*16 + c_l] + q[r_d*16 + c] + q[r_d*16 + c_r];

            // 4. Apply Conway's Rules of Life
            if (neighbors == 2) begin
                next_q[i] = q[i];     // Survival
            end else if (neighbors == 3) begin
                next_q[i] = 1'b1;     // Reproduction
            end else begin
                next_q[i] = 1'b0;     // Underpopulation / Overpopulation
            end
        end
    end

    // Sequential Block: Update the grid on the clock edge
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule