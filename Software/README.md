Software
====================
<div align="justify">

This directory contains source files of sample codes and user codes which will be executed on the phoeniX processor. In this directory, there are three subdirectories included:
- `Sample_Assembly_Codes`
- `Sample_C_Codes`
- `User_Codes`

The code execution and simulation on the phoeniX RISC-V processor follow two distinct branches: one for Linux systems and another for Windows systems.
</div>

### Linux

#### Running Sample Codes
<div align="justify">

The directory `/Software` contains sample codes for some conventional programs and algorithms in both Assembly and C which can be found in `/Sample_Assembly_Codes` and `/Sample_C_Codes` sub-directories respectively. 

phoeniX convention for naming projects is as follows; The main source file of the project is named as `{project.c}` or `{project.s}`. This file along other required source files are kept in one directory which has the same name as the project itself, i.e. `/project`.

Sample projects provided at this time are `bubble_sort`, `fibonacci`, `find_max_array`, `sum1ton`.
To run any of these sample projects simply run `make sample` followed by the name of the project passed as a variable named project to the Makefile.
```shell
make sample project={project}
```
For example:
```shell
make sample project=fibonacci
```

Provided that the RISC-V toolchain is set up correctly, the Makefile will compile the source codes separately, then using the linker script `riscv.ld` provided in `/Firmware` it links all the object files necessary together and creates `firmware.elf`. It then creates `start.elf` which is built from `start.s` and `start.ld` and concatenate these together and finally forms the `{project}_firmware.hex`. This final file can be directly fed to our verilog testbench. Makefile automatically runs the testbench and calls upon `gtkwave` to display the selected signals in the waveform viewer.

</div>

#### Running Your Own Code
<div align="justify">

In order to run your own code on phoeniX, create a directory named to your project such as `/my_project` in `/Software/User_Codes/`. Put all your `.c` and `.s` files in `/my_project` and run the following `make` command from the main directory:
```shell
make code project=my_project
```
Provided that you name your project sub-directory correctly and the RISC-V Toolchain is configured without any troubles on your machine, the Makefile will compile all your source files separately, then using the linker script `riscv.ld` provided in `/Firmware` it links all the object files necessary together and creates `firmware.elf`. It then creates `start.elf` which is built from `start.s` and `start.ld` and concatenate these together and finally forms the `my_project_firmware.hex`. After that, `iverilog` and `gtkwave` are used to compile the design and view the selected waveforms.
> Further Configurations
: The default testbench provided as `phoeniX_Testbench.v` is currently set to support up to 4MBytes of memory and the stack pointer register `sp` is configured accordingly. If you wish to change this, you need configure both the testbench and the initial value the `sp` is set to in `/Firmware/start.s`. If you wish to use other specific libraries and header files not provided in `/Firmware` please beware you may need to change linker scripts `riscv.ld` and `start.ld`.
</div>

### Windows

#### Running Sample Codes
<div align="justify">

We have meticulously developed a lightweight and user-friendly software solution with the help of Python. Our execution assistant software, `AssembleX`, has been crafted to cater to the specific needs of Windows systems, enabling seamless execution of assembly code on the phoeniX processor. 

This tool  enhances the efficiency of the code execution process, offering a streamlined experience for users seeking to enter the realm of assembly programming on pheoniX processor in a very simple and user-friendly way.

Before running the script, note that the assembly output of the Venus Simulator for the code must be also saved in the project directory.
To run any of these sample projects simply run python `AssembleX_V1.0.py sample` followed by the name of the project passed as a variable named project to the Python script.
The input command format for the terminal follows the structure illustrated below:
```shell
python AssembleX_V1.0.py sample {project_name}
```
For example:
```shell
python AssembleX_V1.0.py sample fibonacci
```
After execution of this script, firmware file will be generated and this final file can be directly fed to our Verilog testbench. AssembleX automatically runs the testbench and calls upon gtkwave to display the selected signals in the waveform viewer application, gtkwave.
</div>

#### Running Your Own Code
<div align="justify">

In order to run your own code on phoeniX, create a directory named to your project such as `/my_project in /Software/User_Codes/`. Put all your ``user_code.s` files in my_project and run the following command from the main directory:
```shell
python AssembleX_V1.0.py code my_project
```
Provided that you name your project sub-directory correctly the AssembleX software will create `my_project_firmware.hex` and fed it directly to the testbench of phoeniX processor. After that, iverilog and GTKWave are used to compile the design and view the selected waveforms.
</div>
Here's a summary of the RISC-V assembly code in this repository using Markdown:

## RISC-V Architecture

RISC-V is an open-source instruction set architecture (ISA) based on the reduced instruction set computer (RISC) principles. It is designed to be simple, efficient, and scalable, making it suitable for a wide range of applications, from embedded systems to high-performance computing.

The RISC-V ISA defines a set of 32-bit and 64-bit instructions, registers, and addressing modes. The assembly code in this repository is written for the 64-bit RISC-V architecture, which provides 31 general-purpose registers (x0 to x31) and various control and status registers.

## Assembly Code Structure

The assembly code files in this repository follow a standard structure:

1. **Directives**: The code begins with directives that specify the section of memory where the code is located (`.section .text`) and the global symbols (`.globl`) that can be called from other parts of the program.

2. **Function Definitions**: The assembly code defines the entry points for the various functions, such as `quicksort` and `sqrt`. These functions are labeled with a symbolic name that can be referenced from other parts of the program.

3. **Prologue and Epilogue**: Each function has a prologue and an epilogue. The prologue saves the current state of the function, such as the return address and any callee-saved registers. The epilogue restores the saved state and returns control to the calling function.

4. **Function Logic**: The main logic of the function is implemented in the body of the function. This typically involves loading and manipulating data, performing calculations, and controlling the flow of execution using branch instructions.

5. **Utility Functions**: Some of the assembly code files may also include utility functions or helper routines that are used by the main algorithms.

## Calling Conventions

The assembly code in this repository follows the standard RISC-V calling conventions, which define how function arguments are passed and how return values are handled. In the RISC-V architecture:

- Function arguments are passed in the `a0` to `a7` registers.
- The return value is typically stored in the `a0` register.
- Callee-saved registers (`s0` to `s11`) must be preserved across function calls, while caller-saved registers (`t0` to `t6`) can be modified without preserving their values.

The assembly code adheres to these conventions to ensure compatibility and interoperability with other RISC-V software components.

## Optimization Techniques

The assembly code in this repository may employ various optimization techniques to improve performance, such as:

- **Efficient memory access**: The code tries to minimize memory accesses and leverage the available registers for temporary storage.
- **Branch prediction**: The code may use branch instructions that are designed to provide accurate branch predictions, reducing the impact of branch mispredictions.
- **Instruction-level parallelism**: The code may take advantage of the RISC-V architecture's ability to execute multiple instructions concurrently, where possible.

These optimizations help to ensure that the assembly code runs efficiently on RISC-V hardware.

Overall, the RISC-V assembly code in this repository demonstrates the implementation of fundamental algorithms using the capabilities and conventions of the RISC-V architecture. The code can serve as a reference for understanding RISC-V assembly programming and as a starting point for further exploration and development.

Certainly! Here's the information about the quicksort algorithm and a summary of the RISC-V code for it.

## Quicksort Algorithm

Quicksort is a popular sorting algorithm that uses a divide-and-conquer strategy to sort a list of elements. The algorithm works as follows:

1. **Divide**: The algorithm selects a 'pivot' element from the list. This pivot element is used to partition the other elements into two sub-lists: those less than the pivot and those greater than or equal to the pivot.
2. **Conquer**: The algorithm recursively sorts the sub-lists, resulting in a sorted list.

The key steps in the quicksort algorithm are:

1. Selecting the pivot element
2. Partitioning the list around the pivot
3. Recursively sorting the sub-lists

Quicksort is known for its average-case time complexity of O(n log n), making it one of the most efficient comparison-based sorting algorithms.

## Summary of the RISC-V Quicksort Code

The RISC-V assembly code in this repository implements the quicksort algorithm. Here's a summary of the code:

1. **Function Definition**: The `quicksort` function is defined, which takes two arguments: the address of the array to be sorted (`a0`) and the number of elements in the array (`a1`).

2. **Prologue**: The function prologue saves the necessary register values on the stack, such as the return address and callee-saved registers.

3. **Base Case**: The code checks for the base case of the recursion, where the array has 0 or 1 elements. If so, it simply returns.

4. **Partitioning**: The code implements the partitioning step of the quicksort algorithm. It selects the last element as the pivot, and then uses a loop to partition the array around the pivot.

5. **Recursive Calls**: After the partitioning, the code recursively calls the `quicksort` function on the left and right sub-arrays.

6. **Epilogue**: The function epilogue restores the saved register values from the stack and returns to the caller.

The RISC-V assembly code for the `quicksort` function demonstrates the efficient implementation of the quicksort algorithm using the RISC-V instruction set and register conventions. It showcases the use of function calls, stack management, and control flow constructs, which are essential for building larger programs in RISC-V assembly.

## Quick Sort Code Overview :

```
.globl _start
```
This line declares the `_start` label as the global entry point for the program.

```
_start:
    # Initialize stack pointer to a larger stack space
    lui   sp, 0x2          # Upper 20 bits set to 0x20000 (sp = 0x20000000)
    addi  sp, sp, 0        # No change to lower bits
```
The `_start` label marks the beginning of the program. The code initializes the stack pointer (`sp`) to a larger stack space by setting the upper 20 bits to `0x20000` (resulting in `0x20000000`), and then adding `0` to the lower bits.

```
    # Create stack space
    addi  sp, sp, -64      # Allocate stack space (64 bytes)
```
The code allocates 64 bytes of stack space by subtracting 64 from the stack pointer.

```
    # Save s0
    sw    s0, 60(sp)       # Save s0 register to stack
```
The code saves the value of the `s0` register to the stack at the address `60(sp)`.

```
    # Update s0
    addi  s0, sp, 64       # Set s0 to the top of the allocated stack
```
The code updates the `s0` register to point to the top of the allocated stack space (64 bytes above the current stack pointer).

```
    # Initialize arr[] in memory
    li    t0, 6
    sw    t0, -48(s0)      # arr[0] = 6
    sw    t0, -44(s0)      # arr[1] = 6
    li    t0, 1
    sw    t0, -40(s0)      # arr[2] = 1
    li    t0, 2
    sw    t0, -36(s0)      # arr[3] = 2
    li    t0, 4
    sw    t0, -32(s0)      # arr[4] = 4
```
The code initializes an array `arr[]` in memory, with the following values: `[6, 6, 1, 2, 4]`.

```
    # Set up arguments for quickSort call
    addi  a0, s0, -48      # a0 = base address of array
    li    a1, 0            # a1 = low index (0)
    li    a2, 4            # a2 = high index (4)
```
The code sets up the arguments for the `quicksort` function call:
- `a0` is the base address of the array
- `a1` is the low index (0)
- `a2` is the high index (4)

```
    # Call quicksort
    jal   ra, quicksort    # Jump and link to quicksort function
```
The code calls the `quicksort` function, saving the return address in the `ra` register.

```
    # Load sorted elements back to registers for inspection
    lw s2, -48(s0)  # Load arr[0] into s2
    lw s3, -44(s0)  # Load arr[1] into s3
    lw s4, -40(s0)  # Load arr[2] into s4
    lw s5, -36(s0)  # Load arr[3] into s5
    lw s6, -32(s0)  # Load arr[4] into s6
```
The code loads the sorted elements from the array back into the `s2`, `s3`, `s4`, `s5`, and `s6` registers for inspection.

```
    # Restore registers and exit
    lw    s0, 60(sp)        # Restore s0
    addi  sp, sp

