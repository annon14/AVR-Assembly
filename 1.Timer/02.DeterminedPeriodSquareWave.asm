;
; chapter9_Assembly.asm
;
; Created: 3/25/2017 12:36:21 PM
; Author :Saeid
; generate a square wave with a period of 12.5 microsecond on PORTB3 (XTAL = 8 MHz)

		.INCLUDE "M32DEF.INC" 
		.MACRO INITSTACK
			LDI		R20 ,  HIGH(RAMEND)
			OUT	SPH , R20
			LDI		R20 , LOW(RAMEND)
			OUT	SPL ,  R20
		.ENDMACRO
;--------------------------------------------------------
			INITSTACK
			LDI		R16 ,  0x08
			SBI		DDRB , 3
			LDI		R17 , 0
			OUT	PORTB , R17
		BEGIN : 
			RCALL DELAY
			EOR	R17 , R16
			OUT	PORTB ,  R17
		DELAY :
			LDI		R20 , 0X10
			OUT	TCNT0 , R20
			LDI		R20  , 0x03
			OUT	TCCR0 , R20 
		AGAIN :
			IN		R20 , 0x10
			SBRS	R20 , TOV0
			RJMP	AGAIN
			LDI		 

		
		