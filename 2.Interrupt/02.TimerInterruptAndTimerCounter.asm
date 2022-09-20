;
; chapter10_assembly.asm
;
; Created: 3/27/2017 8:39:52 PM
; Author : Saeid
; PORTA counts up every time Timer1 overflows (once per second) 
; A pulse is fed into Timer0, where timer0 is used as counter and counts up.
; whenever the counter reaches 200, it will toggle the pin PORTB6

		.INCLUDE "M32DEF.INC"
		.ORG		0x00
				JMP		MAIN
		.ORG		0x12
				JMP		T1_OV_ISR
		.ORG		0x16
				JMP		T0_OV_ISR

		.ORG		0x40
		MAIN :	
				LDI		R20 , HIGH(RAMEND)
				OUT	SPH , R20
				LDI		R20 , LOW(RAMEND)
				OUT	SPL , R20
				LDI		R18 , 0
				OUT	PORTA , R18
				OUT	DDRC , R18
				LDI		R20 , 0xFF
				OUT	DDRA , R20 
				OUT	DDRD , R20 
				SBI		DDRB  ,  6
				SBI		PORTB , 0
				LDI		R20 , 0x06
				OUT	TCCR0 , R20
				LDI		R16 , -200
				OUT	TCNT0 , R16
				LDI		R19 , HIGH(-31250)
				OUT	TCNT1H , R19
				LDI		R19 , LOW(-31250)
				OUT	TCNT1L , R19
				LDI		R20 , 0x00
				OUT	TCCR1A , R20
				LDI		R20 , 0x04
				OUT	TCCR1B , R20
				LDI		R20 , (1<<TOIE0) | (1<<TOIE1)
				OUT	TIMSK , R20
				SEI
		HERE :
				IN		R20 , PINC
				OUT	PORTD , R20
				JMP		HERE
		.ORG		0x200
		T0_OV_ISR :
				IN		R16 , PORTB
				LDI		R17 , 0x40
				EOR	R16 , R17
				OUT	PORTB , R16 
				LDI		R16 , -200
				OUT	TCNT0 , R16
				RETI
			.ORG		0x300
			T1_OV_ISR :
				IN		R16 , PORTB 
				LDI		R17 , 0x40
				EOR	R16 , R17 
				OUT	PORTB , R16 
				LDI		R16 , -200
				OUT	TCNT0 , R16
				RETI
			.ORG		0x300
			T1_OV_ISR :
				INC		R18
				OUT	PORTA , R18
				LDI		R19 , HIGH(-31250)
				OUT	TCNT1H , R19
				LDI		R19 , LOW(-31250)
				OUT	TCNT1L , R19
				RETI
