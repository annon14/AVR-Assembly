;
; chapter13_Assembly.asm
;
; Created: 3/29/2017 3:27:34 PM
; Author : Saeid
; send ASCII Code for pressed key to PORT D 
; PC0-PC3 connected to rows PC4-7 connected to columns

		.INCLUDE "M32DEF.INC"
		.EQU		KEY_PORT	= PORTC
		.EQU		KEY_PIN		= PINC
		.EQU		KEY_DDR		=	DDRC
				LDI			R20 , HIGH(RAMEND)
				OUT		SPH , R20
				LDI			R20 , LOW(RAMEND)
				OUT		SPL	, R20

				LDI			R21 , 0xFF
				OUT		DDRD , R21
				LDI			R20 , 0xF0
				OUT		KEY_DDR , R20
		GROUND_ALL_ROWS :
				LDI			R20 , 0x0F
				OUT		KEY_PORT , R20
		WAIT_FOR_RELEASE :
				IN			R21 , KEY_PIN
				ANDI		R21 , 0x0F
				CPI			R21 , 0x0F
				BREQ		WAIT_FOR_RELEASE
				CALL		WAIT15MS
				IN			R21 , KEY_PIN
				ANDI		R21 , 0x0F
				CPI			R21, 0x0F
				BREQ		WAIT_FOR_KEY
				LDI			R21 , 0b01111111
				OUT		KEY_PORT, R21
				NOP	
				IN			R21 , KEY_PIN
				ANDI		R21 , 0x0F
				CPI			R21, 0x0F
				BRNE	COL1
				LDI			R21 , 0b10111111
				OUT		KEY_PORT	, R21
				NOP	
				IN			R21 , KEY_PIN
				ANDI		R21 , 0x0F
				CPI			R21 , 0x0F
				BRNE		COL2
				LDI			R21 , 11011111
				OUT		KEY_PORT , R21
				NOP
				IN			R21 , KEY_PIN
				ANDI		R21 , 0x0F
				CPI			R21 , 0x0F
				BRNE		COL3
				LDI			R21 , 0b11101111
				OUT		KEY_PORT , R21
				NOP
				IN			R21 , KEY_PIN
				ANDI		R21 , 0x0F
				CPI			R21 , 0x0F
				BRNE		COL4
				
		COL1 :	
				LDI			R30 , LOW(KEYCODE0<<1)
				LDI			R31 , HIGH(KEYCODE0<<1)
				RJMP		FIND
		COL2 :	
				LDI			R30 , LOW(KEYCODE1<<1)
				LDI			R31 , HIGH(KEYCODE1<<1)
				RJMP		FIND
		COL3 :	
				LDI			R30 , LOW(KEYCODE2<<1)
				LDI			R31 , HIGH(KEYCODE2<<1)
				RJMP		FIND
		COL4 :	
				LDI			R30 , LOW(KEYCODE3<<1)
				LDI			R31 , HIGH(KEYCODE3<<1)
				RJMP		FIND
		FIND :
				LSR			R21
				BRCC		MATCH
				LPM		R20 , Z+
				RJMP		FIND
		MATCH :
				LPM		R20 , Z
				OUT		PORTD , R20
				RJMP		GROUND_ALL_ROWS
		DELAY :
				NOP
				NOP
				RET
		WAIT15MS :
				PUSH		R17
				PUSH		R18
				LDI			R17 , 180
		WL1:
				LDI			R18 , 50
		WL2:
				DEC		R18
				BRNE		WL2
				DEC		R17
				BRNE		WL1
				POP		R18
				POP		R17
				RET
		.ORG		0x300
		KCODE0 :		.DB		'0', '1' , '2' , '3'
		KCODE1 :		.DB		'4' , '5' , '6' , '7'
		KCODE2 :		.DB		'8' , '9' , 'A' , 'B'
		KCODE3 :		.DB		'C' , 'D', 'E' , 'F'
				 
			