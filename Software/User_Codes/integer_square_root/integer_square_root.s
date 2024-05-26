  .globl _start

_start:
    # Initialize input number and binary search bounds
    addi x10, x0, 81  # Load input number (81) into x10 (a0)
    add x5, x0, x0    # x5 = low = 0 (initialize low bound)
    add x6, x10, x0   # x6 = high = x10 (initialize high bound to input number)
    add x7, x0, x0    # x7 = mid (initialize mid to 0)
    add x8, x0, x0    # x8 = mid * mid (initialize to 0)

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

mid_is_exact:
    add x6, x7, x0  # if mid * mid == input number, set result to mid
    j finish        # exit the loop and finish the search

mid_is_too_low:
    addi x5, x7, 1  # if mid * mid < input number, set low = mid + 1
    j binary_search # repeat the binary search

mid_is_too_high:
    addi x6, x7, -1 # if mid * mid > input number, set high = mid - 1
    j binary_search # repeat the binary search

finish:
    add x10, x6, x0 # result = high (integer square root)
    ebreak          # end of program (trigger a breakpoint)