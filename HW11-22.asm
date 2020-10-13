
;Rozell A. Dixon
;Digital Design Using Microprocessors
;ENEE 3582
;Homework #11.2


;------------------------------------------------------------------------------------------------------





	.MODEL SMALL
	.386
	.STACK

	.DATA

	FileNm		DB	"STDNTS.DBB",	0
	FileHdle	DW	0
	AVG		DD	0
	Count		DW	44

	.CODE

	INCLUDE		key.inc

main 	PROC FAR
	.STARTUP

	;Open existing file(3Dh) for reading (00h)
	MOV	AH,		3Dh
	MOV	AL,		00h
	LEA	DX,		FileNm
	INT	21h

	MOV	[FileHdle],	AX
	MOV	SI,		0

	MOV	BP,		[Count]		;Used to move to the same byte in the next record
	MOV	BX,		FileHdle
	MOV	CX,		0
	MOV	DX,		41
	MOV	AH,		42h
	MOV	AL,		00h
	INT	21h
L1:
	MOV	AH,		3Fh
	MOV	BX,		FileHdle
	MOV	CX,		3
	MOV	DX,		OFFSET AVG
	INT	21

	ADD	EDI,		[AVG]

	MOV	BX,		FileHdle
	MOV	CX,		0
	MOV	DX,		41
	MOV	AH,		42h
	MOV	AL,		01h
	INT	21h

	INC	ESI

	JNC	L1

	MOV	EAX,		EDI
	MOV	EDX,		0
	DIV	ESI
	MOV	[AVG],		EAX

	;File Close:  INT 21h, AH = 3E
	MOV	AX,		3E00h
	MOV	BX,		FileHdle
	INT	21h

	.EXIT
main	ENDP
END