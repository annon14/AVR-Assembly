;
; chapter9_Assembly.asm
;
; Created: 3/25/2017 12:36:21 PM
; Author : Saeid
;make 1920 microsecond delay with prescaler of 64 and Timer2(assuming XTAL = 8 MHz) 

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
				SBI		DDRB ,  3
				LDI		R17 , 0	
		BEGIN:
				OUT	PORTB , R17
				RCALL	DELAY
				EOR	R17 , R16
				RJMP		BEGIN
;--------------------------------------------------------
		DELAY :
				LDI		R20 , -240
				OUT	TCNT2 , R20
				LDI		R20 , 0x04
				OUT	TCCR2 , R20
		AGAIN :
				IN		R20 , TIFR
				SBRS	R20 , TOV2
				RJMP		AGAIN
				LDI		R20 , 0x00
				OUT	TCCR0 , R20
				LDI		R20 , 1<<TOV2
				OUT	TIFR , R20
				RET
