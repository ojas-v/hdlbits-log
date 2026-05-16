# HDLBits RTL Design Portfolio

![Language](https://img.shields.io/badge/Language-Verilog-blue.svg)
![Focus](https://img.shields.io/badge/Focus-Synthesizable%20RTL-success.svg)
![Progress](https://img.shields.io/badge/Progress-Ongoing-orange.svg)

This repository serves as a comprehensive, version-controlled log of my RTL design solutions for the [HDLBits](https://hdlbits.01xz.net/) problem set. 

The objective of this repository is not merely to pass simulation testbenches, but to systematically develop industry-standard hardware description skills. Every module is written with a strict focus on physical gate mapping, synthesizability, and avoiding common software-centric Verilog pitfalls.

## 🧠 Core Design Philosophy

As I progress through the 150+ problems, I adhere to the following architectural standards:
- **Hardware-First Mindset:** Verilog is not C. I design the mental block diagram and combinational/sequential logic paths before writing syntax.
- **Synthesis Optimization:** Prioritizing continuous assignments (`assign`), ternary operators (`? :`), and behavioral logic that allows modern synthesis tools to infer highly optimized standard cells (like MUX macros and AOI gates) rather than manual gate-level instantiation.
- **Strict Net Typing:** Enforcing `` `default_nettype none `` to prevent the compiler from silently inferring disconnected wires, ensuring structural integrity as designs scale.
- **Clean Latch Prevention:** Ensuring all conditional branches in combinational `always` blocks are fully defined.

## 📂 Repository Structure

The repository is organized chronologically matching the HDLBits curriculum to track the progression from basic boolean logic to complex finite state machines (FSMs) and custom data paths.

* 📁 **`01_Basics/`** - Fundamental routing, standard CMOS gate implementations (NOT, AND, NOR, XNOR), and AOI structures. *(Completed)*
* 📁 **`02_Vectors/`**  - Multi-bit data routing, byte swapping, and vector concatenation. *(Completed)*
* 📁 **`03_Modules/`** - *[In Progress]* Hierarchical design, port mapping, and structural instantiation.
* 📁 **`04_Procedures/`** - Combinational and sequential `always` blocks, blocking vs. non-blocking assignments (`=` vs `<=`).
* 📁 **`05_More_Verilog_Features/`** - Generate blocks, reduction operators, and combinational loops.
* 📁 **`06_Circuits/`** - Complex combinational logic (ALUs, Karnaugh maps) and sequential logic (Latches, Flip-Flops, Shift Registers, Counters, FSMs).

*(Note: Directories will be populated as modules are completed and verified.)*

---

### Author
**Ojas Vaidya**  
*B.Tech + M.Tech, Electronics and Communication Engineering*  
*IIITDM Kancheepuram*  
Focused on digital logic design, VLSI, and computer architecture.
