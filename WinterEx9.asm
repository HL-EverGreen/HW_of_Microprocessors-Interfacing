ORG 0000H
LJMP MAIN
ORG 000BH
LJMP INTERRUPT

ORG 0100H
MAIN:MOV R7,#00H
     MOV R6,#03H
     MOV TCON,#01H   ;外部中断0  下降沿触发
     MOV IE,#81H      ;允许中断，允许外部中断口0中断

INTERRUPT:
     MOV SP,#02H
     INC R7
     MOV A,R7
     MOV B,R6
     DIV AB
     MOV A,B
     CJNE A,#1H,STARTJU   ;输出方波子程序

STARTFANG:
     MOV DPTR,#0FEFFH     ;DAC0832的地址

LOOPFANG:
     MOV A,#0FFH           ;设定高电平
     MOVX @DPTR,A          ;启动D/A转换，输出高电平
     LCALL DELAYFANG       ;延时显示高电平
     MOV A,#00H            ;设定低电平
     MOVX @DPTR,A          ;启动D/A转换，输出低电平
     LCALL DELAYFANG       ;延时显示低电平
     SJMP LOOPFANG         ;连续输出方波

DELAYFANG:
     MOV R3,#11            ;延时子程序

D1FANG:
     NOP
     NOP
     NOP
     NOP
     NOP
     NOP
     DJNZ R3,D1FANG
     RET          

STARTJU:                    ;输出锯齿波子程序
     CJNE A,#2H,STARTSAN
     MOV DPTR,#0FEFFH       ;放入DAC0832的地址

SUNSET:
     MOV A,#00H              ;设定低电平

LOOPJU:
     MOVX @DPTR,A            ;启动D/A转换，输出此时电平
     INC A
     SJMP LOOPJU

STARTSAN:                    ;输出三角波子程序
     MOV DPTR,#0FEFFH        ;放入DAC0832的地址
    
UPSAN:
     MOV A,#00H
     CLR C                    ;设置低电平

LOOPUPSAN:
     MOVX @DPTR,A              ;启动D/A转换，输出此时电平
     ADD A,#01H
     JC DOWNSAN
     SJMP LOOPUPSAN

DOWNSAN:
     MOV A,#0FFH
     CLR C

LOOPDOWNSAN:
     MOVX @DPTR,A              ;启动D/A转换，输出此时电平
     SUBB A,#1H
     JC UPSAN
     SJMP LOOPDOWNSAN

     END
