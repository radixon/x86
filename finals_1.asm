
; Delete all files with the asm extension in
; C:/PROGS directory

	.MODEL SMALL
	.386
	.STACK

	.DATA

	Fname	 DB	"E:\Practice\*.txt", 0
	StartDTA DB	21 DUP (?)
	Atrib	 DB	?
	FTime	 DW	?
	FDate	 DW	?
	FSize	 DD	?
	FileNm	 DB	13 DUP (0)
	error	 DB	"This program is starting to piss me off.", 0
	error2	 DB	"Fuck Dem Haters. ", 0

	.CODE

	INCLUDE	key.inc

main PROC FAR
.STARTUP


	MOV	ECX,	1

L1:
	MOV	AH,	1Ah
	MOV	DX,	OFFSET StartDTA
	INT	21h


	MOV	AH,	4Eh			; Get first matching file
	MOV	DX,	OFFSET Fname
	MOV	CX,	0
	INT	21h

	str_out FileNm
	JC	EXIT1



	MOV	AH,	41h			; Delete file command
	MOV	DX,	OFFSET FileNm
	INT	21h

	.IF	CARRY?
		str_out error

	.ENDIF



EXIT1:


	.EXIT
main ENDP
END