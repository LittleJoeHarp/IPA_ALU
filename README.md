[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/utnnfb5U)
# S25-IPA-Assignment1



# ALU Design in Verilog

This project implements a 64-bit Arithmetic Logic Unit (ALU) in Verilog. The ALU supports multiple operations such as addition, subtraction, bitwise operations, and shifts. A testbench is included to verify the correctness of all supported operations.

## Features

The ALU supports the following operations based on the provided 4-bit opcode:

| Opcode  | Operation                  |
|---------|----------------------------|
| `0000`  | ADD (Addition)             |
| `1000`  | SUB (Subtraction)          |
| `0001`  | SLL (Shift Left Logical)   |
| `0010`  | SLT (Set Less Than)        |
| `0011`  | SLTU (Set Less Than Unsigned) |
| `0100`  | XOR (Bitwise XOR)          |
| `0101`  | SRL (Shift Right Logical)  |
| `1101`  | SRA (Shift Right Arithmetic) |
| `0110`  | OR (Bitwise OR)            |
| `0111`  | AND (Bitwise AND)          |

## File Structure

- **`add.v`**: Implements the addition operation.
- **`sub.v`**: Implements the subtraction operation.
- **`xor.v`**: Implements the XOR operation.
- **`and.v`**: Implements the AND operation.
- **`or.v`**: Implements the OR operation.
- **`sll.v`**: Implements the Shift Left Logical operation.
- **`srl.v`**: Implements the Shift Right Logical operation.
- **`sra.v`**: Implements the Shift Right Arithmetic operation.
- **`slt.v`**: Implements the Set Less Than operation.
- **`sltu.v`**: Implements the Set Less Than Unsigned operation.
- **`alu.v`**: Combines all operations into a single ALU module.
- **`alu_tb.v`**: Testbench to verify the functionality of the ALU.

## How to Run

### Prerequisites
- You need to have [Icarus Verilog](http://iverilog.icarus.com/) installed on your system.

### Compilation and Simulation
1. Open a terminal and navigate to the project directory.
2. Run the following command to compile the ALU and its testbench:
   ```bash
   iverilog -o output add.v sub.v xor.v and.v alu.v alu_tb.v or.v sll.v slt.v sltu.v sra.v srl.v
   ```
3. Execute the compiled simulation:
   ```bash
   vvp output
   ```
4. The testbench output will display the results of various ALU operations.


