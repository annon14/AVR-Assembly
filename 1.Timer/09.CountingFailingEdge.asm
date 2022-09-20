;
; chapter9_Assembly.asm
;
; Created: 3/25/2017 12:36:21 PM
; Author : Saeid

; Assuming that clock pulses are fed into pin PB1,
; write a program for Counter1 in Normal Mode to count
; the pulses on failing edge and display the state of
; the TCNT1 count on PORTC and PORTD

		.INCLUDE "M32DEF.INC"
				CBI		DDRB , 1
				LDI		R20 , 0xFF
				OUT	DDRC , R20
				OUT	DDRD , R20
				LDI		R20 , 0x00
				OUT	TCCR1A , R20
				LDI		R20 , 0x06
				OUT	TCCR1B , R20

		AGAIN :
				IN		R20 , TCNT1L
				OUT	PORTC , R20
				IN		R20 , TCNT1H
				OUT	PORTD , R20
				IN		R16 , TIFR
				SBRS	R16 , 1<<TOV1
				RJMP		AGAIN
				LDI		R16 , 1<<TOV1
				OUT	TIFR  , R16
				RJMP		AGAIN 