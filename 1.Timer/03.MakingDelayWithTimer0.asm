;
; chapter9_Assembly.asm
;
; Created: 3/25/2017 12:36:21 PM
; Author : Saeid
;creating a square wave of 50%duty cycle on PORTB5 for 1.25 microsecond delay using Timer0

		.INCLUDE "M32DEF.INC" 
		.MACRO INITSTACK
				LDI		R20 ,  HIGH(RAMEND)
				OUT	SPH , R20
				LDI		R20 , LOW(RAMEND)
				OUT	SPL ,  R20
		.ENDMACRO
;--------------------------------------------------------
				INITSTACK
				LDI		R16 ,  0x20
				SBI		DDRB ,  5
				LDI		R17 , 0			
		BEGIN : 
				OUT	PORTB , R17
				RCALL DELAY
				EOR	R17 , R16
				RJMP	BEGIN
		DELAY :
				LDI		R20 , 0x00
				OUT	TCNT0 , R20
				LDI		R20  , 9
				OUT	OCR0 , R20
				LDI		R20 , 0x09
				OUT	TCCR0 , R20
		AGAIN :
				IN		R20 , TIFR
				SBRS	R20 , OCF0
				RJMP	AGAIN
				LDI		R20 , 0
				OUT	TCCR0 , R20
				LDI		R20 , 1<<OCF0
				OUT	TIFR , R20
				RET