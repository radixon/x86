;Rozell A. Dixon
;Digital Design Using Microprocessors
;ENEE 3582



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

