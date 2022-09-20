;
; chapter10_assembly.asm
;
; Created: 3/27/2017 8:39:52 PM
; Author : Saeid

; write a programm that toggle pin PORTB5 every second,
; using TIMER1. At the same time transfering data from PORTC to PORTD.
; XTAL = 8MHz
; pre scaler : 1024 and OCR1A :7811=0x1E83

		.INCLUDE "M32DEF.INC"
		.ORG		0x00
				JMP		MAIN
		.ORG		0x14
				JMP		T1_CM_ISR
	
		.ORG		0x100
		MAIN :	
				LDI		R20 , HIGH(RAMEND)
				OUT	SPH , R20
				LDI		R20 , LOW(RAMEND)
				OUT	SPL , R20

				SBI		DDRB , 5
				LDI		R20 , (1<<OCIE1A)
				OUT	TIMSK  , R20
				SEI
				LDI		R20 , 0x00
				OUT	TCCR1A , R20
				LDI		R20 , 0x0D
				OUT	TCCR1B , R20
				LDI		R20 , HIGH(7811)
				OUT	OCR1AH , R20
				LDI		R20 , LOW(7811)
				OUT	OCR1AL , R20
				LDI		R20 , 0x00
				OUT	DDRC , R20
				LDI		R20 , 0xFF
				OUT	DDRD , R20
		HERE :
				IN		R20 , PINC
				OUT	PORTD , R20 
				JMP		HERE
		T1_CM_ISR :
				LDI		R17 , 0x20
				EOR	R16 , R17
				OUT	PORTB , R16
				RETI	
				