;Macro Name:  	KeyIn
;Uses:		AX
;Receives:	Nothing
;Returns:	AL, character keyed in
;Description:	Called upon when a single character must be
;		retreived from the input and returned to AL.
;-----------------------------------------------------------------

.MODEL SMALL
.386
.STACK

.DATA

newline	DB	0Dh, 0Ah
space	DB	20h
string	DB	0

.CODE

	INCLUDE		case.inc

main PROC FAR
.STARTUP


		MOV	SI,	0
L1:
		KeyIn
		CMP	AL,	1Bh
		JE	Case
		MOV	[string+SI],	AL
		JE	Case
		INC	SI
		JMP	L1
Case:
		CaseFlip string, SI

		str_out	 string


	.EXIT
main ENDP
END