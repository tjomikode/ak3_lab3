.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb
//global memory locations
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
    start: .asciz "Kernel started...\n"
    finish: .asciz "Value in register #5: "

.section .text
__kernel_reset__:
    ldr r0, =start
    bl dbgput_line
    //calculating
    mov r0, #7    /*a*/
    mov r1, #9    /*b*/
    mov r2, #6    /*c*/
    add r5, r0, r1 /*a+b*/
    lsr r5, r5, #1 /*(a+b)/2*/
    mov r3, #1
    fact:
        cmp r2, #1
        ITTTE GE
        mulGE r4, r3, r2
        movGE r3, r4
        subGE r2, r2, #1
        bLT adding
        b fact
      adding:
        add r5, r5, r3  
    ldr r0, =finish
    bl dbgput
    mov r0, r5
    bl dbgput_num

    end:
        b end
