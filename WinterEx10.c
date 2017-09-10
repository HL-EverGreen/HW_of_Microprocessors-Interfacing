#include<at89x52.h>
#include<intrins.h>
#define _Nop() _nop_()

#define uint unsigned int
#define uchar unsigned char

sbit PWM1=P3^0;
sbit PWM2=P3^1;

#DEFINE Pulse (P3_5)
#DEFINE RIGHT_KEY (!(P2_0))
#DEFINE UP_KEY    (!(P2_1))
#DEFINE DOWN_KEY  (!(P2_2))
#DEFINE LEFT_KEY  (!(P2_3))

bit Moto_Dir=0;
uchar PWM_TIME_H,PWM_TIME_L,flag;
uint Speed;
uchar Dis5,Dis4,Dis3,Dis2,Dis1;
uchar DisBit;
uchar code table[18]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F,0x77,0x7C,0x58,0x5E,0x7B,0x71,0x00,0x40};

void ShortDelay(void)  //短延时
{
uchar x,y;
for(x=0;x<5;x++)
for(y=0;y<125;y++)
_Nop()
return;
}

void delay_ms(uchar i)  //PWM延时
{
uchar x,y,z;
for(x=0;x<i;x++)
{
   for(y=0;y<5;y++)
   {
     for(z=0;z<10;z++)
      _Nop();
   }
}
return;
}

void PWM_OUT(void)
{
  if(Moto_Dir==1)
  {
    PWM1=1;
    PWM2=1;
    delay_ms(PWM_TIME_H);
    PWM2=0;
    delay_ms(PWM_TIME_L);
  }
else
{
    PWM1=1;
    PWM2=1;
    delay_ms(PWM_TIME_H);
    PWM1=0;
    delay_ms(PWM_TIME_L);
}
}

void Display(void){
    DisBit=0x01;
    P1=DisBit;
    P0=table[Dis1];
    delay_ms(10);
    DisBit=DisBit<<1;
    P1=DisBit;
    P0=table[Dis2];
    delay_ms(10);
    DisBit=DisBit<<1;
    P1=DisBit;
    P0=table[Dis3];
    delay_ms(10);
    DisBit=DisBit<<1;
    P1=DisBit;
    P0=table[Dis4];
    delay_ms(10);
    DisBit=DisBit<<1;
    P1=DisBit;
    P0=table[Dis5];
    delay_ms(10);
    return;
}

void timer0(void) interrupt 1 using 1{
if(flag==0){
flag=100;
Speed=TH1*256+TL1;
Dis1=Speed%10;
Speed=Speed/10;
Dis2=Speed%10;
Speed=Speed/10;
Dis3=Speed%10;
Speed=Speed/10;
Dis4=Speed%10;
Speed=Speed/10;
Dis5=Speed%10;
Speed=Speed/10;
TH1=0;
TL1=0;}
else
flag=flag-1;

TL0=(65536-10000)/256;
TH0=(65536-10000)%256;
return;
}

void main(void){
PWM1=0;
PWM2=0;
PWM_TIME_H=5;
PWM_TIME_L=5;

TMOD=0x51;
TL1=0;
TH1=0;
flag=100;
TL0=(65536-10000)/256;
TH0=(65536-10000)%256;
TR0=1;
TR1=1;
EA=1;
ET0=1;

while(1)
{
 if(LEFT_KEY)
 {
   ShortDelay()
   if(LEFT_KEY)          //延时去抖动
  {
   Moto_Dir=1;
   PWM1=0;
   PWM2=1;
}
   while(LEFT_KEY)PWM_OUT();
}
  if(RIGHT_KEY)
  {
   ShortDelay();
   if(RIGHT_KEY)        //延时去抖动
   {
    Moto_Dir=0;
    PWM1=1;
    PWM2=0;
   }
  while(RIGHT_KEY)PWM_OUT();
}

if(UP_KEY)
{
  ShortDelay();
  if(UP_KEY)            //延时去抖动
  {
  if(PWM_TIME_L>0)
  {
  PWM_TIME_L--;
  PWM_TIME_H=10-PWM_TIME_L;
   }
  }
while(UP_KEY)Display();
PWM_OUT();
}

if(DOWN_KEY)
{
ShortDelay();
if(DOWN_KEY)           //延时去抖动
{
  if(PWM_TIME_L<10)
   {PWM_TIME_L++;
    PWM_TIME_H=10-PWM_TIME_L;
   }
  }
while(DOWN_KEY)Display();
   PWM_OUT();
}
PWM_OUT();
Display();
}
}
