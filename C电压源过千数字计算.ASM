#include <reg52.h>
#define uint unsigned int
#define uchar unsigned char
#define DATA P0
uint wdu;
uchar gw,sw,xs,gwy,xsx;
sbit	R=P3^0;
sbit	W=P3^1;

void delay(uint j)
{
	while(j--);
	}
void	cc()
{
    uint i;
    W=1;
    DATA=0xff;
    W=0;
    W=1;
    delay(30);
    R=0;
    i=DATA;
    R=1;
    wdu=(uint)(9500.0/255.0*i);
    sw=(uchar)(wdu/1000);
    gw=(uchar)(wdu%1000/100);
    xs=(uchar)(wdu%1000%100/10);
    xsx=(uchar)(wdu%1000%100%10/1);

}