;
; chapter13_Assembly.asm
;
; Created: 4/3/2017 
; Author : Saeid
; get data from channel 0 (ADC0) of ADC and displays the result on Port D. 
; Using Interrupt

	.INCLUDE	"M32DEF.INC"
	.CSEG
		RJMP	MAIN
	.ORG	ADCCaddr
		RJMP	ADC_INT_HANDLER
	.ORG	40
	MAIN:
		LDI		R16 , HIGH(RAMEND)
		OUT		SPH , R16
		LDI		R16 , LOW(RAMEND)
		OUT		SPL , R16
		SEI
		LDI		R16 , 0xFF
		OUT		DDRB , R16 
		OUT		DDRD , R16
		LDI		R16 , 0
		OUT		DDRA , R16
		LDI		R16 , 0x8F
		OUT		ADCSRA , R16
		LDI		R16 , 0xC0
		OUT		ADMUX , R16
		SBI		ADCSRA , ADSC
		
	WAIT_HERE :
		RJMP	WAIT_HERE
	ADC_INT_HANDLER :
		IN		R16 , ADCL
		OUT		PORTD , R16
		IN		R16 , ADCH
		OUT		PORTB , R16
		SBI		ADCSRA , ADSC
		RETI