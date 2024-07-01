1.	NOT Gate

			.thumb

			.text			; Puts code in ROM
out 			.word	0

			.text
in 			.word	1
out_ptr		.word	out
in_ptr			.word	in
			.global asm_main
			.thumbfunc asm_main

asm_main:	.asmfunc		; main
	; NOT gate
	ldr		r0, in_ptr		; load address of 'in' in r0
	ldr		r1,[r0]		; in[0]
	mvn		r2,r1			; r2 = in[0]
	bfc 		r2,#1,#31		; r2 clears extra bits
ldr 		r0, out_ptr		; load address of out into r0
	str 		r2,[r0]		; store r2 to 'out'

	bx		lr			; return to C program

	 	       .endasmfunc
	       	.end

2.	3-Input AND Gate
			.thumb

			.text			; Puts code in ROM
out 			.word	0

			.text
in 			.word	0,1,0
out_ptr		.word	out
in_ptr			.word	in
			.global asm_main
			.thumbfunc asm_main

asm_main:	.asmfunc		; main
	; AND gate
	ldr		r0, in_ptr		; load address of 'in' in r0
	ldr		r1,[r0]		; in[0]
	ldr		r2,[r0,#4]		; in[1]
	ldr		r3,[r0,#8]		; in[2]
	and		r4,r1,r2		; r4 = in[0] and in[1] and in[2]
	ldr 		r0, out_ptr		; load address of out into r0
	str		r4,[r0]		; store r4 to 'out'
	and 		r5,r3,r4		; r5 = in[1] and in[2]
	ldr 		r0, out_ptr		; load address of out into r0
	str 		r5,[r0]		; store r5 to 'out'


	bx		lr			; return to C program

	        	.endasmfunc
	        	.end

3.	3-Input OR Gate
			.thumb

			.text			; Puts code in ROM
out 			.word	0

			.text
in 			.word	0,1,0
out_ptr		.word	out
in_ptr			.word	in
			.global asm_main
			.thumbfunc asm_main

asm_main:	.asmfunc		; main
	; OR gate
	ldr		r0, in_ptr		; load address of 'in' in r0
	ldr		r1,[r0]		; in[0]
	ldr		r2,[r0,#4]		; in[1]
	ldr		r3,[r0,#8]		; in[2]
	orr		r4,r2,r1		; r4 = in[0] or in[1]
	ldr 		r0, out_ptr		; load address of out into r0
	str		r4,[r0]		; store r4 to 'out'
	orr 		r5,r4,r3		; r5 = in[0] or in[1] or in[2]
	ldr 		r0, out_ptr		; load address of out into r0
	str 		r5,[r0]		; store r5 to 'out'


	bx		lr				; return to C program

	        	.endasmfunc
	        	.end

4.	2-Input XOR Gate

			.thumb

			.text			; Puts code in ROM
out 			.word	0

			.text
in 			.word	0,1,0
out_ptr		.word	out
in_ptr			.word	in
			.global asm_main
			.thumbfunc asm_main

asm_main:	.asmfunc		; main
	;	XOR gate
	ldr		r0, in_ptr		; load address of 'in' in r0
	ldr		r1,[r0]		; in[0]
	ldr		r2,[r0,#4]		; in[1]
	eor		r3,r2,r1		; r3 = in[0] xor in[1]
	ldr 		r0, out_ptr		; load address of out into r0
	str		r3,[r0]		; store r3 to 'out'

	bx		lr			; return to C program

	       	.endasmfunc
	        	.end

5.	Sum-of-Products (SoP)
.thumb

			.text			; Puts code in ROM
out 			.word	0

			.text
in 			.word	0,0,0
out_ptr		.word	out
in_ptr			.word	in
			.global asm_main
.thumbfunc asm_main

asm_main:	.asmfunc		; main
	; SOP of m(1,2,6,7)
;  declaring values
ldr		r0, in_ptr		; load address of 'in' in r0
ldr		r1,[r0]		; in[0]
ldr		r2,[r0, #4]		; in[1]
ldr 		r3,[r0, #8]		; in[2] 
; declaring future NOT values
ldr 		r4,[r0, #12]	; in[3]
ldr 		r5,[r0, #16]	; in[4]
ldr		r6,[r0, #20]	; in[5]
 
; NOT gates for variables
mvn		r4, r1		; r4 = in[0]
bfc 		r4,#1,#31		; r4 clears extra bits
mvn		r5, r2		; r5 = in[0]
bfc 		r5,#1,#31		; r5 clears extra bits
mvn		r6, r3		; r6 = in[0]
bfc 		r6,#1,#31		; r6 clears extra bits
ldr 		r0, out_ptr		; load address of out into r0
str 		r4,[r0]		; store r4 to 'out'
str 		r5,[r0]		; store r5 to 'out'
str		r6,[r0]		; store r6 to 'out'
 
; AND gates
and 	r4,r1,r2			; r4 = in[0] and in[1] 
ldr 	r4,[r0]			; load address of out into r0
and 	r5, r2,r6			; r5 = in[1] and in[5] 
and 	r6, r3			; r6 = in[0] and in[1] and in[2]
 
; OR gates			
orr 	r4,r1,r2			; r4 = in[0] or in[1]	
ldr 	r4,[r0]			; load address of out into r0
orr 	r5, r2,r6			; r5 = in[1] or in[5]
orr 	r6, r3			; r6 = in[5] or in[2]
bx		lr			; return to C program

	       	.endasmfunc
	        	.end

6.	Product-of-Sums (PoS)

.thumb

			.text			; Puts code in ROM
out 			.word	0

			.text
in 			.word	0,0,0
out_ptr		.word	out
in_ptr			.word	in
			.global asm_main
.thumbfunc asm_main

asm_main:	.asmfunc		; main
;POS of m(2,3,4,5,6,9,10,11)
; decalring values
ldr		r0, in_ptr		; load address of 'in' in r0
ldr		r1,[r0]		; in[0]
ldr		r2,[r0, #4]		; r2 = in[1]
ldr 		r3,[r0, #8]		; r3 = in[2]
ldr 		r4,[r0, #12]	; r4 = in[3]
; declaring future not variables
ldr 		r5,[r0, #16]	; in[4]
ldr		r6,[r0, #20]	; in[5]
ldr		r7,[r0, #24]	; in[6]	
ldr		r8,[r0, #28]	; in[7]
 

; NOT gates for variables
mvn		r5, r1		; r5 = in[0]
bfc 		r5,#1,#31		; r5 clears extra bits
mvn		r6, r2		; r6 = in[0]
bfc 		r6,#1,#31		; r6 clears extra bits
mvn		r7, r3		; r7 = in[0]
bfc 		r7,#1,#31		; r7 clears extra bits
mvn		r8, r4		; r8 = in[0]
bfc 		r8,#1,#31		; r8 clears extra bits
ldr 		r0, out_ptr		; load address of out into r0
str 		r5,[r0]		; store r5 to 'out'
str 		r6,[r0]		; store r6 to 'out'
str		r7,[r0]		; store r7 to 'out'
str		r8,[r0]		; store r8 to 'out'
 
; OR gates
orr	r4,r1,r2			; r4 = in[0] and in[1]
ldr 	r4,[r0]			; load address of out into r0
orr 	r5, r2,r6			; r5 = in[1] and in[5] 
orr 	r6, r5			; r6 = in[5] and in[4] 
orr 	r7,r8				; r7 = in[6] and in[7] 

; AND gates
and 	r4,r1,r2			; r4 = in[0] and in[1]
ldr 	r4,[r0]			; load address of out into r0
and 	r5, r2,r6			; r5 = in[1] and in[5] 
and 	r6, r5			; r6 = in[5] and in[4] 
and 	r7,r8				; r7 = in[6] and in[7] 
bx		lr			; return to C program

	       	.endasmfunc
	        	.end
