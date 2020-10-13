TITLE Array Manipulation, Data Transfers, and Addressing Modes
; Rozell A. Dixon
; ENEE 3512, Microprocessor Design Lab, Lab 3
; February 1, 2008
; Array Manipulation, Data Transfers, and Addressing Modes

.MODEL SMALL
.386
.STACK

.DATA
array1	DW	27,138,255,-100,-50,-25,1111h,2222h,3333h   ; Define array1 here
array2	DB	3 DUP (0)				    ; Define array2 here
array3	DW	3 DUP (0)				    ; Define array3 here
array4	DD	3 DUP (0)				    ; Define array4 here

.CODE
main	PROC  FAR
	.STARTUP

	; Code Segment 1
	MOV	AL, BYTE PTR array1	; PTR is used to convert size to BYTE
	MOV	AH, BYTE PTR [array1+2]	; Same size registers
	MOV	BH, BYTE PTR [array1+4]
	MOV	array2, AL
	MOV	[array2+1], AH
	MOV	[array2+2], BH

	; Code Segment 2
	MOV	BX,  OFFSET array1	; BX for indirect addressing
	MOV	SI, OFFSET array3	; EAX for indirect addressing
	MOV	CX, [BX+6]
	MOV	[SI], CX
	MOV	DX, [BX+8]
	MOV	[SI+2], DX
	MOV	BP, [BX+10]
	MOV	[SI+4], BP

	;Code Segment 3
	MOV	EDX, 6
	MOV	EBX, 0
	MOV	CX,  [array1+EDX*2]
	MOV	[array4+EBX*4], ECX
	INC	EDX
	MOV	CX, [array1+EDX*2]
	INC	EBX
	MOV	[array4+EBX*4], ECX
	INC	EDX
	MOV	CX, [array1+EDX*2]
	INC	EBX
	MOV	[array4+EBX*4], ECX


	.EXIT
main	ENDP
END
