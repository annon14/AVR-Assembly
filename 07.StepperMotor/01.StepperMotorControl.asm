;
; chapter14_Assembly.asm
;
; Created: 4/15/2017 
; Author : Saeid

; connect a switch to pin PA7(PORTA7), Write a program to monitor the status
; of SW and perform the following:
; a_ if SW = 0, the stepper motor moves clockwise
; b_ if SW = 1, the stepper motor moves counterclockwise

.INCLUDE "M32DEF.INC"
	LDI R20, HIGH(RAMEND)
	OUT SPH, R20
	LDI R20, LOW(RAMEND)
	OUT SPL, R20
	LDI R20, 0xFF
	OUT DDRB, R20
	CBI DDRA, 7
	LDI R20, 0x66
L1:	OUT PORTB, R20
	IN 	R16, PINA
	BST R16, 7
	BRTS	CW
	LSR 	R20
	BRCC 	OV1 
	ORI	R20, 0x80
OV1:RCALL DELAY
	RJMP L1
CW: LSL R20
	BRCC OV2
	ORI R20, 0x01
OV2:RCALL DELAY
	RJMP L1