.thumb
.text			; Puts code in ROM
var			.word 88

var_ptr		.word var
			.global asm_main
			.thumbfunc asm_main

asm_main:	.asmfunc		; main
	ldr 	r0, var_ptr		; starting the stack at address 88
	mov		r0, #0x88		

loop:
	push 	{r0}			; push address 88
	sub		r0,#0x11		; subtracting the registers by 11
	cmp 	r0,#0x00		; stop subtracting until register 00 is reached
	b 		loop

	ldr 	r10,[r13,#12]	; making r10 at address 44
	ldr 	r10,[r13,#24]	; making r11 at address 77

	bx		lr				; return to C program

; part 2
.thumb
.text			; Puts code in ROM
var			.word 14

var_ptr		.word var
			.global asm_main
			.thumbfunc asm_main

asm_main:	.asmfunc		; main

	mov		r0,#5			; adding '5'
	push	{r0}			; pushing 5 to the stack
	mov		r0,#1			; adding '1'
	push	{r0}			; pushing 1 to the stack
	mov		r0,#2			; adding '2'
	push	{r0}			; pushing 2 to the stack

	pop		{r0}			; popping '2'
	pop		{r1}			; popping '1'
	add		r0,r1			; r0=r0+r1
	push 	{r0}			; pushing the new value of r0 = 3

	mov 	r0,#4			; adding '4'
	push	{r0}			; pushing '4'

	pop		{r0}			; popping '4'
	pop		{r1}			; popping '3'
	mul		r0,r1			; multiplying 4 and 3
	push	{r0}			; pushing new value = 12

	pop		{r0}			; popping '12'
	pop		{r1}			; popping '5'
	add		r0,r1			; adding 12 and 5
	push	{r0}			; pushing new result of 17

	mov 	r0,#3			; adding '3'
	push	{r0}			; pushing '3'

	pop		{r0}			; popping '3'
	pop		{r1}			; popping '17'
	sub		r0,r1			; subtracting '3 and 17'
	push 	{r0}				; pushing new value 14
	        .endasmfunc
	        .end


; part 3
			.thumb
; part 3.1
RPN_IN      .byte  0x06, 0x03, 0x2F, 0x04, 0x2A, 0x02, 0x2B ; ((6/3)*4)+2
; part 3.2
RPN_IN      .byte  0x02, 0x03, 0x2A, 0x05, 0x2A, 0x02, 0x2F, 0x01, 0x2B; (((2*3)*5)/2)+1
; part 3.3             .data
RPN_IN      .byte  0x11, 0x10, 0x2F, 0x15, 0x2A; ((11/10)) * 15

RPN_OUT     .byte   0 ; Output

            .text
RPN_START   .word   RPN_IN ; Pointer to start of RPN array

RPN_END     .word   RPN_OUT-1 ; Pointer to end of RPN array

OPER        .byte   0x2A,0x2B,0x2D,0x2F                 ;*,+,-,/
OPER_PTR    .word   OPER ; Pointer to operator

            .global asm_main
            .thumbfunc asm_main

asm_main:    .asmfunc        ; main
    ldr     r0, RPN_START	 ; loading the first input
    ldr		r1, RPN_END		 ; loading the last input
    ldr     r2, OPER_PTR	 ; loading operations


loop:
    ldrb    r3,[r0]		; loading first values into r3
    ldrb    r4,[r2]		; loading function symbols
    cmp     r3, r4		; getting ready to *,-,+ or / values 
    beq     mul_branch	; calling * branch


mul_back:
    ldrb    r4,[r2, #1]	; loading values
    cmp     r3,r4		; comparing if the values needs to be *
    beq     add_branch	; going to check if value needs to be +
add_back:
    ldrb    r4,[r2,#2]	; loading values
    cmp     r3,r4		; comparing if the values needs to be +
    beq     sub_branch	; going to check if value needs to be -
sub_back:
    ldrb    r4,[r2,#3]	; loading values
    cmp     r3,r4		; comparing if the values needs to be -
    beq     sdiv_branch	; going to check if value needs to be /
sdiv_back:
    add     r0,r0,#1	; loading values
    push    {r3}		; pushing the current value
    cmp     r0,r1		; comparing if the values needs to be /
    bgt     done		; finish comparing
    b       loop		; going back to check the next command


mul_branch:
    pop     {r5}		; taking the first value 
    pop     {r6}		; taking the second value
    mul     r3,r5,r6	; taking value 1 and * by value 2
    b       mul_back	; going back to check the next command
add_branch:
    pop     {r7}		; taking the first value
    pop     {r8}		; taking the second value
    add     r3,r7,r8	; taking value 1 and + by value 2
    b       add_back	; going back to check the next command
sub_branch:
    pop     {r11}		; taking the first value
    pop     {r12}		; taking the second value
    sub     r3,r12,r11	; taking value 1 and - by value 2
    b       sub_back	; going back to check the next command
sdiv_branch:
    pop     {r4}		; taking the first value
    pop     {r9}		; taking the second value
    sdiv    r3,r9,r4	; taking value 1 and / by value 2
    b       sdiv_back	; going back to check the next command


done:
    bx      lr

   			.endasmfunc
   			.end
