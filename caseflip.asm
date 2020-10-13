;---------------------------------------------------------------------------------------------
;Write a MACRO called caseflip that converts the
;character in a string from upper to lower case
;and from lower case to upper case.
;---------------------------------------------------------------------------------------------



	.MODEL SMALL
	.386
	.STACK

	.DATA
	log	DB	0

.CODE
main	PROC  FAR
	.STARTUP


	KEYIN		MACRO
			LOCAL	L1
			MOV	AH,	6
			MOV	DL,	-1
	L1:
			INT 	21h
			JZ	L1
	ENDM



	CASE		MACRO	str,	len
			LOCAL	L1, L2, L3, L4
			MOV	SI,	0
		L1:
			MOV	AL,	[str+SI]
			CMP	AL,	41h
			JB	L3
			CMP	AL,	5Ah
			JA	L2
			ADD	AL,	20h
			INC	SI
			CMP	SI,	len
			JA	L4
			JMP	L1
		L2:
			CMP	AL,	61h
			JB	L3
			CMP	AL,	7Ah
			JA	L3
			SUB	AL,	20h
			INC	SI
			CMP	SI,	len
			JA	L4
			JMP	L1
		L3:
			INC	SI
			CMP	SI,	len
			JA	L4
			JMP	L1
		L4:
			MOV	DX,	OFFSET str
			MOV	AH,	9h
			INT	21h
	ENDM



			MOV	SI,	0
	L5:
			KEYIN
			CMP	AL,	1Bh
			JE	DONE
			MOV	[log+SI], AL
			INC	SI
			JMP	L5

	DONE:
			CASE	log,	SI

	.EXIT
main	ENDP
END