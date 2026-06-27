# HDLBits RTL Design Portfolio

![Language](https://img.shields.io/badge/Language-Verilog-blue.svg)
![Focus](https://img.shields.io/badge/Focus-Synthesizable%20RTL-success.svg)
![Progress](https://img.shields.io/badge/Progress-Ongoing-orange.svg)

This repository serves as a comprehensive, version-controlled log of my RTL design solutions for the [HDLBits](https://hdlbits.01xz.net/) problem set. 

The objective of this repository is not merely to pass simulation testbenches, but to systematically develop industry-standard hardware description skills. Every module is written with a strict focus on physical gate mapping, synthesizability, and avoiding common software-centric Verilog pitfalls.

## Core Design Philosophy

As I progress through the 150+ problems, I adhere to the following architectural standards:
- **Hardware-First Mindset:** Verilog is not C. I design the mental block diagram and combinational/sequential logic paths before writing syntax.
- **Synthesis Optimization:** Prioritizing continuous assignments (`assign`), ternary operators (`? :`), and behavioral logic that allows modern synthesis tools to infer highly optimized standard cells (like MUX macros and AOI gates) rather than manual gate-level instantiation.
- **Strict Net Typing:** Enforcing `` `default_nettype none `` to prevent the compiler from silently inferring disconnected wires, ensuring structural integrity as designs scale.
- **Clean Latch Prevention:** Ensuring all conditional branches in combinational `always` blocks are fully defined.

## 📂 Repository Structure & Progress Tracker

The repository is mapped directly to the HDLBits curriculum, reflecting the transition from fundamental language mechanics to physical hardware implementation.

### 📁 `Verilog_Language/` *(Completed)*
- [x] **`01_Basics/`** - Fundamental routing, standard CMOS gate implementations (NOT, AND, NOR, XNOR), and AOI structures.
- [x] **`02_Vectors/`** - Multi-bit data routing, byte swapping, and vector concatenation.
- [x] **`03_Modules/`** - Hierarchical design, port mapping, and structural instantiation.
- [x] **`04_Procedures/`** - Combinational and sequential `always` blocks, blocking vs. non-blocking assignments (`=` vs `<=`).
- [x] **`05_More_Verilog_Features/`** - Parameterized module instantiation (`generate` blocks), reduction operators, and combinational `for` loops.

### 📁 `Circuits/` *(In Progress)*

#### 📁 `01_Combinational_Logic/` *(Completed)*
- [x] **Basic Gates** - Complex boolean routing and logic simplification.
- [x] **Multiplexers** - Selectors and data path routing.
- [x] **Arithmetic Circuits** - Half/Full adders, ripple-carry architectures, and BCD addition.
- [x] **Karnaugh Map to Circuit** - Boolean minimization, SOP/POS forms, and Don't Care optimizations.

#### 📁 `02_Sequential_Logic/` *(In Progress)*
- [x] **`01_Latches_and_Flipflops/`** - Edge-triggered state capture, synchronous/asynchronous resets, and edge detection.
- [x] **Counters** 
- [x] **Shift Registers** 
- [x] **More Circuits** 
- [ ] **Finite State Machines (FSMs)** - *Started*

#### 📁 `Building_Larger_Circuits/` *(Not Started)*
- [ ] *Pending*

### 📁 `Verification/` *(Not Started)*
- [ ] **Reading Simulations** - *Not Started*
- [ ] **Writing Testbenches** - *Not Started*

---

### Author
**Ojas Vaidya** 

*B.Tech + M.Tech, Electronics and Communication Engineering* 
*Indian Institute of Information Technology, Design and Manufacturing (IIITDM), Kancheepuram* 

Focused on digital logic design, VLSI, embedded systems, and computer architecture.
