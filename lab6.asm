TITLE Arithmetic Operations
; Rozell A. Dixon
; ENEE 3512, Microprocessor Design Lab, Lab 3
; February 29, 2008
; Arithmetic Operations

.MODEL SMALL
.386
.STACK

.DATA
arrayA	DB	1,-6,126,47,-120,-55,18,39,109,-72,95,-26,84,111,-60
arrayB	DW	-7942,28337,-9079,19875,-29884,4951,-28,6247,-9897,11775,30403,-1050,5432,328,5
arrayX	DD	15 DUP (?)				    ; Define array3
arrayY	DD	15 DUP (?)				    ; Define array4
COUNT	DD	0

.CODE
main	PROC  FAR
	.STARTUP

	; Code Segment 1
	MOV	EBX, 		0
	MOV	ECX, 		15
L1:

	; X = 2A + B
	MOVSX	DI,		[arrayA+EBX]
	MOV	AX,		2
	IMUL	DI
	MOVSX	EDI,		[arrayB+EBX*2]
	MOVSX	EAX,		AX
	ADD	EDI,		EAX
	MOV	[arrayX+EBX*4],	EDI

	;Y = X - B/5
	MOVSX	EAX,		[arrayB+EBX*2]
	MOV 	EDI,		5
	CDQ
	IDIV	EDI
	MOV	EDI,		[arrayX+EBX*4]
	SUB	EDI,		EAX
	MOV	[arrayY+EBX*4],	EDI

	INC	EBX
LOOP	L1


	.EXIT
main	ENDP
END