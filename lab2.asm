TITLE My First Assembly Program
; Rozell A. Dixon
; ENEE 3512, Microprocessor Design Lab, Lab 2
; January 25, 2008
; Create and Run an Assembly Program

.MODEL SMALL
.386
.STACK
CR	EQU 0Dh			; Carriage Return character
LF	EQU 0Ah			; Line Feed character

.DATA
message BYTE "Rozell A. Dixon has built", CR, LF, "this program SUCCESSFULLY!", CR, LF

.CODE
main	PROC FAR
	.STARTUP

		MOV  AH, 40h
		MOV  BX, 1
		MOV  CX, SIZEOF message
		MOV  DX, OFFSET message
		INT  21h

		.EXIT
main		ENDP
END