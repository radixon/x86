TITLE Interrupts and Input/Output Devices
; Rozell A. Dixon
; ENEE 3512, Microprocessor Design Lab, Lab 3
; April 21, 2008
; Interrupts and Input/Output Devices

.MODEL SMALL
.386
.STACK

.DATA
welcom	DB	"Welcome to my world. Please enter a hex digit and let me handle the rest."
error	DB	"Invalid. Number Entered By User Is Too Large. "
num	DD	0
check	DW	0
space	DB	20h
newline	DB	0Dh,  0Ah

.CODE

INCLUDE	io.inc

main	PROC  FAR
	.STARTUP


	str_out	welcom
	str_out	newline

	PUSH	num				; BP + 4
	PUSH	OFFSET check			; BP + 2

	.WHILE	(check != -1 && check < 9)

		CALL	numIN
		str_out space

		.IF (check < 9)
			CALL  num2base
		.ENDIF

		str_out	newline

	.ENDW

	ADD	SP,	6

	.EXIT
main	ENDP



numIN	PROC


	PUSH	BP
	MOV	EBP,	ESP

	PUSHAD

	MOV	EBX,		[BP+6]
	MOV	SI,		[BP+4]

INPUT1:
	KEYIN

	.IF (AL >= '0' && AL <= '9') || (AL >= 'A'  && AL <= 'F') || (AL >= 'a' && AL <= 'f')
		ECHOES

		.IF	(AL >= '0') && (AL <= '9')
			SUB	AL,	30h
		.ELSEIF (AL >= 'A') && (AL <= 'F')
			SUB	AL,	37h
		.ELSE
			SUB	AL,	57h
		.ENDIF

		SHL	EBX,	4
		ADD	BL,	AL
		MOV	[BP+6],	EBX
		INC	WORD PTR [SI]

	.ELSE
		.IF (AL == 0Dh)
			MOV WORD PTR [SI], -1
			JMP  FINISH1
		.ELSE
			JMP INPUT1
		.ENDIF
	.ENDIF


	.IF (WORD PTR [SI] > 8)
		str_out space
		str_out error
	.ENDIF
FINISH1:
	POPAD
	POP	BP

	RET



numIN	ENDP


num2base	PROC


	PUSH	BP
	MOV	EBP,	ESP

	PUSHAD

	MOV	EAX,	[BP+6]
	MOV	EBX,	10
	MOV	ECX,	0

DIV1:
	CDQ
	DIV	EBX
	PUSH	EDX
	INC	CX
	CMP	EAX,	0
	JA	DIV1

RETNUM1:
	POP	EDX
	MOV	EAX,	EDX
	CMP	AL,	9h
	JA	CONVERT1
	ADD	AL,	30h
	JMP	PRINT1

CONVERT1:
	ADD	AL,	37h

PRINT1:
	ECHOES

LOOP	RETNUM1

	POPAD
	POP	BP
	RET


num2base	ENDP
END