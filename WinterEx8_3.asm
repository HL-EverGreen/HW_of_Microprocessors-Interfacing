ADHEX DATA 050H
DBUF DATA 060H
BIT_COUNT DATA 070H
TIMER DATA 072H
TIMER1 DATA 073H
TIMER2 DATA 074H
DATA_IN DATA 020H
DATA_OUT DATA 021H
CLK BIT P1.6
DAT BIT P1.7

ORG 0000H
LJMP MAIN

ORG 0100H
MAIN:CLR A 
     MOV R1,#80H
     MOV R2,#10
     SETB P3.3
     MOV R0,#DBUF
     MOV DPTR,#0FE0H
     NOP
     NOP
     MOVX @DPTR,A

WAIT:JNB P3.3,WAIT
     MOV R6,#0

LOOP:MOV B,#10
     MOVX A,@DPTR
     DIV AB
     MOV @R1,A
     MOV A,B
     ADD A,R6
     MOV R6,A
     INC R1
     DJNZ R2,LOOP
     LCALL MEAN      ;������ƽ���ӳ���
     CALL TODISP        ;��ֲ���ʾ
     CALL DISPLAY
     CALL DELAY
     LJMP MAIN

MEAN:                ;��ƽ���ӳ���
     MOV R1,#80H        ;����������λ��
     MOV R2,#10         ;���������ݸ���
     MOV R3,#0          ;�����ʱ���ݺ�

MEANPART:
     CLR C
     ADD A,@R1
     MOV B,#10
     DIV AB
     CLR C
     ADD A,R3
     MOV R3,A
     MOV A,B            ;����������������һ�����
     INC R1
     DJNZ R2,MEANPART
     MOV R7,A
     RET


DISPLAY:ANL P2,#00H               ;CS7279��Ч
        MOV DATA_OUT,#10100100B   ;A4H����λ����
        CALL SEND
        MOV DATA_OUT,#11001000B   
        CALL SEND
        MOV DATA_OUT,DBUF
        CALL SEND
        MOV DATA_OUT,#11001001B
        CALL SEND
        MOV DATA_OUT,DBUF+1
        CALL SEND
        MOV P2,#0FFH  ;CS7279��Ч
        RET

SEND:MOV BIT_COUNT,#8   ;�����ַ��ӳ���
     ANL P2,#00H
     CALL LONG_DELAY

SEND_LOOP:
     MOV C,DATA_OUT.7
     MOV DAT,C
     SETB CLK
     MOV A,DATA_OUT
     RL A
     MOV DATA_OUT,A
     CALL SHORT_DELAY
     CLR CLK
     CALL SHORT_DELAY
     DJNZ BIT_COUNT,SEND_LOOP
     CLR DAT
     RET

LONG_DELAY:
     MOV TIMER,#150    ;��ʱ200us

DELAY_LOOP:
     DJNZ TIMER,DELAY_LOOP
     RET

SHORT_DELAY:
     MOV TIMER,#20     ;��ʱ20us

SHORT_LP:
     DJNZ TIMER,SHORT_LP
     RET

DELAY:
     MOV TIMER,#4

AA0:
    MOV TIMER1,#0

AA1:
    MOV TIMER2,#0

AA2:
    MOP
    MOP
    DJNZ TIMER2,AA2
    DJNZ TIMER1,AA1
    DJNZ TIMER,AA0
    RET

TODISP:
    MOV DBUF+2,#10H
    MOV A,R7
    SWAP A
    ANL A,#0FH
    MOV DBUF+1,A
    MOV A,R7
    ANL A,#0FH
    MOV DBUF,A
    RET
    END      