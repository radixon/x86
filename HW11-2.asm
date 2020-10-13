
;Write 100 records each is 112B











	.MODEL SMALL
	.386
	.STACK

	.DATA

	FileNm	DB	"logfile.txt",	0
	FileHdle	DW	0
	Rec		DB	112 DUP (0)

	.CODE

	INCLUDE		key.inc

main 	PROC FAR
	.STARTUP


	;Open existing file(3Dh) for writing (01h)
	;Stores the file handle(MOV BX, AX)
	MOV	AH,		3Dh
	MOV	AL,		01h
	LEA	DX,		FileNm
	INT	21h

	MOV	[FileHdle],	AX
	MOV	BP,		100
	MOV	BX,		FileHdle

	;Write records into the file one at a time
L1:
	MOV	AH,		40h
	MOV	CX,		112
	MOV	DX,		OFFSET Rec
	INT	21h
	DEC	BP
	JNZ	L1

	;File Close:  INT 21h, AH = 3E
	MOV	AX,		3E00h
	INT	21h


	.EXIT
main	ENDP
END