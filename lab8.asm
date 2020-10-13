TITLE String Conversion and Stack
; Rozell A. Dixon
; ENEE 3512, Microprocessor Design Lab, Lab 3
; March 28, 2008
; String Conversion and Stack

.MODEL SMALL
.386
.STACK

.DATA
str_bin	BYTE	"100100101101"
num	WORD	0
str_hex	BYTE	4 DUP (0)

.CODE
main	PROC  FAR
	.STARTUP

	 ;Clears Registers And Sets The Size Of ECX
	 MOV	ECX,		SIZEOF str_bin
	 MOV	EDX,		0
	 MOV	EAX,		0
	 MOV	EBX,		0

	 ; Puts The Correct Number Into num
L1:
	 MOV	AL,		[str_bin+EBX]
	 SUB	AL,		30h
	 SHL	num,		1h
	 ADD	num,		AX
	 INC	EBX
LOOP	 L1


	 ; Converts From Base 10 To Base 16
	 MOV	AX,		num
	 MOV	ECX,		4
	 MOV	BX,		16
L2:
	 DIV	BX
	 PUSH	DX
	 MOV	DX,		0
LOOP	 L2


	 ; Places ASCII Hex Into str_hex
	 MOV	ECX,		4
	 MOV	EBX,		0
L3:

	 POP	DX
	 CMP	DX,		9
	 JA	Letter
	 ADD	DX,		30h
	 JMP	Done1
Letter:
	 ADD	DX,		37h
Done1:
	 MOV	[str_hex+EBX],	DL
	 INC	EBX
LOOP	 L3

	 ; Ends Program
END1:


	.EXIT
main	ENDP
END