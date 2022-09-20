;
; chapter12_Assembly.asm
;
; Created: 3/29/2017 3:27:34 PM
; Author : Saeid
; write "Hi" on the LCD using 8-bit data via PORTA . The AVR connection to the
; LCD for 8-bit data 

		.INCLUDE "M32DEF.INC"
		.EQU		LCD_DPRT		=  PORTA
		.EQU		LCD_DDDR		= DDRA
		.EQU		LCD_DPIN		= PINA
		.EQU		LCD_CPRT		= PORTB
		.EQU		LCD_CDDR		= DDRB
		.EQU		LCD_CPIN		=	 PINB
		.EQU		LCD_RS				= 0
		.EQU		LCD_RW			= 1
		.EQU		LCD_EN			= 2
				
				LDI		R21 , HIGH(RAMEND)
				OUT	SPH , R21 
				LDI		R21 , LOW(RAMEND)
				OUT	SPL , R21
				OUT	R21 , 0xFF 
				OUT	LCD_DDDR , R21
				OUT	LCD_CDDR , R21
				CBI		LCD_CPRT , LCD_EN
				CALL		DELAY_2ms
				LDI		R16  , 0x38
				CALL		CMNDWRT
				CALL		DELAY_2ms
				LDI		R16 , 0x0E
				CALL		CMNDWRT
				LDI		R16 , 0x01
				CALL		CMDWRT
				CALL		DELAY_2ms
				LDI		R16 , 0x06
				CALL		CMNDWRT
				LDI		R16 , 'H'
				CALL		DATAWRT
				LDI		R16  , 'i'
				CALL		DATAWRT
		HERE :
				RJMP		HERE
;----------------------------------------
		CMNDWRT :
				OUT	LCD_DPRT , R16
				CBI		LCD_CPRT , LCD_RS
				CBI		LCD_CPRT , LCD_RW
				SBI		LCD_CPRT , LCD_EN
				CALL		SDELAY
				CBI		LCD_CPRT , LCD_EN
				CALL		DELAY_100us
				RET		
		DATAWRT :
				OUT	LCD_DPRT , R16
				SBI		LCD_CPRT , LCD_RS
				CBI		LCD_CPRT , LCD_RW
				SBI		LCD_CPRT , LCD_EN
				CALL		SDELAY
				CBI		LCD_CPRT , LCD_EN
				CALL		DELAY_100us
				RET
;------------------------------------------
		SDELAY :
				NOP
				NOP
				RET

		DELAY_100us :
				PUSH		R17
				LDI			R17 , 60
		DR0:	
				CALL		SDELAY
				DEC		R17
				BRNE		DR0
				POP		R17
				RET

		DELAY_2ms :
				PUSH		R17
				LDI			R17 , 20
		LDR0 :
				CALL		DELAY_100us
				DEC		R17
				BRNE		LDR0
				POP		R17
				RET