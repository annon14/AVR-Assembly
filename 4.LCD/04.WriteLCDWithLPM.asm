;
; chapter12_Assembly.asm
;
; Created: 3/29/2017 3:27:34 PM
; Author : Saeid
; using LPM Instruction to send long String to LCD

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
				
				LDI			R21 , HIGH(RAMEND)
				OUT		SPH , R21 
				LDI			R21 , LOW(RAMEND)
				OUT		SPL , R21
			
				OUT		R21 , 0xFF 
				OUT		LCD_DDDR , R21
				OUT		LCD_CDDR , R21
				CBI			LCD_CPRT , LCD_EN
				CALL		LDELAY
				LDI			R16 , 0x38
				CALL		CMNDWRT
				CALL		LDELAY
				LDI			R16 , 0x0E
				CALL		CMNDWRT
				LDI			R16 , 0x01
				CALL		CMNDWRT
				LDI			R16 , 0x06
				CALL		CMNDWRT
				LDI			R16 , 0x84
				CALL		CMNDWRT
				LDI			R31 , HIGH(MSG<<1)
				LDI			R30 , LOW(MSG<<1)
		LOOP :
				LPM		R16 , Z+
				CPI			R16 , 0
				BREQ		HERE
				CALL		DATAWRT
				RJMP		LOOP
		HERE :
				RJMP		HERE
		MSG :
				.DB " Hello	world ! " , 0
		CMNDWRT :
				MOV 	R27 , R16
				ANDI		R27 , 0xF0
				OUT		LCD_DPRT , R27
				CBI			LCD_CPRT , LCD_RS
				CBI			LCD_CPRT , LCD_RW
				SBI			LCD_CPRT , LCD_EN
				CALL		SDELAY
				CBI			LCD_CPRT , LCD_EN
				CALL		DELAY_100us
				MOV		R27 , R16
				SWAP	R27
				ANDI		R27 , 0xF0
				OUT		LCD_DPRT , R27
				SBI			LCD_CPRT , LCD_EN
				CALL		SDELAY
				CBI			LCD_CPRT , LCD_EN
				CALL		DELAY_100us
				RET
;---------------------------------------------------
			DATAWRT :
				MOV		R27 , R16
				ANDI		R27 , 0xF0
				OUT		LCD_DPRT , R27
				SBI			LCD_CPRT , LCD_RS
				CBI			LCD_CPRT , LCD_RW
				SBI			LCD_CPRT , LCD_EN
				CALL		SDELAY
				CBI			LCD_CPRT , LCD_EN
				MOV		R27 , R16
				SWAP	R27
				ANDI		0xF0
				OUT		LCD_DPRT , R27
				SBI			LCD_CPRT , LCD_EN
				CALL		SDELAY
				CBI			LCD_CPRT , LCD_EN
				CALL		DELAY_100us
				RET
;---------------------------------------------------
			SDELAY :
				NOP
				NOP
				RET
;---------------------------------------------------
			DELAY_100us :
				PUSH		R17
				LDI			R17 , 60
			DR0 :
				CALL		SDELAY
				DEC		R17
				BRNE		DR0
				POP		R17
				RET
;---------------------------------------------------
			DELAY_2ms :
				PUSH		R17 
				LDI			R17 , 20
			LDR0 :	
				CALL		DELAY_100us
				DEC		R17
				BRNE		LDR0
				POP		R17
				RET