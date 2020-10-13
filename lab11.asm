TITLE File I/O and PSP
; Rozell A. Dixon
; ENEE 3512, Microprocessor Design Lab, Lab 3
; April 18, 2008
; File I/O and PSP

	.MODEL SMALL
	.386
	.STACK

	.DATA

	FileNm	DB	"lab14.exe",	0
	Fname	DB	"hex.txt", 0
	NmFile	DB	"dec.txt", 0

	.CODE

	INCLUDE		io.inc

main 	PROC FAR
	.STARTUP


	;Open Existing File: INT 21h Service 3D; AH = 3Ch
	MOV	AH,	3Dh
	MOV	AL,	0
	MOV	DX,	OFFSET FileNm
	INT	21h

	.IF CARRY?
		str_out  "File Does Not Exist"
		JMP EXIT1
	.ENDIF



	;File Creation: INT 21h; AH = 3Ch
	;File IO Slide 2
;	MOV	AH,	3Ch
;	MOV	CX,	0
;	MOV	DX,	OFFSET Fname
;	INT	21h
;
	;File Write: INT 21h; AH = 40h
	;File IO Slide 6
;	MOV	ESI,	0
;L1:
;	KeyIn				;KeyIn Macro
;	CMP 	AL, 	1Bh		;compare to ESCape key
;	JE 	EXIT1			;Exit if ESCape key is entered
;	Echoes				;Echoes the keys hit
;	MOV	[Array+ESI], DL		;Moves the keys entered into array
;	INC	SI			;Scales address of array and keeps count of keys entered
;	JMP	L1			;Continues loop

EXIT1:

;	MOV	AX,	3D02h		;AH = 3D open existiong file  AL = 02 writes to file
;	MOV	DX,	OFFSET FileNm	;DS:DX pooints to an ASCIIZ string with the filename
;	INT	21h

;	MOV	BX,	AX		;BX = file handle
;	MOV	CX,	SI		;CX = the number of bytes to write
;	MOV	DX,	OFFSET Array	;DS:DX points to an output buffer
;	MOV	AH,	40h		;AH 40 write to file or device
;	INT	21h

	.EXIT
main	ENDP
END