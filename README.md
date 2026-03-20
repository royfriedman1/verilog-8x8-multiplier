# 8×8 Sequential Multiplier in Verilog

## 🚀 Overview
This project implements an **8×8 sequential multiplier** in Verilog using a modular design approach.  
It demonstrates the combination of **datapath** (adder, shifter, register, mux) and **control logic** (FSM, counter) to achieve a full multiplication in multiple clock cycles.  
Designed and tested with **Xilinx ISE**, but portable to any standard Verilog simulator or FPGA tool.

---

## 📖 Theoretical Background
Binary multiplication can be efficiently implemented using the **shift-and-add method**.  
For an 8×8 multiplication, each operand is split into two 4-bit halves, and partial products are computed using a **4×4 multiplier**. These partial products are then aligned (shifted) and accumulated into a 16-bit register.  

A **finite state machine (FSM)** controls the operation sequence:
1. **Idle** – wait for `start` signal.  
2. **LSB step** – compute and add least significant partial product.  
3. **Mid steps** – compute intermediate products, shift, and add.  
4. **MSB step** – compute final partial product.  
5. **Done** – assert `done_flag` and hold the result.  

The FSM state is displayed on a **7-segment display** for debugging and visualization.  
This project demonstrates **hierarchical structural design** in Verilog by reusing smaller modules in a top-level integration.

---

## 📦 Modules Overview

- **`mult8x8.v`**  
  Top-level module integrating datapath and control. Produces the 16-bit product and controls display.

- **`mult_control.v`**  
  Finite State Machine (FSM) generating control signals for sequencing.

- **`mult4x4.v`**  
  4×4 combinational multiplier producing partial products.

- **`adder.v`**  
  16-bit adder used to accumulate shifted partial products.

- **`shifter.v`**  
  Aligns 8-bit partial products by shifting 0, 4, or 8 bits.

- **`reg16.v`**  
  16-bit register with synchronous clear and clock enable. Holds intermediate sums.

- **`mux4.v`**  
  2-to-1 multiplexer (4 bits wide) to select between operand halves.

- **`counter.v`**  
  2-bit counter tracking multiplication steps.

- **`seven_segment_cntrl.v`**  
  Maps FSM states to 7-segment display patterns.

---

## ▶️ Usage

1. Open the project in **Xilinx ISE** (or any compatible Verilog simulator).  
2. Add all Verilog source files (`*.v`) and your testbench.  
3. Run behavioral simulation to verify:  
   - Correct product accumulation across cycles.  
   - `done_flag` assertion on completion.  
   - 7-segment display reflecting FSM state.  
4. (Optional) Synthesize and program onto an FPGA board for hardware verification.  

---

## 📚 Notes
- Written and tested with **Xilinx ISE**.  
- Modular, extensible design (can scale to 16×16 with similar approach).  
