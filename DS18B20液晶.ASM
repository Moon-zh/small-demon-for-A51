CS2		EQU		P2.0
CS1		EQU		P2.1
E		EQU		P2.2
RW		EQU		P2.3
RS		EQU		P2.4
DS18B20	EQU		P2.6
XJ		EQU		30H
ZS		EQU		31H
BZ		EQU		32H
YD		EQU		33H
XD		EQU		34H
TB1		EQU		35H
TB2		EQU		36H
ZSZJ	EQU		37H
CISHU	EQU		38H
SW		EQU		60H
GW		EQU		41H
XS		EQU		42H
DS6		EQU		43H
DS7		EQU		44H
		ORG		00H
		AJMP	MAIN
		ORG		30H

MAIN:	MOV		SP,#80H
		LCALL	LED_INIT
		MOV		SW,#0
		MOV		GW,#0
		MOV		XS,#0
MM1:	LCALL	DS18B20WORK
		LCALL	BIN
		LCALL	M1
		AJMP	MM1




M1:		MOV		DPTR,#TAB
		MOV		A,SW
		MOV		B,#16
		MUL		AB
		MOV		TB1,A
		MOV		A,SW
		MOV		B,#2
		MUL		AB
		MOV		BZ,A
		MOV		TB2,#8
		MOV		YD,#40H
		MOV		XD,#0B8H
		MOV		ZS,#1
		MOV		CISHU,#8
		SETB	CS1
		CLR		CS2
		LCALL	XIECX

		MOV		A,GW
		MOV		B,#16
		MUL		AB
		MOV		TB1,A
		MOV		A,GW
		MOV		B,#2
		MUL		AB
		MOV		BZ,A
		MOV		TB2,#8
		MOV		YD,#50H
		MOV		XD,#0B8H
		MOV		ZS,#1
		MOV		CISHU,#8
		SETB	CS1
		CLR		CS2
		LCALL	XIECX

		MOV		A,XS
		MOV		B,#16
		MUL		AB
		MOV		TB1,A
		MOV		A,XS
		MOV		B,#2
		MUL		AB
		MOV		BZ,A
		MOV		TB2,#8
		MOV		XD,#0B8H
		MOV		YD,#60H
		MOV		ZS,#1
		MOV		CISHU,#8
		SETB	CS1
		CLR		CS2
		LCALL	XIECX
		RET

XIECX:	MOV		A,#0C0H
		LCALL	XIEZL
		MOV		XJ,#2
		MOV		50H,XJ
		MOV		40H,#1
		MOV		ZSZJ,ZS
TU1:	MOV		A,XD
		LCALL	XIEZL
		MOV		A,YD
		LCALL	XIEZL
		MOV		51H,CISHU
TU2:	MOV		A,TB1
		MOVC	A,@A+DPTR
		INC		TB1
		LCALL	XIESJ
		DJNZ	51H,TU2
		MOV		A,ZS
		CJNE	A,#1,TU3
		AJMP	TU4
TU3:	MOV		A,50H
		MOV		B,40H
		MUL		AB
		ADD		A,BZ
		MOV		B,CISHU
		MUL		AB
		MOV		TB1,A
TU4:	MOV		51H,CISHU
		INC		40H
		DJNZ	ZSZJ,TU2
		INC		XD
		MOV		ZSZJ,ZS
		MOV		40H,#1
		INC		BZ
		MOV		A,BZ
		MOV		B,TB2
		MUL		AB
		MOV		TB1,A
		DJNZ	XJ,TU1
		RET
LED_INIT:
		CLR		CS1
		SETB	CS2
		MOV		A,#3FH
		LCALL	XIEZL
		LCALL	QP
		SETB	CS1
		CLR		CS2
		MOV		A,#3FH
		LCALL	XIEZL
		LCALL	QP
		RET
QP:		MOV		XD,#0B8H
		MOV		XJ,#8
QP1:	MOV		A,XD
		LCALL	XIEZL
  		MOV		A,40H
		LCALL	XIEZL
		MOV		CISHU,#64
QP2:	MOV		A,#0
		LCALL	XIESJ
  		DJNZ	CISHU,QP2
		INC		XD
  		DJNZ	XJ,QP1
	RET
XIEZL:	CLR		E
		CLR		RW
  		CLR		RS
		MOV		P0,A
  		SETB	E
		CLR		E
  		RET
XIESJ:	CLR		E
		CLR		RW
  		SETB	RS
		MOV		P0,A
  		SETB	E
		CLR		E
		RET

CS18B20:CLR		DS18B20
		MOV		R0,#250
		DJNZ	R0,$
		SETB	DS18B20
		MOV		R0,#35
		DJNZ	R0,$
		JNB		DS18B20,$
		SETB	DS18B20
		MOV		R0,#50
		DJNZ	R0,$
		RET
E18B20:	MOV		B,#08H
E1:		RRC		A
		CLR		DS18B20
		NOP
		NOP
		NOP
		NOP
		NOP
		MOV		DS18B20,C
		MOV		R0,#28
		DJNZ	R0,$
		SETB	DS18B20
		DJNZ	B,E1
		RET
RD18B20:MOV		B,#08H
		MOV		A,#00H
		CLR		C
RD1:	CLR		DS18B20
		NOP
		NOP
		NOP
		NOP
		SETB	DS18B20
		MOV		C,DS18B20
		RRC		A
		MOV		R0,#23
		DJNZ	R0,$
		SETB	DS18B20
		DJNZ	B,RD1
		RET
DS18B20WORK:
		JNB		DS18B20,OUT
		CLR		P3.5
		LCALL	CS18B20
		MOV		A,#0CCH
		LCALL	E18B20
		MOV		A,#0BEH
		LCALL	E18B20
		LCALL	RD18B20
		MOV		B,A
		SWAP	A
		ANL		A,#0FH
		MOV		DS7,A
		MOV		A,B
		ANL		A,#0FH
		MOV		DS6,A
		LCALL	RD18B20
		RL		A
		RL		A
		RL		A
		RL		A
		ADD		A,DS7
		MOV		DS7,A

		LCALL	YS
		LCALL	YS

		LCALL	CS18B20
		MOV		A,#0CCH
		LCALL	E18B20
		MOV		A,#44H
		LCALL	E18B20
OUT:	RET
BIN:	MOV		A,DS7
		MOV		B,#10
		DIV		AB
		MOV		SW,A
		MOV		GW,B
		MOV		A,DS6
		MOV		DPTR,#TAB1
		MOVC	A,@A+DPTR
		MOV		B,#10
		DIV		AB
		MOV		XS,A
		RET
YS:		MOV		R6,#0FFH
		DJNZ	R6,$
		RET
TAB1:	DB	00,06,13,19,25,31
		DB	38,44,50,56,62,69
		DB	75,81,88,94


TAB:;--  文字:  0  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,0E0H,010H,008H,008H,010H,0E0H,000H,000H,00FH,010H,020H,020H,010H,00FH,000H

;--  文字:  1  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,010H,010H,0F8H,000H,000H,000H,000H,000H,020H,020H,03FH,020H,020H,000H,000H

;--  文字:  2  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,070H,008H,008H,008H,088H,070H,000H,000H,030H,028H,024H,022H,021H,030H,000H

;--  文字:  3  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,030H,008H,088H,088H,048H,030H,000H,000H,018H,020H,020H,020H,011H,00EH,000H

;--  文字:  4  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,0C0H,020H,010H,0F8H,000H,000H,000H,007H,004H,024H,024H,03FH,024H,000H

;--  文字:  5  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,0F8H,008H,088H,088H,008H,008H,000H,000H,019H,021H,020H,020H,011H,00EH,000H

;--  文字:  6  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,0E0H,010H,088H,088H,018H,000H,000H,000H,00FH,011H,020H,020H,011H,00EH,000H

;--  文字:  7  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,038H,008H,008H,0C8H,038H,008H,000H,000H,000H,000H,03FH,000H,000H,000H,000H

;--  文字:  8  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,070H,088H,008H,008H,088H,070H,000H,000H,01CH,022H,021H,021H,022H,01CH,000H

;--  文字:  9  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,0E0H,010H,008H,008H,010H,0E0H,000H,000H,000H,031H,022H,022H,011H,00FH,000H


		END
