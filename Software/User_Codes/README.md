==============================================================
## Iran Univeristy of Science and Technology
## Assignment 1: Assembly code execution on phoeniX RISC-V core

- Name:Seyed Yazdan Seyed Babaei Sales
- Team Members: Amir mohhammad jamshidi
- Student ID: 400412328
- Date:05/26/2024

# Report

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

# Quick Sort Code Overview :

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


## Create stack space
    addi  sp, sp, -64      # Allocate stack space (64 bytes)

The code allocates 64 bytes of stack space by subtracting 64 from the stack pointer.


## Save s0
    sw    s0, 60(sp)       # Save s0 register to stack

The code saves the value of the `s0` register to the stack at the address `60(sp)`.


## Update s0
    addi  s0, sp, 64       # Set s0 to the top of the allocated stack

The code updates the `s0` register to point to the top of the allocated stack space (64 bytes above the current stack pointer).


## Initialize arr[] in memory
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
## Set up arguments for quickSort call
    addi  a0, s0, -48      # a0 = base address of array
    li    a1, 0            # a1 = low index (0)
    li    a2, 4            # a2 = high index (4)
```
The code sets up the arguments for the `quicksort` function call:
- `a0` is the base address of the array
- `a1` is the low index (0)
- `a2` is the high index (4)

```
## Call quicksort
    jal   ra, quicksort    # Jump and link to quicksort function
```
The code calls the `quicksort` function, saving the return address in the `ra` register.

```
## Load sorted elements back to registers for inspection
    lw s2, -48(s0)  # Load arr[0] into s2
    lw s3, -44(s0)  # Load arr[1] into s3
    lw s4, -40(s0)  # Load arr[2] into s4
    lw s5, -36(s0)  # Load arr[3] into s5
    lw s6, -32(s0)  # Load arr[4] into s6
```
The code loads the sorted elements from the array back into the `s2`, `s3`, `s4`, `s5`, and `s6` registers for inspection.

```
## Restore registers and exit
    lw    s0, 60(sp)        # Restore s0
    addi  sp, sp



# Integer Square Root

## Definition
- The integer square root of a non-negative integer `n` is the largest integer `x` such that `x^2 ≤ n`.
- For example, the integer square root of 16 is 4, as 4^2 = 16, and the integer square root of 25 is 5, as 5^2 = 25.
- Finding the integer square root of a number is a common operation in computer science and is used in various applications, such as image processing, computer graphics, and numerical analysis.

## Algorithms for Integer Square Root

### 1. Brute Force Approach
- The simplest way to find the integer square root is to try all possible integers from 0 until we find the largest one whose square is less than or equal to the given number.
- This approach has a time complexity of O(√n), which can be slow for large numbers.

### 2. Binary Search Approach
- The binary search algorithm can be used to find the integer square root more efficiently.
- The idea is to start with a range of possible square roots, and then repeatedly halve the range until the correct square root is found.
- This approach has a time complexity of O(log n).

### 3. Newton-Raphson Method
- The Newton-Raphson method is an iterative algorithm that converges quickly to the square root of a number.
- It starts with an initial guess and then repeatedly refines the guess using the formula `x_new = (x_old + n/x_old) / 2`.
- This approach has a time complexity of O(log log n), making it one of the fastest algorithms for finding the integer square root.

### 4. Bit Manipulation Approach
- This approach uses bit-wise operations to efficiently compute the integer square root.
- The idea is to extract the square root bit by bit, starting from the most significant bit.
- This approach has a time complexity of O(log n).

## Conclusion
The choice of algorithm depends on the specific requirements of the application, such as the size of the input numbers, the available hardware resources, and the desired level of accuracy and performance.

# Integer Square Root Code Overview 


## Initialization
```
    addi x10, x0, 81  # Load input number (81) into x10 (a0)
    add x5, x0, x0    # x5 = low = 0 (initialize low bound)
    add x6, x10, x0   # x6 = high = x10 (initialize high bound to input number)
    add x7, x0, x0    # x7 = mid (initialize mid to 0)
    add x8, x0, x0    # x8 = mid * mid (initialize to 0)
```

## Binary Search Loop
```
binary_search:
    # Check if low is greater than high
    bgt x5, x6, finish           # if low > high, exit the loop and finish the search

    # Calculate mid = (low + high) / 2
    add x7, x5, x6               # x7 = low + high
    srai x7, x7, 1               # x7 = mid = (low + high) / 2 (shift right arithmetic by 1)

    # Compare mid*mid with the input number
    mul x8, x7, x7               # x8 = mid * mid
    blt x8, x10, mid_is_too_low  # if mid * mid < input number, search in the upper half
    bgt x8, x10, mid_is_too_high # if mid * mid > input number, search in the lower half
```

## Mid is Exact
```
mid_is_exact:
    add x6, x7, x0  # if mid * mid == input number, set result to mid
    j finish        # exit the loop and finish the search
```

## Mid is Too Low
```
mid_is_too_low:
    addi x5, x7, 1  # if mid * mid < input number, set low = mid + 1
    j binary_search # repeat the binary search
```

## Mid is Too High
```
mid_is_too_high:
    addi x6, x7, -1 # if mid * mid > input number, set high = mid - 1
    j binary_search # repeat the binary search
```

## Finishing the Program
```
finish:
    add x10, x6, x0 # result = high (integer square root)
    ebreak          # end of program (trigger a breakpoint)
```