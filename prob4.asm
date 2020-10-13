; Displays the message "File exist" if a file exist and
; "File does not exist" if ther is no file.  "Error" for
; any other error.  The name of the file in question is
; entered as a command tail.

	.MODEL SMALL
	.386
	.STACK

	INCLUDE key.inc

	.DATA

	startDTA	DB	21 DUP (0)
	Atrib		DB	?
	FTime		DW	?
	FData		DW	?
	FSize		DD	?
	FName		DB	13 DUP (0)
	PSP		DB	?

	.CODE
main	PROC	FAR
	.STARTUP

	; The array counter
	MOV	DI,	0

	; Command tail segment
	MOV	SI,	81h
	MOV	CL,	ES:[SI-1]

	; Set up the command tail for input and store into a sring array
	.WHILE BYTE PTR ES:[SI] != 0Dh
		MOV	AL,	ES:[SI]
		MOV	PSP[DI], AL

		; Increment the command tail and string array
		INC	SI
		INC	DI
	.ENDW

	; Reset the array to read back to DI+0
	MOV	PSP[DI],	0

	; Setup DTA
	MOV	AH,	1Ah
	MOV	DX,	OFFSET startDTA
	INT	21h

	; Find first matching file
	MOV	AH,	4Eh
	MOV	CX,	0
	MOV	DX,	OFFSET PSP
	INT	21h

	; SET the Direction Flag
	STD

	; Set DS == ES
	MOV	AX,	DX
	MOV	ES,	AX

L1:
	; Set the source
	MOV	SI,	OFFSET PSP + LENGTHOF PSP - 1

	; Set the target
	MOV	DI,	OFFSET FName - 1

	; Set the number REP's
	MOV	CL,	ES:[SI-1]

	; Copy the bytes
	REP	MOVSB

	; Display the file name
	str_out	FName

	; Delete the file
	MOV	AH,	41h
	MOV	DX,	OFFSET FName - LENGTHOF PSP
	INT	21h

	; Find the next file
	MOV	AH,	4Fh
	INT	21h
	JNC	L1

	.EXIT
main	ENDP
END