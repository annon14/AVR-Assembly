;
; chapter9_Assembly.asm
;
; Created: 3/25/2017 12:36:21 PM
; Author : Saeid
; write a program to toggle a led connected to PC4 once per second, assuming XTAL = 8MHz

		.INCLUDE "M32DEF.INC"
				LDI		R16 , HIGH(RAMEND)
				OUT	SPH , R16
				LDI		R16 , LOW(RAMEND)
				OUT	SPL , R16
				SBI		DDRC , 4
		BEGIN :
				SBI		PORTC , 4
				RCALL	DELAY_1s
				CBI		PORTC  , 4
				RCALL	DELAY_1s
				RJMP		BEGIN
;------------------------------------------
		DELAY_1s :
				LDI		R20 , HIGH(31250 - 1)
				OUT	OCR1AH , R20
				LDI		R20 , LOW(31250 - 1)
				OUT	OCR1AL , R20

				LDI		R20 , 0x00
				OUT	TCNT1H , R20
				LDI		R20 , 0x01
				OUT	TCNT1L , R20

				LDI		R20 , 0x00
				OUT	TCCR1A  ,  R20
				LDI		R20  , 0x04
				OUT	TCCR1B  ,  R20

		AGAIN :
				IN		R20 , TIFR
				SBRS	R20 , OCF1
				RJMP		AGAIN
				LDI		R20 , 1 << OCF1
				OUT	TIFR , R20
				LDI		R19 , 0
				OUT	TCCR1B , R19
				OUT	TCCR1A , R19
				RET