;--------------------------------------------------------------------------------------------------
;Write a code that uses interrupt service 6 to read a key entered
;by the user.  If the key is an alphabetical character the code must
;convert its case then echo it to the screen.  This is repeated for
;all keys entered by the user.  The code should stop when the user
;hits the ESC key.
;--------------------------------------------------------------------------------------------------


	.MODEL SMALL
	.386
	.STACK

	.DATA


.CODE
main	PROC  FAR
	.STARTUP



GetCharacter:
		MOV	AH,	6
		MOV	DL,	-1
L1:
		INT	21h
		JZ	L1

		CMP	AL,	1Bh
		JE	DONE

		.IF 	(AL >= 61H) && (AL <= 7Ah)
				SUB	AL,	20h
		.ELSEIF	(AL >= 41h) && (AL <= 5Ah)
				ADD	AL,	20H
		.ENDIF


		MOV	DL,	AL
		MOV	AH,	2h
		INT	21h
		JMP	GetCharacter

Done:

	.EXIT
main	ENDP
END