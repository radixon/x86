
;Using Assembly language write a code that logs each key
;enterd by the user.  Each key is stored in the file logfile.
;The program terminates when the ser enters ESCape key.


	.MODEL SMALL
	.386
	.STACK

	.DATA

	FileNm	DB	"logfile.txt",	0
	Array	DB	"Keys: ",	0Dh, 0Ah
	welcom	DB	"Error",	0Dh, 0Ah

	.CODE

	INCLUDE		key.inc

main 	PROC FAR
	.STARTUP

	;File Creation: INT 21h; AH = 3Ch
	;File IO Slide 2
	MOV	AH,	3Ch
	MOV	CX,	0
	MOV	DX,	OFFSET FileNm
	INT	21h

	;File Write: INT 21h; AH = 40h
	;File IO Slide 6
	MOV	ESI,	0
L1:
	KeyIn				;KeyIn Macro
	CMP 	AL, 	1Bh		;compare to ESCape key
	JE 	EXIT1			;Exit if ESCape key is entered
	Echoes				;Echoes the keys hit
	MOV	[Array+ESI], DL		;Moves the keys entered into array
	INC	SI			;Scales address of array and keeps count of keys entered
	JMP	L1			;Continues loop

EXIT1:

	MOV	AX,	3D02h		;AH = 3D open existiong file  AL = 02 writes to file
	MOV	DX,	OFFSET FileNm	;DS:DX pooints to an ASCIIZ string with the filename
	INT	21h

	MOV	BX,	AX		;BX = file handle
	MOV	CX,	SI		;CX = the number of bytes to write
	MOV	DX,	OFFSET Array	;DS:DX points to an output buffer
	MOV	AH,	40h		;AH 40 write to file or device
	INT	21h

	;File Close:  INT 21h, AH = 3E
	MOV	AX,	3E00h
	INT	21h

	;Error Message If File Doesn't Close
	.IF	CARRY?
		MOV	AH,	40
		MOV	CX,	LENGTHOF welcom
		MOV	DX,	OFFSET	welcom
		INT	21h
	.ENDIF

	.EXIT
main	ENDP
END