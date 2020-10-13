TITLE Loops
; Rozell A. Dixon
; ENEE 3512, Microprocessor Design Lab, Lab 3
; February 22, 2008
; Loops

.MODEL SMALL
.386
.STACK

.DATA
array1	DW	27,138,255,-100,-50,-25,1111h,2222h,3333h   ; Define array1
array2	DB	3 DUP (0)				    ; Define array2
array3	DW	3 DUP (0)				    ; Define array3
array4	DD	3 DUP (0)				    ; Define array4
COUNT	DD	0

.CODE
main	PROC  FAR
	.STARTUP

	; Code Segment 1
	MOV	DX, 0
	MOV	AX, 0
	MOV	ECX, 3
L1:
	MOV	AL, BYTE PTR [array1+DX]		; PTR converts size to BYTE
	MOV	[array2+AX], AL
	ADD	DX, 2
	INC	AX
LOOP	L1

	; Code Segment 2
	MOV	BX, 6
	MOV	BP, 0
	MOV	ECX, 3
	MOV	BX,  OFFSET array1	; BX for indirect addressing
	MOV	BP, OFFSET array3	; BP for indirect addressing
L2:
	MOV	COUNT, ECX
	MOV	CX, [BX]
	MOV	[BP], CX
	ADD	BX, 2
	ADD	BP, 2
	MOV	ECX, COUNT
LOOP	L2

	;Code Segment 3

	MOV	EDX, 6
	MOV	EBX, 0
	MOV	ECX, 3
L3:
	MOV	COUNT, ECX
	MOV	CX,  [array1+EDX*2]
	MOV	[array4+EBX*4], ECX
	INC	EDX
	INC	EBX
	MOV	ECX, COUNT
LOOP	L3


	.EXIT
main	ENDP
END
