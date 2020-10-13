;Display the command tail.  Turn all lower case character into
;upper case before displaying the tal.  Use string instructions.

	.MODEL SMALL
	.386
	.STACK

	.DATA

	Array	DB	0

	.CODE

	INCLUDE	key.inc

main 	PROC FAR
	.STARTUP


	MOV	DX,	0
	MOV	SI,	81h
	MOV	AH,	9
	CMP BYTE PTR ES:[SI-1], 1
	JBE ENTERKEY




	MOV	CL,	ES:[SI-1]
L1:
	.IF (BYTE PTR ES:[SI] >= 61h && BYTE PTR ES:[SI] <= 7Ah)
		SUB BYTE PTR ES:[SI],	20h
	.ENDIF

	INC	SI
	LOOP	L1

	MOV	DX,	ES:[SI]
	INT	21h



	;MOV	AH,	41h			; Delete file command
	;MOV	DX,	ES:[SI]
	;INT	21h

ENTERKEY:
	MOV	DX,	0Ah
	INT	21h
	MOV	DX,	0Dh
	INT	21h


	.EXIT
main	ENDP
END