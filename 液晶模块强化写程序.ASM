适用于任何字体

无特殊字体（只有8*16和16*16），可以省去XJ1，给XJ直接赋值，TU4处可直接减2次XD


YJGY2:	SETB	CS1
	CLR	CS2
YJGY3:	MOV	CISHU,#16
	MOV	XJ1,#2
	LCALL	XIECX
	RET

YJGY:	SETB	CS1
	CLR	CS2
YJGY1:	MOV	CISHU,#32
	MOV	XJ1,#5
	LCALL	XIECX
	RET
XIECX:	MOV	A,#0C0H
	LCALL	XIEZL
TU1:	MOV	XJ,XJ1
TU2:	PUSH	YD
	CLR	20H.0
	MOV	CSZJ,CISHU
	LCALL	XIE
TU3:	MOV	A,TB1
	MOVC	A,@A+DPTR
	LCALL	XIESJ
	INC	DPTR
	INC	YD
	LCALL	TU0
	DJNZ	CSZJ,TU3
	INC	XD
	POP	YD
	LCALL	PDQF
	DJNZ	XJ,TU2
	MOV	B,XJ1
TU4:	DEC	XD
	DJNZ	B,TU4
	MOV	A,YD
	ADD	A,CISHU
	MOV	YD,A
	LCALL	TU0
	DJNZ	ZS,TU1
	MOV	TB1,#0
	RET

TU0:	MOV	A,YD
	CLR	C
	SUBB	A,#80H
	JC	TUC
	ADD	A,#40H
	MOV	YD,A
	SETB	20H.0
	LCALL	PDQF
	LCALL	XIE
TUC:	RET

PDQF:	JNB	20H.0,TUC
	CPL	CS1
	CPL	CS2
	MOV	A,#0C0H
	LCALL	XIEZL
	RET

XIE:	MOV	A,XD
	LCALL	XIEZL
	MOV	A,YD
	LCALL	XIEZL
	RET