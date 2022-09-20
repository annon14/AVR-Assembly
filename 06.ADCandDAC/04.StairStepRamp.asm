;
; chapter13_Assembly.asm
;
; Created: 4/9/2017 
; Author : Saeid
; generate a stair-step ramp on POERTB

	.INCLUDE	"M32DEF.INC"
		LDI		R16 , 0xFF
		OUT		DDRB , R16
	AGAIN :
		INC		R16
		OUT		PORTB , R16
		NOP
		NOP
		RJMP	AGAIN