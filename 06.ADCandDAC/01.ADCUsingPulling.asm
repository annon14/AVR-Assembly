;
; chapter13_Assembly.asm
;
; Created: 4/3/2017 
; Author : Saeid
; get data from channel 0 (ADC0) of ADC and displays the result on Port D. 
; This is done forever

	.INCLUDE	"M32DEF.INC"
		LDI	 R16 , 0xFF
		OUT	 DDRB , R16 
		OUT	 DDRD , R16
		LDI	 R16 , 0
		OUT	 DDRA , R16
		LDI	 R16 , 0x87
		OUT	 ADCSRA,R16
		LDI	 R16 , 0xC0
		OUT	 ADMUX , R16
		
	READ_ADC :
		SBI	 ADCSRA , ADSC
		
	KEEP_POLING :
		SBIS ADCSRA , ADIF
		RJMP KEEP_POLING
		SBI	 ADCSRA , ADIF
		IN	 R16 , ADCL
		OUT	 PORTD , R16
		IN	 R16 , ADCH 
		OUT	 PORTB , R16
		RJMP READ_ADC
		