;
; chapter9_Assembly.asm
;
; Created: 3/25/2017 12:36:21 PM
; Author : Saeid
; 1.25 ms delay using Timer1 in normal mode (XTAL=8MHz)

		.INCLUDE "M32DEF.INC"
		.MACRO	INITSTACK
			LDI	R16 , HIGH(RAMEND)
			OUT	SPH , R16
			LDI	R16 , LOW(RAMEND)
			OUT	SPL , R16
		.ENDMACRO
;------------------------------------------------------
			INITSTACK
			LDI		R16 , 0x20
			SBI		DDRB , 5
			LDI		R17 , 0
			OUT	PORTB , R17
		BEGIN :
			RCALL	DELAY
			EOR	R17 , R16
			OUT	PORTB	, R17
			RJMP		BEGIN
		DELAY :
			LDI		R20 , 0xD8			; or LDI	R20 , HIGH(65536 - 10000)
			OUT	TCNT1H , R20
			LDI		R20 , 0xF0			; or LDI	R20 , LOW(65536 - 10000)
			OUT	TCNT1L , R20
			LDI		R20 , 0x00
			OUT	TCCR1A , R20
			LDI		R20 , 0x01
			OUT	TCCR1B , R20
		AGAIN :
			IN		R20 , TIFR
			SBRS	R20 , TOV1
			RJMP		AGAIN
			LDI		R20 , 0x00
			OUT	TCCR1A , R20
			OUT	TCCR1B , R20
			LDI		R20 , (1<<TOV1)
			OUT	TIFR , R20
			RET

