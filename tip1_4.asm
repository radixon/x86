;Open a file and convert all lower case characters into upper
;case characters. File name is provided by the variable fname.

	.MODEL SMALL
	.386
	.STACK

	.DATA

	Fname	DB	"logfile.txt"
	buffer	DB	256 DUP (?)

	.CODE

main 	PROC FAR
	.STARTUP



	MOV	AX,	3D02h		;AH = 3D open existiong file  AL = 00 reads to file
	MOV	DX,	OFFSET Fname	;DS:DX pooints to an ASCIIZ string with the filename
	INT	21h
	MOV	BX,	AX


	;File Read
	MOV	AH,	3Fh
	MOV	CX,	LENGTHOF buffer
	MOV	DX,	OFFSET buffer
	INT	21h
	PUSH	AX


	MOVZX	ECX,	AX
	MOV	SI,	0

L1:
	.IF	([buffer+SI] >= 61h && [buffer+SI] <= 7Ah)
		SUB 	[buffer+SI],	20h
	.ELSEIF	([buffer+SI] >= 41h && [buffer+SI] <= 5Ah)
		ADD	[buffer+SI],	20h
	.ENDIF
	INC	SI
LOOP	L1

WR:
	POP	AX
	MOV	CX,	AX
	MOV	AH,	40h		;AH 40 write to file or device
	MOV	DX,	OFFSET buffer	;DS:DX points to an output buffer
	INT	21h

	;File Close:  INT 21h, AH = 3Eh
	MOV	AH,	3Eh
	INT	21h



	.EXIT
main	ENDP
END