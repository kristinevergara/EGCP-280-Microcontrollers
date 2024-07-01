      .thumb
			.text					; Puts code in ROM
P1SEL0		.word	0x40004C0A
P1SEL1		.word	0x40004C0C
P1DIR		.word	0x40004C04
P1REN		.word	0x40004C06
P1IN		.word	0x40004C00
P1OUT		.word	0x40004C02

			.global asm_main
			.thumbfunc asm_main

			.global port1_init
			.thumbfunc port1_init

; R0 = Input
asm_main:	.asmfunc				; Main
	push	{lr}
	bl 		port_switch
	cmp		r2,#0x10
	beq 	port1_right
	cmp		r2, #0x02 				;cmp r1 to bit 1 in hex
	beq		port1_left

back:
	pop		{lr}
	bx		lr						; Return to C program
			.endasmfunc

port1_right: ;.asmfunc
	ror		r0,#0x01
	mov		r2,r0
	bfc		r0,#8,#24  ;clear bits 8 to 24
	bfc 	r2, #0, #31 ;clear bits from 0 to 31
	lsr		r2, #24
	orr		r0, r2
	b		back

			.endasmfunc

port1_left: ;.asmfunc
	lsl		r0,#0x01
	mov		r2 , r0
	bicb	r0,#0x100
	bfc		r2,#0,#7	;clear bits in r2 with the width of bit 0 to 7
	lsr		r2,#8
	orr		r0,r2
	b		back
			.endasmfunc

; Called from C program
port1_init:	.asmfunc				; Port 1 Init
	ldr		r1,P1SEL0
	ldrb 	r0,[r1]
	bic		r0,#0x12
	strb	r0,[r1]

	ldr		r1,P1SEL1
	ldrb 	r0,[r1]
	bic		r0,#0x12
	strb	r0,[r1]

	ldr		r1,P1DIR
	ldrb 	r0,[r1]
	bic		r0,#0x12
	strb	r0,[r1]

	ldr		r1,P1REN
	ldrb 	r0,[r1]
	orr		r0,#0x12
	strb	r0,[r1]

	ldr		r1,P1OUT
	ldrb 	r0,[r1]
	orr		r0,#0x12
	strb	r0,[r1]

	bx 		lr
			.endasmfunc

port_switch:	.asmfunc
	ldr		r1,P1IN
	ldrb 	r2,[r1]
	and		r2,#0x12

	bx 		lr
			.endasmfunc
	        .end
