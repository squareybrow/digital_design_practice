.data
    hello_msg: .asciiz "Hello from MIPS on Linux!\n"

.text
.globl main

main:
    # 1. Print String Service
    li $v0, 4           # Load immediate: 4 = syscall for print_string
    la $a0, hello_msg   # Load address of the string into argument register $a0
    syscall             # Trigger the system call

    # 2. Exit Service
    li $v0, 10          # Load immediate: 10 = syscall for exit
    syscall             # Trigger exit