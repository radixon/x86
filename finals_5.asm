; Displays the message "File exist" if a file exist and
; :File does not exist" if there is no file.  "Error"
; for any other error.  The name of the file in question
; is entered as a command tail.

	.MODEL SMALL
	.386
	.STACK
	
	INCLUDE G:\Microprocessors -- 3582\Finals Practice\key.inc
	
	.DATA
	fileExist	DB	"File Exist", 0
	NoFile		DB	"File Doesn't Exist", 0
	fileError	DB	"File Error", 0
	startDTA	DB	21 DUP (?)	; First 21 bytes reserved by DOS
	Atrib		DB	?
	FTime		DW	?
	FData		DW	?
	FSize		DD	?
	FileName	DB	13 DUP (0)	; Name of file found by DOS
	PSP		DB	10 DUP(0)	;The array of characters in the command tail
	
	.CODE
main	PROC FAR
	.STARTUP
	
	; The array counter
	MOV	DI,	0
	
	; Command Tail Segment
	MOV	SI,	82h
	MOV	CL,	ES:[SI-2]
	
	; Set up the command tail for input and store into a string array
	.WHILE BYTE PTR ES:[SI] != 0Dh
		MOV	AL,	ES:[SI]
		MOV PSP[DI],	AL
		
		; Increment the Command tail and string array
		INC	SI
		INC	DI
	.ENDW
	
	; Reset the array to read back to DI+0
	MOV	PSP[DI],	0
	
	; Open the file to read-only
	MOV	AH,	3Dh
	MOV	AL,	0
	MOV	DX,	OFFSET PSP
	INT 21h
	
	; Set the file handle
	MOV	BX,	AX
	
	.IF (CARRY?) && (AX == 2)
		str_out noFile
	
	.ELSEIF (CARRY?) && (AX !=2)
		str_out fileError
		
	.ELSE
		str_out fileExist
		
		; Close the file
		MOV	AH,	3Eh
		INT	21h
	
	.ENDIF
	
	.EXIT
main	ENDP
END