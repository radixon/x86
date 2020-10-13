TITLE String Conversion and Stack
; Rozell A. Dixon
; ENEE 3512, Microprocessor Design Lab, Lab 3
; March 28, 2008
; String Conversion and Stack

.MODEL SMALL
.386
.STACK

.DATA
str_bin	BYTE	"11111"
num	WORD	0
str_dec	BYTE	8 DUP (0)

.CODE
main	PROC  FAR
	.STARTUP


	PUSH	num
	PUSH	OFFSET str_bin
	PUSH	LENGTHOF str_bin
	CALL	str2dec
	POP	num
	PUSH	OFFSET str_dec
	PUSH	num
	PUSH	LENGTHOF str_dec
	CALL	dec2str



	.EXIT
main	ENDP



str2dec	PROC

	PUSH	BP
	MOV	EBP,		ESP

	PUSHAD

	;Clears Registers And Sets The Size Of ECX
	MOV	ECX,		[BP+4]
	MOV	EAX,		0
	MOV	EBX,		[BP+6]

	 ; Puts The Correct Number Into num
L1:
	MOV	AL,		[EBX]
	SUB	AL,		30h
	SHL	WORD PTR [EBP+8],1h
	ADD	[EBP+8],	AX
	INC	EBX
LOOP	L1

	POPAD

	POP	BP
	RET	4



str2dec	ENDP


dec2str	PROC

	PUSH	BP
	MOV	EBP,		ESP
	PUSHAD


	; Converts To Base 10
	 MOV	AX,		[BP+6]
	 MOV	ECX,		[BP+4]
	 MOV	BX,		10
L2:
	 DIV	BX
	 PUSH	DX
	 MOV	DX,		0
LOOP	 L2


	 ; Places ASCII Hex Into str_hex
	 MOV	ECX,		[BP+4]
	 MOV	DI,		[BP+8]
L3:
	 POP	DX
	 CMP	DX,		9
	 JA	Letter
	 ADD	DX,		30h
	 JMP	Done1
Letter:
	 ADD	DX,		37h
Done1:
	 MOV	[DI],	DL
	 INC	DI
LOOP	 L3

	POPAD
	POP	BP
	RET	6


dec2str	ENDP
END