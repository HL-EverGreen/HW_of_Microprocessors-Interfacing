DBUF EQU 32H
TEMP EQU 40H

ORG 0000H
LJMP CHECK
ORG 000BH         ;��ʱ��0�жϵ�ַ
LJMP OVER         ;�ж�ת�����
ORG 1000H
CHECK: MOV TMOD,#51H  ;T0��T1��ʼ��
       MOV R7,#0AH     ;1s��ʱ����
       MOV TL1,#00H    ;T1����
       MOV TH1,#00H
       MOV TH0,#3CH    ;T0������ֵ100ms
       MOV TL0,#0B0H
       SETB P3.5       ;������������
       JB P3.5,$       ;�ȴ��ж�
       SETB TR0        ;������ʱ
       SETB TR1        ;��������
       SETB EA         ;�����ж�
       SETB ET0        ;����ʱ��0�ж�
       CLR 00H

WAIT:JB 00H,SPEED      ;�ȴ���������
     SJMP WAIT

SPEED:MOV A,31H        ;����ֵ����12
      MOV B,#12        ;����ֵ��λ�ȳ�12
      DIV AB
      MOV 32H,A        ;��1����32H
      MOV 35H,B        ;��������35H
      MOV A,31H
      ANL A,#0F0H      ;ȡ30H�и߰�λ
      ADD A,35H
      SWAP A           ;����������һ����λ���
      MOV B,#12
      DIV AB  
      MOV 33H,A        ;��2����33H
      MOV A,B
      SWAP A
      MOV 35H,A
      MOV A,31H
      ANL A,#0FH
      ADD A,35H
      SWAP A
      MOV B,#12
      DIV AB
      MOV 34H,A        ;��3����34H
      MOV 35H,B

      MOV R0,#DBUF      ;ȡ��32H��33H��34H������
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

DELAY:MOV R4,#03H        ;��ʱ3ms
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
OVER:DJNZ R7,LOOP   ;����Ƿ�1s
     CLR TR1        ;ֹͣ����
     CLR TR0        ;ֹͣ��ʱ
     MOV 30H,TL1 
     MOV 31H,TH1    ;�������30H��31H 
     SETB 00H    
     RETI

LOOP:MOV TL0,#0B0H  ;����װ�ض�ʱ��
     MOV TH0,#3CH
     RETI

     END

