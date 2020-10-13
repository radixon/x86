;Display the command tail.  Turn all lower case character into
;upper case before displaying the tal.  Use string instructions.

	.MODEL SMALL
	.386
	.STACK

	.DATA

	Array	DB	0

	.CODE


main 	PROC FAR
	.STARTUP



	MOV	SI,	81h
	MOV	AH,	6
	CMP BYTE PTR ES:[SI-1], 1
	JBE ENTERKEY




	MOV	CL,	ES:[SI-1]
	MOVZX	ECX,	CL
L1:
	.IF (BYTE PTR ES:[SI] >= 61h && BYTE PTR ES:[SI] <= 7Ah)
		SUB BYTE PTR ES:[SI],	20h
	.ENDIF

	MOV	DL,	ES:[SI]
	INT	21h

	INC	SI
	LOOP	L1

ENTERKEY:
	MOV	DL,	0Ah
	INT	21h
	MOV	DL,	0Dh
	INT	21h


	.EXIT
main	ENDP
END