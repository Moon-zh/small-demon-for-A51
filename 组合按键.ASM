CS2		EQU		P1.0
CS1		EQU		P1.1
E		EQU		P1.2
RW		EQU		P1.3
RS		EQU		P1.4
XD		EQU		30H
YD		EQU		31H
XJ		EQU		32H
BZ		EQU		33H
ZS		EQU		34H
TB1		EQU		35H
TB2		EQU		36H
ZSZJ	EQU		37H
CISHU	EQU		38H
COL3	EQU		P2.7
COL2	EQU		P2.6
COL1	EQU		P2.5
COL0	EQU		P2.4
ROW3	EQU		P2.3
ROW2	EQU		P2.2
ROW1	EQU		P2.1
ROW0	EQU		P2.0
		ORG		00H
		AJMP		MAINN
		ORG		30H
MAINN:	MOV		2AH,#0	
		LCALL	LED_INIT
MAIN:	LCALL	M1
		CLR		COL0
		JNB		ROW3,MM1
		JNB		ROW0,MM2
		JNB		ROW1,MM3
		JNB		ROW2,MM4
		AJMP	MAIN
MM1:	JB		ROW0,N1
		MOV		2AH,#7
		JNB		ROW0,$
		AJMP	MAIN
N1:		JB		ROW1,N2
		MOV		2AH,#1
		JNB		ROW1,$
		AJMP	MAIN
N2:		JB		ROW2,N3
		MOV		2AH,#2
		JNB		ROW2,$
		AJMP	MAIN
N3:		JNB		ROW3,MM1
		MOV		2AH,#3
		AJMP	MAIN  

MM2:	JNB		ROW0,$
		MOV		2AH,#4
		AJMP	MAIN
MM3:	JNB		ROW1,$
		MOV		2AH,#5
		AJMP	MAIN
MM4:	JNB		ROW2,$
		MOV		2AH,#6
		AJMP	MAIN




M1:		MOV		DPTR,#TAB
		MOV		A,2AH
		MOV		B,#12
		MUL		AB
		MOV		TB1,A
		MOV		A,2AH
		MOV		B,#2
		MUL		AB
		MOV		BZ,A
		MOV		XD,#0B8H
		MOV		YD,#40H		
		MOV		TB2,#6
		MOV		ZS,#1
		MOV		CISHU,#6
		SETB		CS1
		CLR		CS2
		LCALL		XIECX
		RET

XIECX:		MOV		A,#0C0H
		LCALL		XIEZL
		MOV		XJ,#2
		MOV		50H,XJ
		MOV		40H,#1
		MOV		ZSZJ,ZS
TU1:		MOV		A,XD
		LCALL		XIEZL
		MOV		A,YD
		LCALL		XIEZL
		MOV		51H,CISHU
TU2:		MOV		A,TB1
		MOVC		A,@A+DPTR
		INC		TB1
		LCALL		XIESJ
		DJNZ		51H,TU2
		MOV		A,ZS
		CJNE		A,#1,TU3
		AJMP		TU4
TU3:		MOV		A,50H
		MOV		B,40H
		MUL		AB
		ADD		A,BZ
		MOV		B,CISHU
		MUL		AB
		MOV		TB1,A
TU4:		MOV		51H,CISHU
		INC		40H
		DJNZ		ZSZJ,TU2
		INC		XD
		MOV		40H,#1
		MOV		ZSZJ,ZS
		INC		BZ
		MOV		A,BZ
		MOV		B,TB2
		MUL		AB
		MOV		TB1,A
		DJNZ		XJ,TU1
		RET
LED_INIT:
		SETB		CS1
		CLR		CS2
		MOV		A,#3FH
		LCALL		XIEZL
		LCALL		QP
		CLR		CS1
		SETB		CS2
		MOV		A,#3FH
		LCALL		XIEZL
		LCALL		QP
		RET

QP:		MOV		XJ,#8
		MOV		XD,#0B8H
QP1:		MOV		A,XD
		LCALL		XIEZL
		MOV		A,#40H
		LCALL		XIEZL	
		MOV		CISHU,#64
QP2:		MOV		A,#0H
		LCALL		XIESJ
		DJNZ		CISHU,QP2
		INC		XD
		DJNZ		XJ,QP1
		RET

XIEZL:		CLR		E
		CLR		RW
		CLR		RS
		MOV		P0,A
		SETB		E
		CLR		E
		RET

XIESJ:		CLR		E
		CLR		RW
		SETB		RS
		MOV		P0,A
		SETB		E
		CLR		E
		RET
TAB:;--  文字:  0  --
;--  宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  0F8H,004H,004H,004H,0F8H,000H,001H,002H,002H,002H,001H,000H

;--  文字:  1  --
;--  宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  000H,008H,0FCH,000H,000H,000H,000H,002H,003H,002H,000H,000H

;--  文字:  2  --
;--  宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  018H,084H,044H,024H,018H,000H,003H,002H,002H,002H,002H,000H

;--  文字:  3  --
;--  宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  008H,004H,024H,024H,0D8H,000H,001H,002H,002H,002H,001H,000H

;--  文字:  4  --
;--  宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  040H,0B0H,088H,0FCH,080H,000H,000H,000H,000H,003H,002H,000H

;--  文字:  5  --
;--  宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  03CH,024H,024H,024H,0C4H,000H,001H,002H,002H,002H,001H,000H

;--  文字:  6  --
;--  宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  0F8H,024H,024H,02CH,0C0H,000H,001H,002H,002H,002H,001H,000H

;--  文字:  7  --
;--  宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  00CH,004H,0E4H,01CH,004H,000H,000H,000H,003H,000H,000H,000H

;--  文字:  8  --
;--  宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  0D8H,024H,024H,024H,0D8H,000H,001H,002H,002H,002H,001H,000H

;--  文字:  9  --
;--  宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  038H,044H,044H,044H,0F8H,000H,000H,003H,002H,002H,001H,000H


		END	