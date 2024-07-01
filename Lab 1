           .thumb
           .data             ; puts following into RAM
var        .word 0           ; variable

           .text
const      .word 0xffffffff  ; constant
ptr        .word var         ; contains address of var

           .global asm_main
           .thumbfunc asm_main

asm_main:  .asmfun           ; main
      ldr  r0,  ptr
      ldr  r1,const
      str  r1,[r0]
      bx   lr                ; return to C program

           .endasmfunc
           .end
