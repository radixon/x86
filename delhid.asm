;delete all hidden files in
;C:\PROGS directory


	.MODEL SMALL
	.386
	.STACK

	.DATA

	filespec	DB	"E:/PRACTICE/"
	filexten	DB	"*.*", 0
	startDTA	DB	21 DUP (?)
	Atrib		DB	?
	FTime		DW	?
	FDate		DW	?
	FSize		DD	?
	FName		DB	13 DUP (0)

	.CODE

	INCLUDE		key.inc

main	PROC	FAR
	.STARTUP

	MOV	DX,	OFFSET startDTA
	MOV	AH,	1Ah
	INT	21h

	MOV	DX,	OFFSET filespec
	MOV	CX,	2
	MOV	AH,	4Eh

L1:
	JC	FINISH
	str_out	FName


	MOV	DX,	OFFSET FName
	MOV	AH,	41h
	INT	21h

	MOV	AH,	4Fh
	INT	21h
	JMP	L1

FINISH:

	.EXIT
main	ENDP
END