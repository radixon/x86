
; Delete all files with the asm extension in
; C:/PROGS directory

	.MODEL SMALL
	.386
	.STACK

	.DATA

	error	 DB	"This program is starting to piss me off.", 0
	error2	 DB	"Fuck Dem Haters. ", 0
	Fname	 DB	"E:\PRACTICE\*.*", 0
	StartDTA DB	21 DUP (?)
	Atrib	 DB	?
	FTime	 DW	?
	FDate	 DW	?
	FSize	 DD	?
	FileNm	 DB	13 DUP (?)

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
	MOV	CX,	00000010b
	INT	21h

	str_out FileNm
	.IF	CARRY?
		JMP	EXIT1
	.ENDIF

	;MOV	AH,	43h
	;MOV	AL,	0
	;MOV	CX,	02
	;MOV	DX,	OFFSET Fname
	;INT	21h


	MOV	AH,	41h			; Delete file command
	MOV	DX,	OFFSET FileNm
	INT	21h


	MOV	AH,	4Fh
	INT	21h

	JNC	L1

EXIT1:


	.EXIT
main ENDP
END