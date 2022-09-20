;
; chapter9_Assembly.asm
;
; Created: 3/25/2017 12:36:21 PM
; Author : Saeid
;20 microsecond delay using Timer1 in CTC mode

		.INCLUDE "M32DEF.INC"
				SBI		DDRB , 5
		BEGIN :
				SBI		PORTB , 5
				RCALL	DELAY
				CBI		PORTB , 5
				RCALL	DELAY
				RJMP		BEGIN

		DELAY :
				LDI		R20  , 0x00
				OUT	TCNT1H , R20
				OUT	TCNT1L , R20
				OUT	OCR1H , R20
				LDI		R20 , 159
				OUT	OCR1L , R20
				LDI		R20 , 0x00
				OUT	TCCR1A , R20
				LDI		R20 , 0x09
				OUT	TCCR1B , R20
		AGAIN :
				IN		R20 , TIFR
				SBRS	R20 , OCF1A
				RJMP	AGAIN
				LDI		R20 , (1<<OCF1A)
				OUT	TIFR , R20
				LDI		R19 , 0
				OUT	TCCR1B , R19
				OUT	TCNT1A , R19
				RET