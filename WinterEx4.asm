LED BIT P1.0
LEDBuf BIT 0
ORG 0000H
LJMP MAIN
ORG 0000BH
LJMP INTERRUPT
ORG 0030H

MAIN:CLR LEDBuf
     CLR LED
     MOV TCON,#00H      ;设置外部中断0为低电平触发
     MOV IE,#81H        ;允许中断，允许外部输入口0中断
     LJMP $

INTERRUPT:PUSH PSW      ;保护现场
          CPL LEDBuf    ;取反
	  MOV C,LEDBuf
	  MOV LED,C
	  POP PSW       ;恢复现场
	  RETI

     END
