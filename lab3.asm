TITLE Registers and Data Types
; Rozell A. Dixon
; ENEE 3512, Microprocessor Design Lab, Lab 3
; February 1, 2008
; Data Types, Registers and CodeView

.MODEL SMALL
.386
.STACK

.DATA
var1 SBYTE  +12
var2 WORD   5000h
var3 BYTE   4Ah
var4 DWORD  87654321h
var5 SWORD  -32768
var6 SDWORD -222222

myArray  BYTE 0,1,2,3,4,5,6     ; Define myArray here
ourArray WORD 1000h,2000h,3000h ; Define ourArray here

.CODE
main	PROC  FAR
	.STARTUP

	; Code Segment 1
	MOV    AX,  var2
	MOV    BX,  OFFSET var3
	MOV    AH,  [BX]
	MOV    EAX, var4
	MOV    AL,  myArray

	; Code Segment 2
	MOV    BX,  OFFSET ourArray
	MOV    AX,  [BX]
	ADD    BX,  2
	MOV    CX,  [BX]
	MOV    DX,  [ourArray+4]

	.EXIT
main	ENDP
END