;
; chapter10_assembly.asm
;
; Created: 3/27/2017 8:39:52 PM
; Author : Saeid

; using Timer0 and Timer1 simultaneously, to generate
; square waves on pins PB1 and PB7 respectively, while
; data is being transfered from PORTC to PORTD

		.INCLUDE "M32DEF.INC"
		.ORG		0x00
				JMP		MAIN
		.ORG		0x12
				JMP		T1_OV_ISR
		.ORG		0x16
				JMP		T0_OV_ISR

		.ORG		0x100
		MAIN :	
				LDI		R20 , HIGH(RAMEND)
				OUT	SPH , R20
				LDI		R20 , LOW(RAMEND)
				OUT	SPL , R20
				SBI		DDRB , 1
				SBI		DDRB , 7
				LDI		R20 , (1<<TOIE0) | (1<<TOIE1)
				OUT	TIMSK , R20
				SEI
				LDI		R20 , 0xA2
				OUT	TCNT0 , R20
				LDI		R20 , 0x01
				OUT	TCCR0 , R20
				LDI		R20 , 0xFF
				OUT	TCNT1H , R20
				LDI		R20 , 0xC0
				OUT	TCNT1L , R20
				LDI		R20 , 0x00
				OUT	TCCR1A , R20
				LDI		R20 , 0x01
				OUT	TCCR1B , R20 
				LDI		R20 , 0x00
				OUT	DDRC , R20
				LDI		R20 , 0xFF
				OUT	DDRD , R20
		HERE :
				IN		R20 , PINC 
				OUT	PORTD , R20 
				JMP		HERE
		.ORG		0x200
		T0_OV_ISR :
				LDI		R16 , -160
				OUT	TCNT0 , R16
				IN		R16 , PORTB
				LDI		R17 , 0x02
				EOR	R16 , R17
				OUT	PORTB , R16
				RETI
		.ORG		0x300
		T1_OV_ISR :
				LDI		R18 , HIGH(-640)
				OUT	TCNT1H , R18
				LDI		R18 , LOW(-640)
				OUT	TCNT1L , R18
				IN		R18 , PORTB
				LDI		R19 , 0x80
				EOR	R17 , R16 
				OUT	PORTB , R18
				RETI
