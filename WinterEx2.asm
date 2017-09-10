Tick EQU 10000
T100us EQU 156   ;100us时间常数
C100us EQU 5H    ;100us计数单元
LEDBuf EQU 30H
ORG 0000H
LJMP MAIN
ORG 000BH
LJMP T0INT
ORG 0100H

MAIN:MOV TMOD,#02H    ;工作方式2
     MOV TH0,#T100us
     MOV TL0,#T100us
     MOV IE,#82H      ;允许中断，允许T0中断
     MOV LEDBuf,#0FEH   
     MOV P1,#0FFH           ;设置等待初始状态，并是灯全灭
     MOV C100us,#High(Tick)
     MOV C100us+1,#Low(Tick) ;初始化定时器
     SETB TR0                ;启动定时

LOOP:MOV B,LEDBuf
     MOV P1,B
     LJMP LOOP

T0INT:PUSH PSW               ;保护现场
      MOV A,C100us+1H
      JNZ Goon
      DEC C100us

Goon: DEC C100us+1H
      MOV A,C100us
      ORL A,C100us+1H
      JNZ EXIT               ;计数器不为0则返回
      MOV C100us,#HIGH(Tick)
      MOV C100us+1H,#LOW(Tick) ;重新装载计数器
      MOV A,LEDBuf
      RL A
      MOV LEDBuf,A

EXIT: POP PSW              ;恢复现场
      RETI

      END
