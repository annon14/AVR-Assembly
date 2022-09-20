;
; Chapter15.asm
;
; Created: 5/8/2017 1:22:41 PM
; Author : Saeid
; write a program to monitor the status of the switch and perform the following:
; a_ if PORTA7 = 1. the DC motor moves with 25% duty cycle pulse.
; b_ if PORTA7  = 0, the DC motor moves with 50% duty cycle pulse.

.INCLUDE "M32DEF.INC"
	
		LDI	R16,HIGH(RAMEND)
		OUT SPH,R16
		LDI R16,LOW(RAMEND)
		OUT SPL,R16
		SBI DDRB, 0
		CBI DDRA, 7
		SBI PORTA, 7
		CBI PORTB, 0
CHK:	SBIC PINA, 7
		RJMP P50
		SBI	PORTB, 0
		RCALL DELAY
		RCALL DELAY
		RCALL DELAY
		CBI PORTB, 0
		RCALL DELAY
		RJMP CHK
P50:	SBI PORTB, 0
		RCALL DELAY
		RCALL DELAY
		CBI PORTB, 0
		RCALL DELAY
		RCALL DELAY
		RJMP CHK