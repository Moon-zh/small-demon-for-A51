CS2	EQU	P2.2
CS1	EQU	P2.3
E	EQU	P2.4
RS	EQU	P2.5
XD	EQU	30H
YD	EQU	31H
BZ	EQU	32H
XJ	EQU	33H
TB1	EQU	34H
TB2	EQU	35H
ZSZJ	EQU	36H
CISHU	EQU	37H
ZS	EQU	38H
AJBZ	EQU	20H.1
C0	EQU	P3.3
C1	EQU	P3.2
C2	EQU	P3.1
C3	EQU	P3.0
	ORG	00H
	AJMP	MAIN
	ORG	30H
MAIN:	MOV	SP,#80H
	MOV	52H,#1
	MOV	41H,#2
	MOV	42H,#3
	MOV	43H,#4
	MOV	44H,#5
	MOV	45H,#6
MAI:	LCALL	LCD_INIT
	LCALL	YJMA
M1:	LCALL	AJPD
	MOV	46H,7AH
	MOV	P3,#0EFH
	JNB	C0,MAI
	JB	AJBZ,M1
	MOV	YD,#40H
	LCALL	YJSZ
	LCALL	YS1S
M2:	LCALL	AJPD
	MOV	47H,7AH
	MOV	P3,#0EFH
	JNB	C0,MAI
	JB	AJBZ,M2
	MOV	YD,#48H
	LCALL	YJSZ
	LCALL	YS1S
M3:	LCALL	AJPD
	MOV	48H,7AH
	MOV	P3,#0EFH
	JNB	C0,MAI
	JB	AJBZ,M3
	MOV	YD,#50H
	LCALL	YJSZ
	LCALL	YS1S
M4:	LCALL	AJPD
	MOV	49H,7AH
	MOV	P3,#0EFH
	JNB	C0,MAI
	JB	AJBZ,M4
	MOV	YD,#58H
	LCALL	YJSZ
	LCALL	YS1S
M5:	LCALL	AJPD
	MOV	4AH,7AH
	MOV	P3,#0EFH
	JNB	C0,MAI
	JB	AJBZ,M5
	MOV	YD,#60H
	LCALL	YJSZ
	LCALL	YS1S
M6:	LCALL	AJPD
	MOV	4BH,7AH
	MOV	P3,#0EFH
	JNB	C0,MAA
	JB	AJBZ,M6
	MOV	YD,#68H
	LCALL	YJSZ
	LCALL	YS1S	
	MOV	A,46H
	CJNE	A,52H,MAA
	MOV	A,47H
	CJNE	A,41H,MAA
	MOV	A,48H
	CJNE	A,42H,MAA
	MOV	A,49H
	CJNE	A,43H,MAA
	MOV	A,4AH
	CJNE	A,44H,MAA
	MOV	A,4BH
	CJNE	A,45H,MAA
MAI1:	LCALL	LCD_INIT
	LCALL	YJMA
	LCALL	YJXMA
	AJMP	M11
MAA:	AJMP	MAI
M11:	LCALL	AJPD
	MOV	52H,7AH
	MOV	P3,#0EFH
	JNB	C0,MAI1
	JB	AJBZ,M11
	MOV	YD,#40H
	LCALL	YJSZ
	LCALL	YS1S
M21:	LCALL	AJPD
	MOV	41H,7AH
	MOV	P3,#0EFH
	JNB	C0,MAI1
	JB	AJBZ,M21
	MOV	YD,#48H
	LCALL	YJSZ
	LCALL	YS1S
M31:	LCALL	AJPD
	MOV	42H,7AH
	MOV	P3,#0EFH
	JNB	C0,MAI1
	JB	AJBZ,M31
	MOV	YD,#50H
	LCALL	YJSZ   
	LCALL	YS1S
M41:	LCALL	AJPD
	MOV	43H,7AH
	MOV	P3,#0EFH
	JNB	C0,MAI1
	JB	AJBZ,M41
	MOV	YD,#58H
	LCALL	YJSZ
	LCALL	YS1S
M51:	LCALL	AJPD
	MOV	44H,7AH
	MOV	P3,#0EFH
SS:	JNB	C0,MAI1
	JB	AJBZ,M51
	MOV	YD,#60H
	LCALL	YJSZ
	LCALL	YS1S
M61:	LCALL	AJPD
	MOV	45H,7AH
	MOV	P3,#0EFH
	JNB	C0,SS
	JB	AJBZ,M61
	MOV	YD,#68H
	LCALL	YJSZ
	LCALL	YS1S
	AJMP	MAI
AJPD:	MOV	P3,#7FH
	JNB	C0,AJ1
	JNB	C1,AJ2
	JNB	C2,AJ3
	JNB	C3,AJ4
	MOV	P3,#0BFH
	JNB	C0,AJ5
	JNB	C1,AJ6
	JNB	C2,AJ7
	JNB	C3,AJ8
	MOV	P3,#0DFH
	JNB	C0,AJ9
	JNB	C1,AJ0
	SETB	AJBZ
	RET
AJ1:	JNB	C0,$
	MOV	7AH,#1
	CLR	AJBZ
	RET
AJ2:	JNB	C1,$
	MOV	7AH,#2
	CLR	AJBZ
	RET
AJ3:	JNB	C2,$
	MOV	7AH,#3
	CLR	AJBZ
	RET
AJ4:	JNB	C3,$
	MOV	7AH,#4
	CLR	AJBZ
	RET
AJ5:	JNB	C0,$
	MOV	7AH,#5
	CLR	AJBZ
	RET
AJ6:	JNB	C1,$
	MOV	7AH,#6
	CLR	AJBZ
	RET
AJ7:	JNB	C2,$
	MOV	7AH,#7
	CLR	AJBZ
	RET
AJ8:	JNB	C3,$
	MOV	7AH,#8
	CLR	AJBZ
	RET
AJ9:	JNB	C0,$
	MOV	7AH,#9
	CLR	AJBZ
	RET
AJ0:	JNB	C1,$
	MOV	7AH,#0
	CLR	AJBZ
	RET





YS1S:	MOV	R5,#3
Y1:	MOV	R6,#250
Y2:	MOV	R7,#250
	DJNZ	R7,$
	DJNZ	R6,Y2
	DJNZ	R5,Y1
	RET
YJMA:	MOV	DPTR,#TABMA
	MOV	XD,#0B8H
	MOV	YD,#40H
	MOV	ZS,#4
	CLR	CS2
	SETB	CS1
	LCALL	YJGY
	MOV	DPTR,#MA1
	MOV	XD,#0B8H
	MOV	YD,#40H
	MOV	ZS,#2
	CLR	CS1
	SETB	CS2
	LCALL	YJGY
	RET
YJXMA:	MOV	DPTR,#TABXMA
	MOV	XD,#0B8H
	MOV	YD,#70H
	MOV	ZS,#1
	CLR	CS2
	SETB	CS1
	LCALL	YJGY
	MOV	DPTR,#TABM
	MOV	XD,#0B8H
	MOV	YD,#40H
	MOV	ZS,#3
	CLR	CS1
	SETB	CS2
	LCALL	YJGY
	RET
YJSZ:	MOV	DPTR,#TABSZ
	MOV	XD,#0BAH
	MOV	ZS,#1
	CLR	CS2
	SETB	CS1
	MOV	A,7AH
	LCALL	YJGY2
	RET

YJGY2:	MOV	B,#16
	MUL	AB
	MOV	TB1,A
	MOV	TB2,#8
	MOV	CISHU,#8
	LCALL	XIECX
	RET

YJGY:	MOV	TB1,#0
	MOV	TB2,#16
	MOV	CISHU,#16
	LCALL	XIECX
	RET


XIECX:	MOV	BZ,#0
	MOV	39H,TB1
	MOV	A,#0C0H
	LCALL	XIEZL
	MOV	XJ,#2
	MOV	50H,XJ
	MOV	40H,#1
	MOV	ZSZJ,ZS
TU1:	MOV	A,XD
	LCALL	XIEZL
	MOV	A,YD
	LCALL	XIEZL
	MOV	51H,CISHU
TU2:	MOV	A,TB1
	MOVC	A,@A+DPTR
	INC	TB1
	LCALL	XIESJ
	DJNZ	51H,TU2
	MOV	A,ZS
	CJNE	A,#1,TU3
	AJMP	TU4
TU3:	MOV	A,50H
	MOV	B,40H
	MUL	AB
	ADD	A,BZ
	MOV	B,CISHU
	MUL	AB
	ADD	A,39H
	MOV	TB1,A
TU4:	MOV	51H,CISHU
	INC	40H
	DJNZ	ZSZJ,TU2
	INC	XD
	MOV	ZSZJ,ZS
	MOV	40H,#1
	INC	BZ
	MOV	A,BZ
	MOV	B,TB2
	MUL	AB
	ADD	A,39H
	MOV	TB1,A
	DJNZ	XJ,TU1
	RET
LCD_INIT:
	SETB	CS1
	SETB	CS2
	MOV	A,#3FH
	LCALL	XIEZL
	LCALL	QP
	RET
QP:	MOV	XD,#0B8H	
	MOV	XJ,#8
QP1:	MOV	A,XD
	LCALL	XIEZL
	MOV	A,#52H
	LCALL	XIEZL
	MOV	CISHU,#64
QP2:	MOV	A,#0
	LCALL	XIESJ
	DJNZ	CISHU,QP2
	INC	XD
	DJNZ	XJ,QP1
	RET
XIEZL:	CLR	E
	CLR	RS
	MOV	P0,A
	SETB	E
	CLR	E
	RET
XIESJ:	CLR	E
	SETB	RS
	MOV	P0,A
	SETB	E
	CLR	E
	RET
TABMA: ;--  文字:  请  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  052H,042H,04CH,0C4H,000H,022H,0AAH,0AAH,0AAH,0BFH,0AAH,0AAH,0AAH,022H,020H,000H
DB  000H,000H,000H,07FH,020H,010H,0FFH,00AH,00AH,00AH,04AH,08AH,07FH,000H,000H,000H

;--  文字:  输  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  044H,0F4H,04FH,0E4H,044H,064H,090H,098H,094H,093H,014H,098H,008H,0D0H,010H,000H
DB  004H,004H,004H,0FFH,002H,002H,0FFH,04AH,08AH,07FH,000H,03FH,080H,0FFH,000H,000H

;--  文字:  入  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,000H,000H,000H,001H,083H,076H,018H,060H,080H,000H,000H,000H,000H,000H,000H
DB  052H,020H,010H,008H,006H,001H,000H,000H,000H,000H,003H,004H,018H,030H,010H,000H
TABM:
;--  文字:  密  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,058H,024H,004H,0F4H,004H,08DH,0B6H,044H,034H,0CCH,094H,024H,0CCH,004H,000H
DB  002H,006H,002H,079H,041H,041H,041H,07DH,041H,041H,041H,052H,078H,000H,000H,000H
MA1:
;--  文字:  码  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  002H,082H,0E2H,05EH,042H,0C2H,000H,002H,0FAH,082H,082H,082H,0FEH,080H,000H,000H
DB  001H,000H,07FH,010H,010H,03FH,000H,004H,004H,004H,044H,084H,052H,03FH,000H,000H

;--  文字:  ：  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
DB  000H,000H,036H,036H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
TABXMA:;--  文字:  新  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  020H,024H,02CH,035H,0E6H,034H,02CH,024H,000H,0FCH,024H,024H,0E2H,022H,022H,000H
DB  021H,011H,04DH,081H,07FH,005H,059H,021H,018H,007H,000H,000H,0FFH,000H,000H,000H
TABSZ:;--  文字:  0  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,0E0H,010H,008H,008H,010H,0E0H,000H,000H,00FH,010H,020H,020H,010H,00FH,000H

;--  文字:  1  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,010H,010H,0F8H,000H,000H,000H,000H,000H,020H,020H,03FH,020H,020H,000H,000H

;--  文字:  2  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,070H,008H,008H,008H,088H,070H,000H,000H,030H,028H,024H,022H,021H,030H,000H

;--  文字:  3  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,030H,008H,088H,088H,048H,030H,000H,000H,018H,020H,020H,020H,011H,00EH,000H

;--  文字:  4  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,000H,0C0H,020H,010H,0F8H,000H,000H,000H,007H,004H,024H,024H,03FH,024H,000H

;--  文字:  5  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,0F8H,008H,088H,088H,008H,008H,000H,000H,019H,021H,020H,020H,011H,00EH,000H

;--  文字:  6  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,0E0H,010H,088H,088H,018H,000H,000H,000H,00FH,011H,020H,020H,011H,00EH,000H

;--  文字:  7  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,038H,008H,008H,0C8H,038H,008H,000H,000H,000H,000H,03FH,000H,000H,000H,000H

;--  文字:  8  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,070H,088H,008H,008H,088H,070H,000H,000H,01CH,022H,021H,021H,022H,01CH,000H

;--  文字:  9  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=8x16   --
DB  000H,0E0H,010H,008H,008H,010H,0E0H,000H,000H,000H,031H,022H,022H,011H,00FH,000H

	END