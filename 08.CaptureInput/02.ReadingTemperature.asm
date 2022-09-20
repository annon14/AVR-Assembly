;
; Chapter15.asm
;
; Created: 5/4/1/2017 2:22:41 PM
; Author : Saeid
; assuming temperature sensor is connected to pin PD6. The temperature
; provided by the sensor is propertional to pulse width and is
; in range of 1 micro second is equal to 1 degree. Use the prescaler 
; value that gives the result in a single byte. Display the result on PORTB. 
; XTAL = 8MHz

.INCLUDE "M32DEF.INC"
	    LDI	R16, 0xFF
	    OUT DDRB,R16
	    OUT PORTD,R16
BEGIN:  LDI R20, 0x00
	    OUT TCCR1A, R20
	    LDI R20, 0x42
	    OUT TCCR1B, R20
L1:	    IN  R21, TIFR
		SBRS R21,ICF1 
		RJMP L1
		IN R16, ICR1L
		OUT TIFR, R21
		LDI R20,0x02
		OUT TCCR1B,R20
L2:		IN R21,TIFR
		SBRS R21,ICF1
		RJMP L2
		IN R22, ICR1L
		SUB R22,R16
		OUT PORTB,R22
		OUT TIFR,R21
L3:		RJMP L3
		
	