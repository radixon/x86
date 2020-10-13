;delete all files with the asm extension
;in C:/Progs directory


	.MODEL SMALL
	.386
	.STACK

	.DATA

	filespec	DB	"E:\PRACTICE\"
	filexten	DB	"*.asm", 0
	startDTA	DB	21 DUP (0)
	Atrib		DB	?
	FTime		DW	?
	FData		DW	?
	FSize		DD	?
	FName		DB	13 DUP (0)

.CODE

	INCLUDE	key.inc

main	PROC  FAR
	.STARTUP


	MOV	DX,	OFFSET startDTA
	MOV	AH,	1Ah
	INT	21h

	MOV	DX,	OFFSET filespec
	MOV	CX,	0
	MOV	AH,	4Eh
	INT	21h

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