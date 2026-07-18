# HDLBits RTL Design Portfolio

![Language](https://img.shields.io/badge/Language-Verilog-blue.svg)
![Focus](https://img.shields.io/badge/Focus-Synthesizable%20RTL-success.svg)
![Progress](https://img.shields.io/badge/Progress-Completed-success.svg)

This repository serves as a comprehensive, version-controlled log of my RTL design solutions for the [HDLBits](https://hdlbits.01xz.net/) problem set. 

The objective of this repository is not merely to pass simulation testbenches, but to systematically develop industry-standard hardware description skills. Every module is written with a strict focus on physical gate mapping, synthesizability, and avoiding common software-centric Verilog pitfalls. Alongside the raw Verilog source files, I maintain highly detailed, LaTeX-generated documentation that explores the architectural intuition, synthesis interpretations, and debugging takeaways for complex modules.

## Core Design Philosophy

As I progress through the curriculum, I adhere to the following architectural standards:
- **Hardware-First Mindset:** Verilog is not C. I design the mental block diagram and combinational/sequential logic paths before writing syntax.
- **FSMD Architecture:** Strict separation of the Control Path (FSM state routing) from the Datapath (arithmetic, counters, shift registers) to ensure modularity and clean synthesis.
- **Synthesis Optimization:** Prioritizing continuous assignments (`assign`), ternary operators (`? :`), and behavioral logic that allows modern synthesis tools to infer highly optimized standard cells.
- **State Encoding:** Leveraging architectures like One-Hot encoding to reduce combinational logic depth and optimize for FPGA LUT mapping.
- **Strict Net Typing:** Enforcing `` `default_nettype none `` to prevent the compiler from silently inferring disconnected wires, ensuring structural integrity as designs scale.

## 📂 Repository Structure & Progress Tracker

The repository is mapped directly to the HDLBits curriculum, reflecting the transition from fundamental language mechanics to physical hardware implementation. 

### 📁 `Verilog_Language/` *(Completed)*
- [x] **`01_Basics/`** - Fundamental routing, standard CMOS gate implementations (NOT, AND, NOR, XNOR), and AOI structures.
- [x] **`02_Vectors/`** - Multi-bit data routing, byte swapping, and vector concatenation.
- [x] **`03_Modules/`** - Hierarchical design, port mapping, and structural instantiation.
- [x] **`04_Procedures/`** - Combinational and sequential `always` blocks, blocking vs. non-blocking assignments (`=` vs `<=`).
- [x] **`05_More_Verilog_Features/`** - Parameterized module instantiation (`generate` blocks), reduction operators, and combinational `for` loops.

### 📁 `Circuits/` *(Completed)*

#### 📁 `01_Combinational_Logic/` *(Completed)*
- [x] **Basic Gates** - Complex boolean routing and logic simplification.
- [x] **Multiplexers** - Selectors and data path routing.
- [x] **Arithmetic Circuits** - Half/Full adders, ripple-carry architectures, and BCD addition.
- [x] **Karnaugh Map to Circuit** - Boolean minimization, SOP/POS forms, and Don't Care optimizations.

#### 📁 `02_Sequential_Logic/` *(Completed)*
- [x] **`01_Latches_and_Flipflops/`** - Edge-triggered state capture, synchronous/asynchronous resets, and edge detection.
- [x] **Counters** - Custom modulo boundaries and saturating counters.
- [x] **Shift Registers** - Serial/parallel routing, LFSRs, and MSB/LSB-first transmission.
- [x] **More Circuits** - Rule 90 and Rule 110 Cellular Automata.
- [x] **Finite State Machines (FSMs)** - Moore/Mealy topologies, synchronous priority arbiters, sequence detectors, and One-Hot combinational logic extraction.

#### 📁 `03_Building_Larger_Circuits/` *(Completed)*
- [x] **Complex System Integration** - Combining sequence recognizers, shift registers, and modulo-1000 timers into cohesive industrial-style FSMD controllers.

### 📁 `Verification/` *(Completed)*
- [x] **`01_Finding_Bugs_in_code/`** - Analyzing RTL bugs, debugging simulation mismatches, and fixing combinational/sequential logic errors.
- [x] **`02_Reading_Simulations/`** - Reverse-engineering logic circuits purely from simulation waveforms and deriving state logic.
- [x] **`03_Writing_Testbenches/`** - Generating clock stimuli, instantiating DUTs, and creating specific sequential input waveforms for functional verification.

*(Note: The CS450 course-specific module is excluded from this portfolio as the core HDLBits curriculum is officially completed).*

---

### Author
**Ojas Vaidya**  
*B.Tech + M.Tech, Electronics and Communication Engineering*  
*Indian Institute of Information Technology, Design and Manufacturing (IIITDM), Kancheepuram*  
Focused on digital logic design, VLSI, embedded systems, and computer architecture.
