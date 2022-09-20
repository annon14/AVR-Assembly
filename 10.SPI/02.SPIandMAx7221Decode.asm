;
; Chapter17.asm
;
; Created: 5/31/2017 10:17:31 PM
; Author : Saeid
; Display 2U on the 7-segment by use of decoding fuunction


.INCLUDE "M32DEF.INC"
.EQU		MOSI		= 5 
.EQU		SCK		= 7
.EQU		SS			= 4
		LDI		R21 , HIGH(RAMEND)
		OUT	SPH , R21
		LDI		R21 , LOW(RAMEND)
		OUT  SPL , R21 
		LDI		R17 , (1<<MOSI) | (1<<SCK ) | (1<<SS)
		OUT	DDRB , R17
		LDI		R17 ,  ( 1<<SPE ) | ( 1<< MSRT ) | (1<<SPR0)
		OUT	SPCR , R17
		LDI		R17 , 0x09 
		LDI		R18 , 0b00000010
		CALL		RunCMD
		LDI		R17 , 0x0B 
		LDI		R18 , 0x02
		CALL		RunCMD
		LDI		R17 , 0x0C 
		LDI		R18 , 0x01
		CALL		RunCMD
		LDI		R17 , 0x01
		LDI		R18 , 0x3E
		CALL		RunCMD
		LDI		R17 , 0x02 
		LDI		R18 , 0x02
		CALL		RunCMD
	HERE :
		RJMP		HERE	
//=============================
RunCMD :
		CBI		PORTB , SS 
		OUT	SPDR , R17
WAIT_1 :
		SBIS	SPSR , SPIF
		RJMP		WAIT_1
		OUT	SPDR , R18
WAIT_2 :
		SBIS	SPSR , SPIF
		RJMP		WAIT_2
		SBI		PORTB , SS
		RET




