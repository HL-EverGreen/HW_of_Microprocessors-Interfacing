DBUF EQU 32H
TEMP EQU 40H

ORG 0000H
LJMP CHECK
ORG 000BH         ;定时器0中断地址
LJMP OVER         ;中断转移入口
ORG 1000H
CHECK: MOV TMOD,#51H  ;T0、T1初始化
       MOV R7,#0AH     ;1s定时长度
       MOV TL1,#00H    ;T1清零
       MOV TH1,#00H
       MOV TH0,#3CH    ;T0计数初值100ms
       MOV TL0,#0B0H
       SETB P3.5       ;光电脉冲输入口
       JB P3.5,$       ;等待中断
       SETB TR0        ;启动定时
       SETB TR1        ;启动计数
       SETB EA         ;允许中断
       SETB ET0        ;允许定时器0中断
       CLR 00H

WAIT:JB 00H,SPEED      ;等待测量结束
     SJMP WAIT

SPEED:MOV A,31H        ;计数值除以12
      MOV B,#12        ;计数值高位先除12
      DIV AB
      MOV 32H,A        ;商1存入32H
      MOV 35H,B        ;余数存入35H
      MOV A,31H
      ANL A,#0F0H      ;取30H中高八位
      ADD A,35H
      SWAP A           ;将余数与下一个八位组合
      MOV B,#12
      DIV AB  
      MOV 33H,A        ;商2存入33H
      MOV A,B
      SWAP A
      MOV 35H,A
      MOV A,31H
      ANL A,#0FH
      ADD A,35H
      SWAP A
      MOV B,#12
      DIV AB
      MOV 34H,A        ;商3存入34H
      MOV 35H,B

      MOV R0,#DBUF      ;取出32H、33H、34H的数据
      MOV R1,#TEMP
      MOV R2,#3
      MOV R6,#0FFH
      MOV DPTR,#SEGTAB

DP00: MOV A,@R0
      MOVC A,@A+DPTR
      MOV @R1,A
      INC R1
      INC R0
      DJNZ R2,DP00

DISP0:MOV R0,#TEMP
      MOV R1,#3
      MOV R2,#01H

DP01: MOV A,@R0
      MOV P0,A
      MOV A,R2
      MOV P2,A
      ACALL DELAY
      MOV A,R2
      RL A
      MOV R2,A
      INC R0
      DJNZ R1,DP01
      DJNZ R6,DISP0
      ACALL LEDLAY
      RET

LEDLAY:MOV R3,#0FFH

DELAY:MOV R4,#03H        ;延时3ms
DELAY1:  MOV R5,#0FFH

DELAY2: NOP
    NOP
    DJNZ R5,DELAY2
    DJNZ R4,DELAY1
    DJNZ R3,DELAY
    RET

SEGTAB:DB 3FH,06H,5BH,4FH,66H,6DH   ;0,1,2,3,4,5
       DB 7DH,07H,7FH,6FH,77H,7CH   ;6,7,8,9,A,B
       DB 58H,5EH,79H,71H,00H,40H   ;C,D,E,F, ,/

ORG 2000H    
OVER:DJNZ R7,LOOP   ;检测是否到1s
     CLR TR1        ;停止采样
     CLR TR0        ;停止定时
     MOV 30H,TL1 
     MOV 31H,TH1    ;结果输入30H，31H 
     SETB 00H    
     RETI

LOOP:MOV TL0,#0B0H  ;重新装载定时器
     MOV TH0,#3CH
     RETI

     END

