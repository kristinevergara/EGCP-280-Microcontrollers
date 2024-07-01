Part 1:
			.thumb

			.data
OUT			.byte	0				; LED Output
CYC			.half	0			; Cycles

			.text
CYC_ptr		.word	CYC				; Pointer to cycles
OUT_ptr		.word	OUT				; Pointer to LED Output

P2IN		.word	0x40004C01		; Port 2 Input
P2OUT		.word	0x40004C03		; Port 2 Output
P2DIR		.word	0x40004C05		; Port 2 Direction
P2REN		.word	0x40004C07		; Port 2 Resistor Enable
P2DS		.word	0x40004C09		; Port 2 Drive Strength
P2SEL0		.word	0x40004C0B		; Port 2 Select 0
P2SEL1		.word	0x40004C0D		; Port 2 Select 1

TA1CTL		.word	0x40000400		; TimerAx Control Register
TA1CCTL0	.word	0x40000402		; Timer_A Capture/Compare Control Register
TA1CCR0		.word	0x40000412		; Timer_A Capture/Compare Register
TA1EX0		.word	0x40000420		; Timer_A Expansion Register

NVIC_IPR2	.word	0xE000E408		; NVIC interrupt priority 2
NVIC_ISER0	.word	0xE000E100		; NVIC enable register 0

			.global asm_main
			.thumbfunc asm_main

			.global TimerA1_ISR
			.thumbfunc TimerA1_ISR

asm_main:	.asmfunc		; main
	; TODO: Complete this SR
	push {lr}

	mov 	r6,#32768
	bl	TimerA1_Init
	bl	NVIC_Init
	bl 	Port2_Init
	pop	{lr}
    bx      lr
    		.endasmfunc

Port2_Init:	.asmfunc				; Port 2 Init
	; TODO: Complete this SR

	ldr 	r1,P2SEL0
	ldrb	r0,[r1]
	bic 	r0, r0, #0x07
	strb	r0,[r1]

	ldr 	r1,P2SEL1
	ldrb	r0,[r1]
	bic 	r0, r0, #0x07
	strb	r0,[r1]

	ldr 	r1,P2DIR
	ldrb	r0,[r1]
	orr 	r0, r0, #0x07
	strb	r0,[r1]



	bx	lr

	        .endasmfunc

NVIC_Init:	.asmfunc				; NVIC_Init
	; TODO: Complete this SR
	; Set the I bit (disable interrupts)
	cpsid i
	; Load addresses
	ldr r0, NVIC_IPR2
	ldr r1, NVIC_ISER0
	; IPR 2
	ldr r2, [r0]
	bic r2, #0x00700000
	orr r2, #0x00200000
	str r2, [r0]
	; Enable interrupt in NVIC
	ldr r2, [r1]
	orr r2, #0x00000400
	str r2, [r1]
	; Clear the I bit (enable interrupts)
	cpsie i
	bx lr
	        .endasmfunc

TimerA1_Init:	.asmfunc			; TimerA1_Init
	; TODO: Complete this SR

	; Set the I bit (disable interrupts)
	cpsid i
	; Load addresses
	ldr r0, TA1CTL
	ldr r1, TA1CCTL0
	ldr r2, TA1CCR0
	ldr r3, TA1EX0

	; Halt Timer A1
	ldrh r4, [r0]
	bich r4, #0x0030
	strh r4, [r0]

	; SMCLK, ID = 0
	bich r4, #0x02F0
	orrh r4, #0x0110
	strh r4, [r0]

	; TA1EX0 = 0 (max = 7)
	ldrh r4, [r3]
	bich r5, #0x0007
	strh r5, [r3]

	; Compare mode (000), enable CCIE, clear CCIFG
	ldrh r4, [r1]
	bich r4, #0x00E0
	orrh r4, #0x0010
	bich r4, #0x0001
	strh r4, [r1]

	; Compare match value
	strh r6, [r2]

	; Reset and start in up mode
	ldrh r4, [r0]
	orrh r4, #0x0014
	strh r4, [r0]

	; Clear the I bit (enable interrupts)
	cpsie i
	bx lr

	        .endasmfunc

TimerA1_ISR:	.asmfunc			; TimerA1_ISR
	; TODO: Complete this ISR
	; Acknowledge
	ldr r0, TA1CTL
	ldrh r2, [r0]
	bich r2, #0x0001
	strh r2, [r0]

	; Do something
	push {lr}
	bl	LED_Out
	pop {lr}


	; Re-Init Timer A1
	push {lr}
	mov r6, #32768
	bl TimerA1_Init
	pop {lr}

	bx		lr
			.endasmfunc

LED_Out:	.asmfunc				; LED_Out
	; TODO: Complete this SR
	ldr r6, OUT_ptr
	ldrb r7, [r6]

	ldr r5, P2OUT
	ldrb r8, [r5]

	strb r7,[r5]
	add	r7,#1
	cmp r7,#7
	bgt rest
	strb r7,[r6]
	b skip
rest:
	mov r7, #0
	strb r7,[r6]

skip:
	bx	lr
			.endasmfunc

	        .end



Part 2 (it should be known that the code does not work, yet it runs):
			.thumb

			.data
OUT			.byte	0				; LED Output
CYC			.half	32760			; Cycles
CYC_step	.half	32760			; Cycle step

			.text
CYC_ptr		.word	CYC				; Pointer to cycles
CYC_step_ptr .word	CYC_step		; Pointer to cycle step
OUT_ptr		.word	OUT				; Pointer to LED Output

CYC_MAX		.half	32760			; Max value of cycles
CYC_MIN		.half	3276			; Min value of cycles

P1IN		.word	0x40004C00		; Port 1 Input
P1OUT		.word	0x40004C02		; Port 1 Output
P1DIR		.word	0x40004C04		; Port 1 Direction
P1REN		.word	0x40004C06		; Port 1 Resistor Enable
P1SEL0		.word	0x40004C0A		; Port 1 Select 0
P1SEL1		.word	0x40004C0C		; Port 1 Select 1
P1IV		.word	0x40004C0E		; Port 1 interrupt vector register
P1IES		.word	0x40004C18		; Port 1 interrupt edge select
P1IE		.word	0x40004C1A		; Port 1 interrupt enable
P1IFG		.word	0x40004C1C		; Port 1 interrupt flag

P2IN		.word	0x40004C01		; Port 2 Input
P2OUT		.word	0x40004C03		; Port 2 Output
P2DIR		.word	0x40004C05		; Port 2 Direction
P2REN		.word	0x40004C07		; Port 2 Resistor Enable
P2DS		.word	0x40004C09		; Port 2 Drive Strength
P2SEL0		.word	0x40004C0B		; Port 2 Select 0
P2SEL1		.word	0x40004C0D		; Port 2 Select 1

TA1CTL		.word	0x40000400		; TimerAx Control Register
TA1CCTL0	.word	0x40000402		; Timer_A Capture/Compare Control Register
TA1CCR0		.word	0x40000412		; Timer_A Capture/Compare Register
TA1EX0		.word	0x40000420		; Timer_A Expansion Register
TA1R		.word	0x40000410		; TimerA register

NVIC_IPR2	.word	0xE000E408		; NVIC interrupt priority 2
NVIC_IPR8	.word	0xE000E420		; NVIC interrupt priority 8
NVIC_ISER0	.word	0xE000E100		; NVIC enable register 0
NVIC_ISER1	.word	0xE000E104		; NVIC enable register 1

			.global asm_main
			.thumbfunc asm_main

			.global TimerA1_ISR
			.thumbfunc TimerA1_ISR

			.global Port1_ISR
			.thumbfunc Port1_ISR

asm_main:	.asmfunc		; main
	; TODO: Complete this SR
	push {lr}

	mov r6,#32768
	bl	Port1_Init
	bl 	Port2_Init
	ldr	r0, CYC_ptr
	ldrh r0,[r0]

	bl TimerA1_Init
	bl NVIC_Init

	pop {lr}
    bx      lr
    		.endasmfunc

Port1_Init:	.asmfunc				; Port 1 Init
	; TODO: Complete this SR

	ldrb 	r1,P1SEL0
	ldrb	r0,[r1]
	bicb 	r0, #0x12
	strb	r0,[r1]

	ldrb 	r1,P1SEL1
	ldrb	r0,[r1]
	bicb 	r0, #0x12
	strb	r0,[r1]

	ldrb 	r1,P1DIR
	ldrb	r0,[r1]
	bicb 	r0, #0x12
	strb	r0,[r1]

	ldrb 	r1,P1REN
	ldrb	r0,[r1]
	orrb 	r0, #0x12
	strb	r0,[r1]

	ldrb 	r1,P1OUT
	ldrb	r0,[r1]
	orrb 	r0, #0x12
	strb	r0,[r1]

	ldrb 	r1,P1IFG
	ldrb	r0,[r1]
	bicb 	r0, #0x12
	strb	r0,[r1]

	ldrb 	r1,P1IE
	ldrb	r0,[r1]
	orrb 	r0, #0x12
	strb	r0,[r1]

	ldrb 	r1,NVIC_IPR8
	ldrb	r0,[r1]
	andb 	r0, #0xE0000000
	orrb 	r0, #0x40000000
	strb	r0,[r1]

	ldrb	r1,NVIC_ISER1
	ldrb	r0,[r1]
	orrb 	r0, #0x00000008
	strb	r0,[r1]

	cpsie	i

	bx		lr						; Return to C program
	        .endasmfunc

; Init P2.0 - P2.2 and make output
Port2_Init:	.asmfunc				; Port 2 Init
	; TODO: Complete this SR

	ldrb 	r2,P2SEL0
	ldrb	r0,[r2]
	bicv 	r0, r0, #0x07
	strb	r0,[r2]

	ldrb 	r2,P2SEL1
	ldrb	r0,[r2]
	bicb 	r0, r0, #0x07
	strb	r0,[r2]

	ldrb 	r2,P2DIR
	ldrb	r0,[r2]
	orrb	r0, r0, #0x07
	strb	r0,[r2]

	ldrb 	r2,P2OUT
	ldrb	r0,[r2]
	bicb 	r0, r0, #0x07
	strb	r0,[r2]

	bx		lr
	        .endasmfunc

; Input: R6 = 0 to 65,535
TimerA1_Init:	.asmfunc			; TimerA1_Init
	; TODO: Complete this SR
	; Set the I bit (disable interrupts)
	cpsid i

	; Load addresses
	ldr r0, TA1CTL
	ldr r1, TA1CCTL0
	ldr r2, TA1CCR0
	ldr r3, TA1EX0

	; Halt Timer A1
	ldrh r4, [r0]
	bich r4, #0x0030
	strh r4, [r0]

	; SMCLK, ID = 0
	bich r4, #0x0F0
	orrh r4, #0x0110
	strh r4, [r0]

	; TA1EX0 = 0 (max = 7)
	ldrh r4, [r3]
	bich r5, #0x0007
	strh r5, [r3]

	; Compare mode (000), enable CCIE, clear CCIFG
	ldrh r4, [r1]
	bich r4, #0x00E0
	orrh r4, #0x0010
	bich r4, #0x0001
	strh r4, [r1]

	; Compare match value
	strh r6, [r2]

	; Reset and start in up mode
	ldrh r4, [r0]
	orrh r4, #0x0014
	strh r4, [r0]

	; Clear the I bit (enable interrupts)
	cpsie i

	bx		lr
	        .endasmfunc

NVIC_Init:	.asmfunc				; NVIC_Init
	; TODO: Complete this SR
	; Set the I bit (disable interrupts)
	cpsid i

	; Load addresses
	ldr r0, NVIC_IPR2
	ldr r1, NVIC_ISER0

	; IPR 2
	ldr r2, [r0]
	bic r2, #0x00700000
	orr r2, #0x00200000
	str r2, [r0]

	; Enable interrupt in NVIC
	ldr r2, [r1]
	orr r2, #0x00000400
	str r2, [r1]

	; Clear the I bit (enable interrupts)
	cpsie i

	bx		lr
	        .endasmfunc

TimerA1_ISR:	.asmfunc			; TimerA1_ISR
	; TODO: Complete this ISR

	; Acknowledge
	ldr r0, TA1CTL
	ldrh r2, [r0]
	bich r2, #0x0001
	strh r2, [r0]

	; Re-Init Timer A1
	push {lr}
	mov r6, #32768
	bl TimerA1_Init
	bl LED_Out
	pop {lr}

	push {lr}

	ldr r0, CYC_ptr
	ldrh r6,[r0]
	bl	TimerA1_Init
	pop	{lr}

	bx		lr
			.endasmfunc

Port1_ISR:	.asmfunc
	; TODO: Complete this ISR
	ldr r1, P1IFG
	ldrb r0, [r1]
	mov	r2, r1
	bicb r0, #0x12
	strb r0, [r1]
	andb r2,#0x12

	cmp r6, #0x02
	beq Increase
	cmp r6, #0x10
	beq Decrease

back:
	bx		lr
	        .endasmfunc
Increase:
	ldr r0, CYC_ptr
	ldrh r6,[r0]

	ldrh 	r1, CYC_MIN
	cmp 	r7, #0x01

	beq	back

	ldrh r0, CYC_step_ptr
	ldrh r3, [r0]
	bich 	r7,r7, r6
	addh	r1,r7
	strh	r1, [r7]

Decrease:
	ldr r0, CYC_ptr
	ldrh r6,[r0]

	ldrh 	r1, CYC_MAX
	cmp 	r7, #0x00
	beq		back
	ldrh r0, CYC_step_ptr
	ldrh r3, [r0]
	bich 	r7,r7, r6
	subh	r1, r7
	strh	r1, [r7]

; Input: R2 = 3-bit output
LED_Out:	.asmfunc				; LED_Out
	; TODO: Complete this SR
	ldr r6, P1IN
	ldrb r6, [r1]
	and r6, #0x12
	b skip

rest:
	mov r7, #0
	strb r7,[r6]

skip:
	bx	lr

	bx		lr
			.endasmfunc

	        .end
