.thumb
 
.data
NUMNEG	.word	0
TOTAL		.word	0
SBLK		.word	1,126,-8,-63,-44,-115,28	; Source block (initialized)
SBLKEND	.word	-1					; Source block end
DBLK		.usect	".bss",2,2	; Destination block (uninitialized)
 
.text
SBLKPTR	.word	SBLK			; Pointer to beginning of Source Block
SBLKENDPTR	.word	SBLKEND		; Pointer to ending of Source Block
DBLKPTR	.word	DBLK		; Pointer to beginning of Destination Block
NUMNEGPTR	.word	NUMNEG		; Pointer to NUMNEG
TOTALPTR	.word	TOTAL			; Pointer to TOTAL
 
.global asm_main
.thumbfunc asm_main
 
 
asm_main:	.asmfunc		; ASM main
 
ldr 	r0,SBLKPTR			; starting at source block
ldr 	r1,DBLKPTR			; making destination block
ldr 	r2,NUMNEGPTR		; making total negative values variable
ldr		r3,TOTALPTR	; making total number count variable
ldr		r4,SBLKENDPTR	; making an ending point be SBLKENDPTR
 
loop:
; copy from SBLKPTR to DBLKPTR 
ldr 	r5,[r0]			; loading values in SBLKPTR in r5
str		r5, [r1]		; loading values from r5 to DBLKPTR
 
;check if number is negative	
cmp		r0, #0	; comparing if the value of SBLKPTR is greater than 0	
blt 	inc_numneg		; connecting to inc_numneg branch if true
 
ret:
 
; increase TOTAL
cmp 	r3, r4		; comparing if TOTAL is equal to SBLKENDPTR
add		r3,#1		; increasing TOTAL by 1 if not
str		r0,[r3]	; storing the value

; Update pointers 
mov 	r0,#8			; moving SBLKPTR address down
mov		r1,#4		; moving DBLKPTR address down
 
; check if done	
cmp 	r0, r4		; comparing if SBLKPTR value is equal to SBLKENDPTR value
bne 	loop			; restarting the loop if not equal
 	
bx		lr
 
inc_numneg:				; increasing NUMNEG by 1
cmp		r0,r4			; checking if value of
add		r2,#1			; increasing the NUMNEG value by 1
str		r0,[r2]
b		ret									
 
        	.endasmfunc
        	.end
