EXTRN CODE( lm35)
EXTRN DATA (wdu,dy,sw,gw,xs,gw1,sw1,gwy1,xs1,fs1)
cs1		equ		p1.1
cs2		equ		p1.0
e		equ		p1.7
smg		equ		p0
ds0		equ		30h
ds1		equ		31h
ds2		equ		32h
ds3		equ		33h
ds4		equ		34h
ds5		equ		35h
ds6		equ		36h
ds7		equ		37h
		org		0h
		ajmp	main
		org		30h
main:		mov		sp,#60h
		mov		ds0-ds7,#10
zcx:		lcall	lm35
		lcall	pd
		lcall	my
		ajmp	zcx
pd:		mov		ds2,sw
		mov		ds1,gw
		mov		ds0,xs
		mov		ds7,sw1
		mov		ds6,gw1
		mov		ds5,xs1
		mov		a,#3
		clr		c
		subb	a,ds2
		jc		jw
		clr		p1.5
ck:		ret
jw:		setb	p1.5
		ajmp	ck
my:		mov		dptr,#tab
		mov		r0,#8
		mov		r1,#ds0
		mov		r2,#0feh
ma:		lcall	qp
		mov		a,@r1
		movc	a,@a+dptr
		cjne	r1,#ds1,ds1e
		anl	a,#07fh
		ajmp	ds7e
ds1e:	cjne	r1,#ds7,ds7e
		anl		a,#07fh
ds7e:	mov		smg,a
		clr		e
		clr		cs1
		setb	e
		setb	cs1
		inc		r1
		mov		a,r2
		mov		smg,a
		rl		a
		mov		r2,a
		clr		e
		clr		cs2
		setb	e
		setb	cs2
		lcall	ys
		djnz	r0,ma
		lcall	qp
		ret
qp:		mov		smg,#0ffh
		clr		e
		clr		cs1
		setb	e
		setb	cs1
		clr		e
		clr		cs2
		setb	e
		setb	cs2
		ret
ys:		mov		r5,#40
ys1:	mov		r6,#30
		djnz	r6,$
		djnz	r5,ys1
		ret
tab:db	0c0h,0f9h,0a4h,0b0h,99h,92h,82h,0f8h,80h,90h,0ffh
		end
#include <reg52.h>
#define uchar unsigned char
#define uint unsigned int
#define DATA P0
uint wdu,dy;
uchar	gw,sw,gwy,xs;
uchar	gw1,sw1,gwy1,xs1,fs1,fsy;
sbit R=P3^0;
sbit W=P3^1;
sbit A=P3^2;

void delay(uint j)
{
	while(j--);
}
void lm35()
{
	uchar i,k;
	W=1;
	A=0;
	DATA=0xff;
	W=0;
	W=1;
	delay(30);
	R=0;
	i=DATA;
	R=1;
	wdu=(uint)(i*3.92);
	sw=(uchar)(wdu/100);
	gwy=(uchar)(wdu%100);
	gw=(uchar)(gwy/10);
	xs=(uchar)(gwy%10);

	W=1;
	A=1;
	DATA=0xff;
	W=0;
	W=1;
	delay(30);
	R=0;
	k=DATA;
	R=1;
	dy=(uint)(500.0/255.0*k);
	sw1=(uchar)(dy/100);
	gwy1=(uchar)(dy%100);
	gw1=(uchar)(gwy1/10);
	xs1=(uchar)(gwy1%10);
	fs1=(uchar)(gwy1%100*100);
}