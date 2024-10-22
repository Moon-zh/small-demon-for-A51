ROW0	EQU		P2.0
ROW1	EQU		P2.1
COL0	EQU		P2.2
COL1	EQU		P2.3
COL2	EQU		P2.4
COL3	EQU		P2.5
DS18B20	EQU		P1.5
DZ		EQU		P0
SW		EQU		30H
GW		EQU		31H
XS		EQU		32H
XS1		EQU		33H
SW1		EQU		34H
GW1		EQU		35H
X1S		EQU		36H
XS11	EQU		37H
DS7		EQU		38H
DS6		EQU		39H
		ORG		00H
		AJMP	MAIN
		ORG		30H
MAIN:	MOV		DPTR,#TAB
		MOV		SW,#0
		MOV		GW,#0
		MOV		XS,#0
		MOV		XS1,#0
		MOV		R5,#0
		MOV		R1,#1
M1:		LCALL	DS18B20WORK
		LCALL	BIN
		MOV		R5,#0
		MOV		R1,#1
		MOV		DPTR,#TAB
		MOV		A,SW
		MOV		B,#16
		MUL		AB
		MOV		SW1,A
		
		MOV		A,GW
		MOV		B,#16
		MUL		AB
		MOV		GW1,A

		MOV		A,XS
		MOV		B,#16
		MUL		AB
		MOV		X1S,A

		MOV		A,XS1
		MOV		B,#16
		MUL		AB
		MOV		XS11,A

		LCALL	L1
		AJMP	M1
L1:		LCALL	QP
		LCALL	XZCX
		LCALL	SYCX
		MOV		A,R1
		RL		A
		MOV		R1,A
		INC		R5
		CJNE	R5,#8,L1
		MOV		R1,#1
L2:		LCALL	QP
		LCALL	XZCX
		LCALL	XYCX
		MOV		A,R1
		RL		A
		MOV		R1,A
		INC		R5
		CJNE	R5,#16,L2
		RET
SYCX:	MOV		DZ,R1
		SETB	ROW0
		CLR		ROW0
		LCALL	YS	
		RET
XYCX:	MOV		DZ,R1
		SETB	ROW1
		CLR		ROW1
		LCALL	YS
		RET
QP:		MOV		DZ,#0
		SETB	ROW0
		CLR		ROW0
		SETB	ROW1
		CLR		ROW1
		RET
YS:		MOV		R6,#0FFH
		DJNZ	R6,$
		RET
XZCX:	MOV		A,SW1
		MOVC	A,@A+DPTR
		MOV		DZ,A
		SETB	COL0
		CLR		COL0
		INC		SW1
		
		MOV		A,GW1
		MOVC	A,@A+DPTR
		MOV		DZ,A
		SETB	COL2
		CLR		COL2
		INC		GW1

		MOV		A,X1S
		MOVC	A,@A+DPTR
		MOV		DZ,A
		SETB	COL1
		CLR		COL1
		INC		X1S

		MOV		A,XS11
		MOVC	A,@A+DPTR
		MOV		DZ,A
		SETB	COL3
		CLR		COL3
		INC		XS11
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
		MOV		XS,B
		MOV		A,DS6
		MOV		DPTR,#TAB1
		MOVC	A,@A+DPTR
		MOV		B,#10
		DIV		AB
		MOV		GW,A
		MOV		XS1,B
		RET
TAB1:DB	00,06,13,19,25,31
     DB	38,44,50,56,62,69
     DB	75,81,88,94
TAB:	;--  文字:  0  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,000H,018H,024H,042H,042H,042H,042H,042H,042H,042H,024H,018H,000H,000H

;--  文字:  1  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,000H,008H,00EH,008H,008H,008H,008H,008H,008H,008H,008H,03EH,000H,000H

;--  文字:  2  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,000H,03CH,042H,042H,042H,020H,020H,010H,008H,004H,042H,07EH,000H,000H

;--  文字:  3  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,000H,03CH,042H,042H,020H,018H,020H,040H,040H,042H,022H,01CH,000H,000H

;--  文字:  4  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,000H,020H,030H,028H,024H,024H,022H,022H,07EH,020H,020H,078H,000H,000H

;--  文字:  5  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,000H,07EH,002H,002H,002H,01AH,026H,040H,040H,042H,022H,01CH,000H,000H

;--  文字:  6  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,000H,038H,024H,002H,002H,01AH,026H,042H,042H,042H,024H,018H,000H,000H

;--  文字:  7  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,000H,07EH,022H,022H,010H,010H,008H,008H,008H,008H,008H,008H,000H,000H

;--  文字:  8  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,000H,03CH,042H,042H,042H,024H,018H,024H,042H,042H,042H,03CH,000H,000H

;--  文字:  9  --
;--  宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,000H,018H,024H,042H,042H,042H,064H,058H,040H,040H,024H,01CH,000H,000H
END

		