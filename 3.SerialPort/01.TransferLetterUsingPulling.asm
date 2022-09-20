;
; Chapter11.asm
;
; Created: 5/22/2017 11:16:43 PM
; Author : Saeid
; write a program to transmit the letter "G" serially at 9600 baud,
; continuously. XTAL= 8Mhz and using polling method  


.INCLUDE  "M32DEF.INC"
			LDI		R16 , (1<<TXEN) 
			OUT	UCSRB , R16  
			LDI		R16 , (1<<UCSZ1) | (1<<UCSZ0)
			OUT	UCSRC , R16 
			LDI		R16 , 0x33
			OUT	UBRRL  , R16
			
	AGAIN :
			SBIS	UCSRA   , UDRE 
			RJMP		AGAIN
			LDI		R16 , 'G'
			OUT	UDR , R16 
			RJMP		AGAIN
			 