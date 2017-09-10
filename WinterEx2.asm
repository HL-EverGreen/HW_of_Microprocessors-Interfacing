Tick EQU 10000
T100us EQU 156   ;100usʱ�䳣��
C100us EQU 5H    ;100us������Ԫ
LEDBuf EQU 30H
ORG 0000H
LJMP MAIN
ORG 000BH
LJMP T0INT
ORG 0100H

MAIN:MOV TMOD,#02H    ;������ʽ2
     MOV TH0,#T100us
     MOV TL0,#T100us
     MOV IE,#82H      ;�����жϣ�����T0�ж�
     MOV LEDBuf,#0FEH   
     MOV P1,#0FFH           ;���õȴ���ʼ״̬�����ǵ�ȫ��
     MOV C100us,#High(Tick)
     MOV C100us+1,#Low(Tick) ;��ʼ����ʱ��
     SETB TR0                ;������ʱ

LOOP:MOV B,LEDBuf
     MOV P1,B
     LJMP LOOP

T0INT:PUSH PSW               ;�����ֳ�
      MOV A,C100us+1H
      JNZ Goon
      DEC C100us

Goon: DEC C100us+1H
      MOV A,C100us
      ORL A,C100us+1H
      JNZ EXIT               ;��������Ϊ0�򷵻�
      MOV C100us,#HIGH(Tick)
      MOV C100us+1H,#LOW(Tick) ;����װ�ؼ�����
      MOV A,LEDBuf
      RL A
      MOV LEDBuf,A

EXIT: POP PSW              ;�ָ��ֳ�
      RETI

      END
