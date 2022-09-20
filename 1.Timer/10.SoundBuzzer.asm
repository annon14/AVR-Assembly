;
; chapter9_Assembly.asm
;
; Created: 3/25/2017 12:36:21 PM
; Author : Saeid

; Assuming that clock pulses are fed into pin PB1 
; and a buzzer is connected to pin PORTC0,
; write a program for Counter 1 in CTC mode 
; to sound the buzzer every 100 pulses.

	.INCLUDE "M32DEF.INC"
			CBI		DDRB , 1
			SBI		DDRC , 0
			LDI		R16 , 0x01
			LDI		R17 , 0x00
			LDI		R20 , 0x00
			OUT	TCCR1A , R20
			LDI		R20 , 0x0E
			OUT	TCCR1B  , R20

	AGAIN : 
			LDI		R20 , 0x00
			OUT	OCR1AH , R20
			LDI		R20 , 99
			OUT	OCR1AL , R20
		L1:
			IN	R20 , TIFR
			SBRS	R20 , OCF1A
			RJMP		L1
			LDI		R20 , 1<<OCF1A
			OUT	TIFR  , R20
			EOR	R17 , R16
			OUT	PORTC , R17
			RJMP AGAIN