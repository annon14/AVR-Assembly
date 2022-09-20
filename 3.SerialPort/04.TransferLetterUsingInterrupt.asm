;
; Chapter11.asm
;
; Created: 5/22/2017 11:16:43 PM
; Author : ProBook
; write a program to transmit the letter "G" serially at 9600 baud,
; continuously. XTAL= 8Mhz and using interrupt instead of polling method  
.INCLUDE "M32DEF.INC"
.CSEG
	RJMP MAIN
.ORG UDREaddr
	RJMP UDRE_INT_HANDLER
.ORG 40

MAIN:	LDI	R16, HIGH(RAMEND)
		OUT	SPH, R16
		LDI	R16, LOW(RAMEND)
		OUT	SPL, R16
		LDI R16, (1<<RXEN) | (1<<RXCIE)
		OUT	UCSRB, R16
		LDI R16, (1<<UCSZ1) | (1<<UCSZ0)
		OUT UCSRC, R16
		LDI R16, 0x33
		OUT UBRRL, R16
		SETI
WAIT_HERE:
		RJMP WAIT_HERE
UDRE_INT_HANDLER:
		LDI	R26, 'G'
		OUT PORTB, R17
		RETI
	