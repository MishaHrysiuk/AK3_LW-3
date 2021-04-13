.syntax unified
.cpu cortex-m4

//.fpu softvfp
.thumb

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
    start: .asciz "kernel start\n"
    finish: .asciz "result: "

.section .text
#define A #5
#define B #3
#define C #0
__kernel_reset__:
    ldr r0, =start
    bl dbgput_line

    // calc part    
    mov r0, A
    mov r1, B
    SUB r0, r0, r1
    mov r1, #3
    MUL r0, r0, r1
    mov r1, C
    mov r2, #1
    mov r3, #2
    
pow:
    cmp r1, #0
    ble func
    mul r2, r2, r3
    sub r1, r1, #1
    b pow
    
func:
    add r3, r0, r2

    ldr r0, =finish
    bl dbgput

    mov r0, r3      // Move result to r0
    bl dbgput_num
end:
b end

