TITLE Interrupts and Input/Output Devices
; Rozell A. Dixon
; ENEE 3512, Microprocessor Design Lab, Lab 3
; March 28, 2008
; Interrupts and Input/Output Devices

.MODEL SMALL
.386
.STACK

.DATA
WELCOM	BYTE	"Welcome to my world. ",	0Dh, 0Ah


.CODE

INCLUDE	io.inc

main	PROC  FAR
	.STARTUP

	str_out	WELCOM

	.EXIT
main	ENDP
END