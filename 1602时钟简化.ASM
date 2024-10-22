RS		EQU		P1.0
RW		EQU		P1.1
E		EQU		P1.2
DS0		EQU		30H
DS1		EQU		31H
DS2		EQU		32H
DS3		EQU		33H
DS4		EQU		36H
DS5		EQU		35H
JSBZ	EQU		34H

		ORG		00H
		AJMP	MAIN
		ORG		0BH
		AJMP	TIME
		ORG		30H
MAIN:	MOV		SP,#80H
		CLR		A
		CLR		E
		MOV		DS1,#0
		MOV		DS2,#0
		MOV		DS3,#0
		MOV		DS4,#0
		MOV		DS5,#0
		MOV		DS0,#0
		MOV		TMOD,#11H
		MOV		TL0,#3CH
		MOV		TH0,#0B0H
		SETB	EA
		SETB	TR0
		SETB	ET0
		LCALL	LCD_INIT
MAI:	MOV		A,#1
		LCALL	XIEZL
		MOV		A,#80H
		LCALL	XIEZL
		MOV		DPTR,#TABL1
		LCALL	XRWC
		MOV		A,#0c2H
		LCALL	XIEZL
		MOV		DPTR,#TABL3
		PUSH	ACC
		CLR		A
		MOVC	A,@A+DPTR
		LCALL	XIESJ
		POP		ACC
		MOV		A,#0C5H
		LCALL	XIEZL
		MOV		DPTR,#TABL3
		PUSH	ACC
		CLR		A
		MOVC	A,@A+DPTR
		LCALL	XIESJ
		POP		ACC
		MOV		A,#0C9H
		LCALL	XIEZL
		MOV		DPTR,#TABL4
		LCALL	XRWC
MAI1:	MOV		A,#0C0H
		LCALL	XIEZL
		PUSH	ACC
		MOV		A,DS2
		MOV		B,#10
		DIV		AB
		ADD		A,#30H
		LCALL	XIESJ
		POP		ACC
		MOV		A,#0C1H
		LCALL	XIEZL
		PUSH	ACC
		MOV		A,B
		ADD		A,#30H
		LCALL	XIESJ
		POP		ACC	
		MOV		A,#0C3H
		LCALL	XIEZL
		PUSH	ACC
		MOV		A,DS1
		MOV		B,#10
		DIV		AB
		ADD		A,#30H
		LCALL	XIESJ
		POP		ACC
		MOV		A,#0C4H
		LCALL	XIEZL
		PUSH	ACC
		MOV		A,B
		ADD		A,#30H
		LCALL	XIESJ
		POP		ACC
		MOV		A,#0C6H
		LCALL	XIEZL
		PUSH	ACC
		MOV		A,DS0
		MOV		B,#10
		DIV		AB
		ADD		A,#30H
		LCALL	XIESJ
		POP		ACC
		MOV		A,#0C7H
		LCALL	XIEZL
		PUSH	ACC
		MOV		A,B
		ADD		A,#30H
		LCALL	XIESJ
		POP		ACC
		AJMP	MAI1

TABL1:	DB	"TIME:",00H
TABL2:	DB	"0123456789",00H
TABL3:	DB	":",00H
TABL4:	DB	"PM",00H
TIME:	PUSH	ACC	
		PUSH	PSW
		INC		JSBZ
		MOV		A,JSBZ
		CJNE	A,#20,TIC
		MOV		JSBZ,#0
		INC		DS0
		MOV		A,DS0
		CJNE	A,#60,TIC
		MOV		DS0,#0
		INC		DS1
		MOV		A,DS1
		CJNE	A,#60,TIC
		MOV		DS1,#0
		INC		DS2
		MOV		A,DS2
		CJNE	A,#24,TIC
		MOV		DS2,#0
TIC:	MOV		TH0,#3CH
		MOV		TL0,#0B0H
		POP		PSW
		POP		ACC
		RETI
LCD_INIT:
		LCALL	YS5MS
		LCALL	YS5MS
		LCALL	YS5MS
		MOV		B,#3
IN1:	MOV		A,#3CH
		LCALL	XIEZL
		LCALL	YS5MS
		DJNZ	B,IN1
		MOV		A,#38H
		LCALL	XIEZL
		LCALL	YS5MS
		MOV		A,#0CH
		LCALL	XIEZL
		LCALL	YS5MS
		MOV		A,#1
		LCALL	XIEZL
		LCALL	YS5MS
		RET
XIEZL:	MOV		P0,A
		CLR		RS
		CLR		RW
		SETB	E
		LCALL	YS500MS
		CLR		E
		RET
XIESJ:	MOV		P0,A
		SETB	RS
		CLR		RW
		SETB	E
		LCALL	YS500MS
		CLR		E
		RET
XRWC:	PUSH	ACC
XR1:	CLR		A
		MOVC	A,@A+DPTR
		JZ		XRC
		INC		DPTR
		LCALL	XIESJ
		JMP		XR1
XRC:	POP		ACC
		RET
YS5MS:	MOV		R6,#10
Y51:	MOV		R7,#249
		DJNZ	R7,$
		DJNZ	R6,Y51
		RET
YS500MS:
		MOV		R5,#5
Y01:	MOV		R6,#100
		DJNZ	R6,$
		DJNZ	R5,Y01
		RET
		END