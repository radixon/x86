; Deletes all hidden files in the pathe C:\Practice


	.MODEL SMALL
	.386
	.STACK

	INCLUDE G:\Microprocessors -- 3582\Finals Practice\key.inc

	.DATA

	filespec	DB	"C:\Practice\"
	filecont	DB	"*.*", 0
	startDTA	DB	21 DUP (0)
	Atrib		DB	?
	FTime		DW	?
	FData		DW	?
	FSize		DD	?
	FName		DB	13 DUP (0)

	.CODE
main	PROC	FAR
	.STARTUP

	; Set disk transfer address
	MOV	AH,	1Ah
	MOV	DX,	OFFSET startDTA
	INT	21h

	; Find first matching file
	MOV	AH,	4Eh
	MOV	CX,	00000010b
	MOV	DX,	OFFSET filespec
	INT	21h

	; Set direction flag
	STD

	; Make ES == DS
	MOV	AX,	DS
	MOV	ES,	AX

L1:
	; SI points to source
	MOV	SI,	OFFSET filespec + LENGTHOF filespec - 1

	; DI points to target
	MOV	DI,	OFFSET FName - 1

	; Set rep counter
	MOV	CX,	LENGTHOF filespec

	; Copy bytes
	REP MOVSB

	; Display the file name
	str_out FNAME

	; Delete the file
	MOV	AH,	41h
	MOV	DX,	OFFSET FName - LENGTHOF filespec
	INT	21h

	; Find the next file
	MOV	AH,	4Fh
	INT	21h
	JNC	L1

	.EXIT
main	ENDP
END