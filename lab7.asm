TITLE Arithmetic and Conditional Processing
; Rozell A. Dixon
; ENEE 3512, Microprocessor Design Lab, Lab 3
; February 29, 2008
; Arithmetic and Conditional Processing

.MODEL SMALL
.386
.STACK

.DATA
arrayX	DB	5,29,49,111,3,23,17,85,121,102
arrayY	DB	10 DUP (?)
arrayZ	DB	10 DUP (?)


.CODE
main	PROC  FAR
	.STARTUP

	 ; Code Segment 1
	 MOV	EBX, 		0
	 MOV	SI,		0
	 MOV	ECX,		1

	 ; Determine ECX
L1:
	 CMP	EBX,		10
	 JZ	Terminate
	 MOVZX	AX,		[arrayX+EBX]
	 MOV	CL,		2
	 DIV	CL
	 MOVZX	ECX,		AL
	 MOV	DL,		1
	 JMP	L2
LOOP	 L1

	 ; Is X Prime
L2:
	 MOVZX	AX,		[arrayX+EBX]
	 INC	DL
	 DIV	DL
	 CMP	AH,		0
	 JZ	NotPrime
LOOP	 L2

	 ; X is Prime
	 MOVZX	AX,		[arrayX+EBX]
	 MOV	BP,		10
	 MUL	BP
	 MOV	SI,		AX
	 MOV	BP,		3
	 DIV	BP
	 ADD	SI,		DX
	 MOV	AX,		SI
	 MOV	DX,		0
	 DIV	BP
	 MOV	[arrayY+EBX],	AL
	 JMP	Grade

	 ; X is Prime
NotPrime:
	 MOVZX	AX,		[arrayX+EBX]
	 MOV	BP,		7
	 MUL	BP
	 MOV	BP,		9
	 DIV	BP
	 MOV	[arrayY+EBX],	AL
	 JMP	Grade
LOOP 	 NotPrime

	 ; Y >= 90
GAH:
	 MOV	[arrayZ+EBX],	10
	 INC	EBX
	 JMP L1
LOOP	 GAH

	 ; 80 <= Y <= 89
GBH:
	 MOV	[arrayZ+EBX],	11
	 INC	EBX
	 JMP L1
LOOP	 GBH

	 ; 70 <= Y <= 79
GCH:
	 MOV	[arrayZ+EBX],	12
	 INC	EBX
	 JMP	L1
LOOP	 GCH

	 ; 60 <= Y <= 69
GDH:
	 MOV	[arrayZ+EBX],	13
	 INC	EBX
	 JMP	L1
LOOP	 GDH

	 ; Determines which grade you receive
Grade:
	 MOVZX	AX,		[arrayY+EBX]
	 CMP	AX,		89
	 JA	GAH
	 CMP	AX,		79
	 JA	GBH
	 CMP	AX,		69
	 JA	GCH
	 CMP	AX,		59
	 JA	GDH
	 MOV	[arrayZ+EBX],	15
	 INC	EBX
	 JMP	L1
LOOP	 Grade

	 ; Ends program
Terminate:
	 MOV	ECX,		1
	 ; This exits the program to .EXIT
Loop	 Terminate

	.EXIT
main	ENDP
END