;
; chapter13_Assembly.asm
;
; Created: 4/5/2017 
; Author : Saeid
; reads the sensor and displays it on Port D
	.INCLUDE	"M32DEF.INC"
		LDI		R16 , 0xFF
		OUT		DDRD , R16
		LDI		R16 , 0
		OUT		DDRA , R16
		LDI		R16 , 0x87
		OUT		ADCSRA , R16
		LDI		R16 , 0xE0
		OUT		ADMUX , R16
	READ_ADC :
		SBI		ADCSRA , ADSC
	KEEP_POLLING :
		SBIS	ADCSRA , ADIF
		RJMP 	KEEP_POLLING
		SBI		ADCSRA , ADIF
		IN 		R16 , ADCH
		OUT		PORTD , R16
		RJMP	READ_ADC
		