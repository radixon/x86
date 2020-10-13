;display the command tail.  Turn all lower case character
;into upper case before displaying the tail.  Use string
;instructions


	.MODEL SMALL
	.386
	.STACK

	.DATA


	.CODE

	INCLUDE		key.inc

main	PROC  FAR
	.STARTUP


	MOV	SI,	81h		;OFFSET OF FIRST CHARACTER
	MOV	AH,	6		;DISPLAY 1 CHARACTER AT A TIME
	CMP BYTE PTR ES:[SI-1], 1	;SI-1 CONTAINS NUMBER OF BYTES
	JBE 	ENTERKEY		;IF THERE IS ONLY ONE BYTE THERE IS NO COMMAND TAIL

	MOV	CL,	ES:[SI-1]	;LOOP THE NUMBER OF BYTES IN COMMAND TAIL
L1:
	MOV	DL,	ES:[SI+1]		;FIRST LETTER IN THE COMMAND TAIL
	.IF	DL >= 41h && DL <= 5Ah
		ADD	DL,	20h
	.ELSEIF	DL >= 61h && DL <= 7Ah
		SUB	DL,	20h
	.ENDIF

	INT	21h
	INC	SI
	LOOP L1

ENTERKEY:
	MOV	DL,	0Ah
	INT	21h
	MOV	DL,	0Dh
	INT	21h

	.EXIT
main	ENDP
END