.thumb

			.text
P1SEL0		.word	0x40004C0A
P1SEL1		.word	0x40004C0C
P1DIR		.word	0x40004C04
P1OUT		.word	0x40004C04
			.global asm_main
			.thumbfunc asm_main

; Input: R0 = 4-bit input passed from C main via R0
; Output: R0
asm_main:	.asmfunc		; main loop
	push	{r0,lr}
bl		LED_Init
pop	{r0}
	; SOP
	mov		r1, r0
	bfc		r1,#1,#31	; clearing bits for D
	
	mov 		r2, r0
	lsr		r2, #1
	bfc		r2,#1,#31	; clearing bits for C
	
	mov 		r3, r0
	lsr		r3, #2
	bfc		r3,#1,#31	; clearing bits for B
	
	mov 		r4, r0
	lsr		r4, #3
	bfc		r4,#1,#31	; clearing bits for A
	

	; NOT gates for variables 
	; D NOT is not needed for this SOP
	mvn		r5, r2			
	bfc 	r5,#1,#31		; clears extra bits for C NOT
	mvn		r6, r3			
	bfc 	r6,#1,#31		; clears extra bits for B NOT
	mvn		r7, r4			
	bfc 	r7,#1,#31		; clears extra bits for A NOT
	

	; AND gates
	and 	r8,r6,r5		; B NOT and C NOT	
	and 	r9,r7,r5			
	and 	r10,r9,r1		; A NOT and C NOT and D
	and 	r9,r4,r3		
and 	r11,r9,r2		; A and B and C

	; OR gates
	orr 	r9,r8,r10			
	orr		r12,r9,r11	

	cmp	r12,#0x00
	beq	NO_Press
	bl 	LED_On

b:
	mov 	r0,r12
	pop	{lr}
	bx	lr
			.endasmfunc

NO_Press:
	bl	LED_Off
	b	b
		.endasmfunc

LED_Init:	.asmfunc
	ldr		r1,P1SEL0
	ldrb	r0,[r1]
	bic	r0,#0x01
	strb	r0,[r1]

	ldr		r1,P1SEL1
	ldrb	r0,[r1]
	bic	r0,#0x01
	strb	r0,[r1]

	ldr		r1,P1DIR
	ldrb	r0,[r1]
	orr	r0,#0x01
	strb	r0,[r1]
	
	ldr		r1,P1OUT
	ldrb	r0,[r1]
	orr	r0,#0x01
	strb	r0,[r1]

	bx	lr

LED_On:
	ldr		r1,P1OUT
	ldrb	r0,[r1]
	orr		r0,#0x01
	strb	r0,[r1]
       bx    lr

LED_Off:
	ldr		r1,P1OUT
	ldrb	r0,[r1]
	bic	r0,#0x01
	strb	r0,[r1]

	bx 		lr
			.endasmfunc
			.end

2.	Product-of-Sums (PoS)

			.thumb

			.text
P1SEL0		.word	0x40004C0A
P1SEL1		.word	0x40004C0C
P1DIR		.word	0x40004C04
P1OUT		.word	0x40004C04
			.global asm_main
			.thumbfunc asm_main

; Input: R0 = 4-bit input passed from C main via R0
; Output: R0
asm_main:	.asmfunc		; main loop
	push	{r0,lr}
bl		LED_Init
pop	{r0}
	; POS
	mov		r1, r0
	bfc		r1,#1,#31	; clearing bits for D
	
	mov 		r2, r0
	lsr		r2, #1
	bfc		r2,#1,#31	; clearing bits for C
	
	mov 		r3, r0
	lsr		r3, #2
	bfc		r3,#1,#31	; clearing bits for B
	
	mov 		r4, r0
	lsr		r4, #3
	bfc		r4,#1,#31	; clearing bits for A
	

	; NOT gates for variables 
	; A NOT is not needed for this POS
	mvn		r5, r1			
	bfc 	r5,#1,#31		; clears extra bits for D NOT
	mvn		r6, r2			
	bfc 	r6,#1,#31		; clears extra bits for C NOT
	mvn		r7, r3			
	bfc 	r7,#1,#31		; clears extra bits for B NOT
	

	; OR gates
	orr 	r8,r3,r1		; B or D	
	orr 	r9,r4,r7		; A or B NOT			
	orr 	r10,r7,r6		; B NOT or C NOT or D NOt
	orr 	r11,r10,r5	

	; AND gates
	and 	r10,r8,r9			
	and		r12,r10,r11	

	cmp	r12,#0x00
	beq	NO_Press
	bl 	LED_On

b:
	mov 	r0,r12
	pop	{lr}
	bx	lr
			.endasmfunc

NO_Press:
	bl	LED_Off
	b	b
		.endasmfunc

LED_Init:	.asmfunc
	ldr		r1,P1SEL0
	ldrb	r0,[r1]
	bic	r0,#0x01
	strb	r0,[r1]

	ldr		r1,P1SEL1
	ldrb	r0,[r1]
	bic	r0,#0x01
	strb	r0,[r1]

	ldr		r1,P1DIR
	ldrb	r0,[r1]
	orr	r0,#0x01
	strb	r0,[r1]
	
	ldr		r1,P1OUT
	ldrb	r0,[r1]
	orr	r0,#0x01
	strb	r0,[r1]

	bx	lr

LED_On:
	ldr		r1,P1OUT
	ldrb	r0,[r1]
	orr		r0,#0x01
	strb	r0,[r1]
       bx    lr

LED_Off:
	ldr		r1,P1OUT
	ldrb	r0,[r1]
	bic	r0,#0x01
	strb	r0,[r1]

	bx 		lr
			.endasmfunc
			.end
