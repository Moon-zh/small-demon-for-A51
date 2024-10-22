CS1	EQU	P2.1
CS2	EQU	P2.2
E	EQU	P2.3
RS	EQU	P2.5
BL	EQU	P2.6
FMQ	EQU	P2.7
JR	EQU	P3.1
ZL	EQU	P3.2
DS18B20	EQU	P3.0
F2	EQU	P1.7
OK	EQU	P1.6
SET1	EQU	P1.5
F1	EQU	P1.4
ZJ	EQU	P1.3
SJ	EQU	P1.2
XXJ	EQU	P1.1
YJ	EQU	P1.0

XD	EQU	30H
YD	EQU	31H
ZS	EQU	32H
TB1	EQU	33H
CSZJ	EQU	34H
CISHU	EQU	35H
XJ	EQU	36H
W1	EQU	37H
W2	EQU	38H
WD1	EQU	39H
WD2	EQU	3AH
WD3	EQU	3BH
DW1	EQU	3CH
DW2	EQU	3DH
GW1	EQU	3EH
GW2	EQU	3FH
AJBZ	EQU	40H
FB	BIT	21H.1


	ORG	00H
	AJMP	MAIN
	ORG	0BH
	LJMP	ZD
	ORG	30H

MAIN:	MOV	SP,#80H
	CLR	ZL
	CLR	FB
	MOV	TMOD,#11H
	SETB	TR0
	SETB	ET0
	SETB	EA
	MOV	DW1,#20
	MOV	DW2,#10
	MOV	GW1,#70
	MOV	GW2,#50
	LCALL	QP
	LCALL	YJCS
MAI:	LCALL	YJWD
	JNB	SET1,SZCX
	MOV	A,WD1
	CLR	C
	SUBB	A,DW1
	JC	M1
	SETB	ZL
M1:	MOV	A,WD1
	CLR	C
	SUBB	A,DW2
	JNC	M2
	CLR	ZL
M2:	MOV	A,WD2
	CLR	C
	SUBB	A,GW2
	JNC	M3
	CLR	JR
M3:	MOV	A,WD2
	CLR	C
	SUBB	A,GW1
	JC	M4
	SETB	JR
M4:	
	AJMP	MAI
	
SZCX:	LCALL	QP
	LCALL	YJJM
	LCALL	YJGW
	LCALL	YJDW
SZ1:	CLR	FB
	LCALL	SSCX
	MOV	AJBZ,DW1
	LCALL	YJDW2
	LCALL	YJGW1
	LCALL	YJGW2
SZ10:	LCALL	YJDW1
	SETB	FB
	LCALL	AJPD
	MOV	A,AJBZ
	CLR	C
	SUBB	A,#21
	JNC	SZ13
	MOV	DW1,AJBZ
SZ13:	JNB	SET1,SZ11
	JNB	F1,SZ2		      	
	AJMP	SZ10

SZ11:	CLR	FB
	MOV	AJBZ,DW2
	LCALL	YJDW1
SZ110:	LCALL	YJDW2
	SETB	FB
	LCALL	AJPD
	MOV	A,AJBZ
	CLR	C
	SUBB	A,#10
	JC	SZ14
	MOV	DW2,AJBZ
SZ14:	JNB	SET1,SZ1
	JNB	F1,SZ2
	AJMP	SZ110

SZ2:	CLR	FB
	LCALL	SSCX
	MOV	AJBZ,GW1
	LCALL	YJDW2
	LCALL	YJDW1
	LCALL	YJGW2
SZ20:	LCALL	YJGW1
	SETB	FB
	LCALL	AJPD
	MOV	A,AJBZ
	CLR	C
	SUBB	A,#71
	JNC	SZ23
SZ23:	MOV	GW1,AJBZ
	JNB	SET1,SZ21
	JNB	F1,SZ1		      	
	AJMP	SZ20

SZ21:	CLR	FB
	MOV	AJBZ,GW2
	LCALL	YJGW1
SZ120:	LCALL	YJGW2
	SETB	FB
	LCALL	AJPD
	MOV	A,AJBZ
	CLR	C
	SUBB	A,#50
	JC	SZ24
	MOV	GW2,AJBZ
SZ24:	JNB	SET1,SZ2
	JNB	F1,SZ1X
	AJMP	SZ120
SZ1X:	AJMP	SZ1
AJPD:	JNB	SJ,SS
	JNB	XXJ,XX
	RET
SS:	LCALL	YS05S
	INC	AJBZ
	RET
XX:	LCALL	YS05S
	DEC	AJBZ
	RET
SSCX:	MOV	A,P1
	JNZ	SSC
	AJMP	SSCX
SSC:	RET
	
YS1S:	MOV	B,#2
YS3:	LCALL	YS05S
	DJNZ	B,YS3
	RET

YS05S:	MOV	R5,#4
YS1:	MOV	R6,#250
YS2:	MOV	R7,#250
	DJNZ	R7,$
	DJNZ	R6,YS2
	DJNZ	R5,YS1
	RET
	
WDCX:	MOV	DPTR,#TW1
	LCALL	ZHCX
	MOV	WD1,A
	MOV	DPTR,#TW2
	LCALL	ZHCX
	MOV	WD2,A
	MOV	DPTR,#TW3
	LCALL	ZHCX
	MOV	WD3,A
	RET

CWCX:	LCALL	BI1		
	LCALL	CS18B20
	MOV	A,#55H
	LCALL	E18B20
	PUSH	DPH
	PUSH	DPL
CW1:	CLR	A
	MOVC	A,@A+DPTR
	CJNE	A,#0FFH,CW0
	AJMP	CWC
CW0:	LCALL	E18B20
	INC	DPTR
	AJMP	CW1

CWC:	POP	DPL
	POP	DPH
	RET	 

ZHCX:	LCALL	CWCX				
	MOV	A,#44H		
	LCALL	E18B20
	LCALL	CWCX		
	MOV	A,#0BEH		
	LCALL	E18B20
	
	LCALL	RD18B20		
	SWAP	A
	ANL	A,#0FH
	MOV	W2,A
	LCALL	RD18B20
	SWAP	A	
	ADD	A,W2
	RET	

CS18B20:CLR	DS18B20		
	MOV	R0,#240
	DJNZ	R0,$
	SETB	DS18B20
	MOV	R0,#30
	DJNZ	R0,$
	JNB	DS18B20,$
	MOV	R0,#250
	DJNZ	R0,$
	RET

E18B20:	MOV	B,#08H		
E1:	CLR	DS18B20
	RRC	A
	MOV	DS18B20,C
	MOV	R0,#28
	DJNZ	R0,$
	SETB	DS18B20
	DJNZ	B,E1
	RET

RD18B20:MOV	B,#08H		
RD1:	CLR	DS18B20
	MOV	R0,#1
	DJNZ	R0,$
	SETB	DS18B20
	MOV	C,DS18B20
	RRC	A
	MOV	R0,#23
	DJNZ	R0,$
	DJNZ	B,RD1
	RET

BI1:	LCALL	CS18B20		
	MOV	A,#0CCH
	LCALL	E18B20
	RET	

TW1:	DB	28H,66H,9FH,90H,02H,00,00H,19H,0FFH//室温//18b20 序列号			  
TW2:	DB	28H,14H,0CEH,80H,02H,00,00H,8FH,0FFH//高温
TW3:	DB 	28H,0F1H,65H,90H,02H,00,00H,36H,0FFH//低温
	

YJGW:	LCALL	YJGW1
	LCALL	YJGW2
	RET

YJDW:	LCALL	YJDW1
	LCALL	YJDW2
	RET

YJGW1:	MOV	XD,#0BAH
	MOV	YD,#0A4H
	MOV	A,GW1
	MOV	B,#10
	DIV	AB
	PUSH	B
	LCALL	YJSZ1
	POP	B
	MOV	YD,#0AAH
	MOV	A,B
	LCALL	YJSZ1
	RET

YJDW1:	MOV	XD,#0BAH
	MOV	YD,#64H
	MOV	A,DW1
	MOV	B,#10
	DIV	AB
	PUSH	B	 
	LCALL	YJSZ1
	POP	B
	MOV	A,B
	LCALL	YJSZ1
	RET

YJGW2:	MOV	XD,#0BCH
	MOV	YD,#0A4H
	MOV	A,GW2
	MOV	B,#10
	DIV	AB
	PUSH	B
	LCALL	YJSZ1
	POP	B
	MOV	YD,#0AAH
	MOV	A,B
	LCALL	YJSZ1
	RET

YJDW2:	MOV	XD,#0BCH
	MOV	YD,#64H
	MOV	A,DW2
	MOV	B,#10
	DIV	AB
	PUSH	B
	LCALL	YJSZ1
	POP	B
	MOV	A,B
	LCALL	YJSZ1
	RET

YJJM:	MOV	DPTR,#TABJM
	MOV	XD,#0B8H
	MOV	YD,#59H
	MOV	ZS,#2
	LCALL	YJHZ
	MOV	YD,#99H
	MOV	ZS,#2
	LCALL	YJHZ

	MOV	XD,#0BAH
	MOV	YD,#40H
	MOV	ZS,#3
	LCALL	YJHZ1
	MOV	YD,#80H
	MOV	ZS,#3
	LCALL	YJHZ1

	MOV	YD,#70H
	MOV	ZS,#1
	LCALL	YJHZ1
	MOV	YD,#0B0H
	MOV	ZS,#1
	LCALL	YJHZ1

	MOV	XD,#0BCH
	MOV	YD,#40H
	MOV	ZS,#3
	LCALL	YJHZ1
	MOV	YD,#80H
	MOV	ZS,#3
	LCALL	YJHZ1

	MOV	YD,#70H
	MOV	ZS,#1
	LCALL	YJHZ1
	MOV	YD,#0B0H
	MOV	ZS,#1
	LCALL	YJHZ1
	RET
	
YJCS:	MOV	DPTR,#TABCS
	MOV	TB1,#0
	MOV	XD,#0B8H
	MOV	YD,#49H
	MOV	ZS,#5
	LCALL	YJHZ

	MOV	YD,#0A0H
	MOV	ZS,#2
	LCALL	YJHZ

	MOV	XD,#0BAH
	MOV	YD,#40H
	MOV	ZS,#8
	LCALL	YJHZ

	MOV	XD,#0BEH
	MOV	YD,#50H
	MOV	ZS,#1
	LCALL	YJHZ

	MOV	YD,#80H
	MOV	ZS,#1
	LCALL	YJHZ

	MOV	YD,#0A9H
	MOV	ZS,#1
	LCALL	YJHZ

	LCALL	YJWD
	RET

YJWD:	LCALL	WDCX
	MOV	XD,#0BCH
	MOV	YD,#50H
	MOV	A,WD1
	MOV	B,#10
	DIV	AB
	PUSH	B
	LCALL	YJSZ
	POP	B
	MOV	YD,#59H
	MOV	A,B
	LCALL	YJSZ

	MOV	YD,#80H
	MOV	A,WD2
	MOV	B,#10
	DIV	AB
	PUSH	B
	LCALL	YJSZ
	POP	B
	MOV	YD,#89H
	MOV	A,B
	LCALL	YJSZ

	MOV	YD,#0A9H
	MOV	A,WD3
	MOV	B,#10
	DIV	AB
	PUSH	B
	LCALL	YJSZ
	POP	B
	MOV	A,B
	MOV	YD,#0B0H
	LCALL	YJSZ
	RET

YJHZ:	MOV	CISHU,#16
	LCALL	XIECX
	RET

YJHZ1:	MOV	CISHU,#12
	LCALL	XIECX
	RET

YJSZ:	MOV	CISHU,#8
	MOV	ZS,#1
	MOV	B,#16
	MUL	AB
	MOV	TB1,A
	MOV	DPTR,#TABSZ
	LCALL	XIECX
	RET

YJSZ1:	MOV	CISHU,#6
	MOV	ZS,#1
	MOV	B,#12
	MUL	AB
	MOV	TB1,A
	MOV	DPTR,#TABSZ1
	LCALL	XIECX
	RET

QP:	CLR	BL
	SETB	CS1
	SETB	CS2
	MOV	A,#3FH
	LCALL	XIEZL
	MOV	A,#3FH
	LCALL	XIEZL
	MOV	A,#0C0H
	LCALL	XIEZL
	MOV	XJ,#8
	MOV	XD,#0B8H
	MOV	YD,#40H
	MOV	B,#64
QP1:	LCALL	XIE
	MOV	CISHU,B
QP2:	MOV	A,#0
	LCALL	XIESJ
	DJNZ	CISHU,QP2
	INC	XD
	DJNZ	XJ,QP1
	RET

XIECX:	SETB	CS1
	CLR	CS2
	LCALL	TU0
	MOV	A,#0C0H
	LCALL	XIEZL
TU1:	MOV	XJ,#2
TU2:	PUSH	YD
	MOV	CSZJ,CISHU
	CLR	21H.0
	LCALL	XIE
TU3:	MOV	A,TB1
	MOVC	A,@A+DPTR
	JNB	FB,TU4
	CPL	A
TU4:	LCALL	XIESJ
	INC	YD
	INC	DPTR
	LCALL	TU0
	DJNZ	CSZJ,TU3
	INC	XD
	LCALL	PDQF
	POP	YD
	DJNZ	XJ,TU2
	DEC	XD
	DEC	XD
	MOV	A,YD
	ADD	A,CISHU
	MOV	YD,A
	LCALL	TU0
	DJNZ	ZS,TU1
	MOV	TB1,#0
	RET

PDQF:	JNB	21H.0,TUC
	CPL	CS1
	CPL	CS2
	MOV	A,#0C0H
	LCALL	XIEZL
	RET

TU0:	MOV	A,YD
	CLR	C
	SUBB	A,#80H
	JC	TUC
	ADD	A,#40H
	MOV	YD,A
	SETB	21H.0
	LCALL	PDQF
	LCALL	XIE
TUC:	RET

XIE:	MOV	A,XD
	LCALL	XIEZL
	MOV	A,YD
	LCALL	XIEZL
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
	
TABCS:;--  文字:  低  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  040H,020H,0F0H,00CH,007H,002H,0FCH,044H,044H,042H,0FEH,043H,043H,042H,040H,000H
DB  000H,000H,07FH,000H,000H,000H,07FH,020H,010H,028H,043H,00CH,010H,020H,078H,000H

;--  文字:  温  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  010H,021H,086H,070H,000H,07EH,04AH,04AH,04AH,04AH,04AH,07EH,000H,000H,000H,000H
DB  002H,0FEH,001H,040H,07FH,041H,041H,07FH,041H,041H,07FH,041H,041H,07FH,040H,000H

;--  文字:     --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H

;--  文字:  高  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  004H,004H,004H,004H,074H,054H,055H,056H,054H,054H,074H,004H,004H,004H,004H,000H
DB  000H,0FFH,001H,001H,03DH,025H,025H,025H,025H,025H,03DH,041H,081H,07FH,000H,000H

;--  文字:  温  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  010H,021H,086H,070H,000H,07EH,04AH,04AH,04AH,04AH,04AH,07EH,000H,000H,000H,000H
DB  002H,0FEH,001H,040H,07FH,041H,041H,07FH,041H,041H,07FH,041H,041H,07FH,040H,000H

;--  文字:  一  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,080H,080H,080H,080H,080H,080H,080H,080H,080H,080H,080H,080H,0C0H,080H,000H
DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H

;--  文字:  般  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  080H,080H,0FCH,096H,0A5H,0FCH,080H,040H,03EH,002H,002H,002H,03EH,040H,040H,000H
DB  080H,060H,01FH,042H,084H,07FH,080H,041H,027H,019H,019H,025H,043H,0C1H,040H,000H
;--  文字:  工  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,000H,002H,002H,002H,002H,002H,0FEH,002H,002H,002H,002H,002H,002H,000H,000H
DB  020H,020H,020H,020H,020H,020H,020H,03FH,020H,020H,020H,020H,020H,020H,020H,000H

;--  文字:  作  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  080H,040H,020H,0F8H,007H,022H,018H,00CH,0FBH,048H,048H,048H,068H,048H,008H,000H
DB  000H,000H,000H,0FFH,000H,000H,000H,000H,0FFH,004H,004H,004H,004H,006H,004H,000H

;--  文字:  室  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,010H,02CH,024H,0A4H,064H,025H,026H,024H,024H,0A4H,024H,034H,02CH,004H,000H
DB  040H,040H,048H,049H,049H,049H,049H,07FH,049H,049H,049H,04BH,048H,040H,040H,000H

;--  文字:  工  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,000H,002H,002H,002H,002H,002H,0FEH,002H,002H,002H,002H,002H,002H,000H,000H
DB  020H,020H,020H,020H,020H,020H,020H,03FH,020H,020H,020H,020H,020H,020H,020H,000H

;--  文字:  作  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  080H,040H,020H,0F8H,007H,022H,018H,00CH,0FBH,048H,048H,048H,068H,048H,008H,000H
DB  000H,000H,000H,0FFH,000H,000H,000H,000H,0FFH,004H,004H,004H,004H,006H,004H,000H

;--  文字:  室  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,010H,02CH,024H,0A4H,064H,025H,026H,024H,024H,0A4H,024H,034H,02CH,004H,000H
DB  040H,040H,048H,049H,049H,049H,049H,07FH,049H,049H,049H,04BH,048H,040H,040H,000H

;--  文字:  室  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,010H,02CH,024H,0A4H,064H,025H,026H,024H,024H,0A4H,024H,034H,02CH,004H,000H
DB  040H,040H,048H,049H,049H,049H,049H,07FH,049H,049H,049H,04BH,048H,040H,040H,000H

;--  文字:  温  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  010H,021H,086H,070H,000H,07EH,04AH,04AH,04AH,04AH,04AH,07EH,000H,000H,000H,000H
DB  002H,0FEH,001H,040H,07FH,041H,041H,07FH,041H,041H,07FH,041H,041H,07FH,040H,000H

;--  文字:  ℃  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,002H,005H,0E2H,018H,004H,002H,002H,002H,002H,002H,002H,004H,01EH,000H,000H
DB  000H,000H,000H,007H,018H,020H,040H,040H,040H,040H,040H,040H,020H,018H,000H,000H
;--  文字:  ℃  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,002H,005H,0E2H,018H,004H,002H,002H,002H,002H,002H,002H,004H,01EH,000H,000H
DB  000H,000H,000H,007H,018H,020H,040H,040H,040H,040H,040H,040H,020H,018H,000H,000H
;--  文字:  ℃  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  000H,002H,005H,0E2H,018H,004H,002H,002H,002H,002H,002H,002H,004H,01EH,000H,000H
DB  000H,000H,000H,007H,018H,020H,040H,040H,040H,040H,040H,040H,020H,018H,000H,000H
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

TABJM:;--  文字:  低  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  040H,020H,0F0H,00CH,007H,002H,0FCH,044H,044H,042H,0FEH,043H,043H,042H,040H,000H
DB  000H,000H,07FH,000H,000H,000H,07FH,020H,010H,028H,043H,00CH,010H,020H,078H,000H

;--  文字:  温  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  010H,021H,086H,070H,000H,07EH,04AH,04AH,04AH,04AH,04AH,07EH,000H,000H,000H,000H
DB  002H,0FEH,001H,040H,07FH,041H,041H,07FH,041H,041H,07FH,041H,041H,07FH,040H,000H

;--  文字:  高  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  004H,004H,004H,004H,074H,054H,055H,056H,054H,054H,074H,004H,004H,004H,004H,000H
DB  000H,0FFH,001H,001H,03DH,025H,025H,025H,025H,025H,03DH,041H,081H,07FH,000H,000H

;--  文字:  温  --
;--  新宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  010H,021H,086H,070H,000H,07EH,04AH,04AH,04AH,04AH,04AH,07EH,000H,000H,000H,000H
DB  002H,0FEH,001H,040H,07FH,041H,041H,07FH,041H,041H,07FH,041H,041H,07FH,040H,000H

;--  文字:  上  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  000H,000H,000H,000H,000H,0FFH,010H,010H,010H,010H,000H,000H,004H,004H,004H,004H
DB  004H,007H,004H,004H,004H,004H,004H,000H

;--  文字:  限  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  0FFH,081H,099H,0E7H,000H,0FFH,025H,0E5H,025H,0BFH,040H,000H,007H,000H,000H,000H
DB  000H,007H,004H,002H,001H,002H,004H,000H

;--  文字:  ：  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  000H,000H,000H,000H,08CH,08CH,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
DB  001H,001H,000H,000H,000H,000H,000H,000H

;--  文字:  上  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  000H,000H,000H,000H,000H,0FFH,010H,010H,010H,010H,000H,000H,004H,004H,004H,004H
DB  004H,007H,004H,004H,004H,004H,004H,000H

;--  文字:  限  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  0FFH,081H,099H,0E7H,000H,0FFH,025H,0E5H,025H,0BFH,040H,000H,007H,000H,000H,000H
DB  000H,007H,004H,002H,001H,002H,004H,000H

;--  文字:  ：  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  000H,000H,000H,000H,08CH,08CH,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
DB  001H,001H,000H,000H,000H,000H,000H,000H

;--  文字:  ℃  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  00EH,00AH,00EH,0F8H,004H,002H,002H,002H,004H,08EH,000H,000H,000H,000H,000H,000H
DB  001H,002H,002H,002H,002H,001H,000H,000H

;--  文字:  ℃  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  00EH,00AH,00EH,0F8H,004H,002H,002H,002H,004H,08EH,000H,000H,000H,000H,000H,000H
DB  001H,002H,002H,002H,002H,001H,000H,000H

;--  文字:  下  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  002H,002H,002H,002H,002H,0FEH,012H,012H,022H,043H,002H,000H,000H,000H,000H,000H
DB  000H,007H,000H,000H,000H,000H,000H,000H

;--  文字:  限  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  0FFH,081H,099H,0E7H,000H,0FFH,025H,0E5H,025H,0BFH,040H,000H,007H,000H,000H,000H
DB  000H,007H,004H,002H,001H,002H,004H,000H

;--  文字:  ：  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  000H,000H,000H,000H,08CH,08CH,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
DB  001H,001H,000H,000H,000H,000H,000H,000H

;--  文字:  下  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  002H,002H,002H,002H,002H,0FEH,012H,012H,022H,043H,002H,000H,000H,000H,000H,000H
DB  000H,007H,000H,000H,000H,000H,000H,000H

;--  文字:  限  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  0FFH,081H,099H,0E7H,000H,0FFH,025H,0E5H,025H,0BFH,040H,000H,007H,000H,000H,000H
DB  000H,007H,004H,002H,001H,002H,004H,000H

;--  文字:  ：  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  000H,000H,000H,000H,08CH,08CH,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
DB  001H,001H,000H,000H,000H,000H,000H,000H

;--  文字:  ℃  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  00EH,00AH,00EH,0F8H,004H,002H,002H,002H,004H,08EH,000H,000H,000H,000H,000H,000H
DB  001H,002H,002H,002H,002H,001H,000H,000H

;--  文字:  ℃  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=12x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=12x16  --;
DB  00EH,00AH,00EH,0F8H,004H,002H,002H,002H,004H,08EH,000H,000H,000H,000H,000H,000H
DB  001H,002H,002H,002H,002H,001H,000H,000H

TABSZ1:;--  文字:  0  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  0F8H,004H,004H,004H,0F8H,000H,001H,002H,002H,002H,001H,000H

;--  文字:  1  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  000H,008H,0FCH,000H,000H,000H,000H,002H,003H,002H,000H,000H

;--  文字:  2  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  018H,084H,044H,024H,018H,000H,003H,002H,002H,002H,002H,000H

;--  文字:  3  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  008H,004H,024H,024H,0D8H,000H,001H,002H,002H,002H,001H,000H

;--  文字:  4  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  040H,0B0H,088H,0FCH,080H,000H,000H,000H,000H,003H,002H,000H

;--  文字:  5  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  03CH,024H,024H,024H,0C4H,000H,001H,002H,002H,002H,001H,000H

;--  文字:  6  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  0F8H,024H,024H,02CH,0C0H,000H,001H,002H,002H,002H,001H,000H

;--  文字:  7  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  00CH,004H,0E4H,01CH,004H,000H,000H,000H,003H,000H,000H,000H

;--  文字:  8  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  0D8H,024H,024H,024H,0D8H,000H,001H,002H,002H,002H,001H,000H

;--  文字:  9  --
;--  新宋体9;  此字体下对应的点阵为：宽x高=6x12   --
;--  高度不是8的倍数，现调整为：宽度x高度=6x16  --;
DB  038H,044H,044H,044H,0F8H,000H,000H,003H,002H,002H,001H,000H

ZD:	PUSH	ACC
	PUSH	PSW

	JB	OK,ZD1
	LCALL	QP
	CLR	FB
	LCALL	YJCS
	MOV	DPTR,#MAI
	MOV	SP,#81H
	MOV	R0,SP
	MOV	@R0,DPL
	INC	SP
	MOV	R0,SP
	MOV	@R0,DPH
	RETI

ZD1:	MOV	A,P1
	JNZ	ZDC
	SETB	FMQ
	LCALL	YS1S
	CLR	FMQ
	
ZDC:	POP	PSW
	POP	ACC
	RETI

	
	END