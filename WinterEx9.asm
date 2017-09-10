ORG 0000H
LJMP MAIN
ORG 000BH
LJMP INTERRUPT

ORG 0100H
MAIN:MOV R7,#00H
     MOV R6,#03H
     MOV TCON,#01H   ;�ⲿ�ж�0  �½��ش���
     MOV IE,#81H      ;�����жϣ������ⲿ�жϿ�0�ж�

INTERRUPT:
     MOV SP,#02H
     INC R7
     MOV A,R7
     MOV B,R6
     DIV AB
     MOV A,B
     CJNE A,#1H,STARTJU   ;��������ӳ���

STARTFANG:
     MOV DPTR,#0FEFFH     ;DAC0832�ĵ�ַ

LOOPFANG:
     MOV A,#0FFH           ;�趨�ߵ�ƽ
     MOVX @DPTR,A          ;����D/Aת��������ߵ�ƽ
     LCALL DELAYFANG       ;��ʱ��ʾ�ߵ�ƽ
     MOV A,#00H            ;�趨�͵�ƽ
     MOVX @DPTR,A          ;����D/Aת��������͵�ƽ
     LCALL DELAYFANG       ;��ʱ��ʾ�͵�ƽ
     SJMP LOOPFANG         ;�����������

DELAYFANG:
     MOV R3,#11            ;��ʱ�ӳ���

D1FANG:
     NOP
     NOP
     NOP
     NOP
     NOP
     NOP
     DJNZ R3,D1FANG
     RET          

STARTJU:                    ;�����ݲ��ӳ���
     CJNE A,#2H,STARTSAN
     MOV DPTR,#0FEFFH       ;����DAC0832�ĵ�ַ

SUNSET:
     MOV A,#00H              ;�趨�͵�ƽ

LOOPJU:
     MOVX @DPTR,A            ;����D/Aת���������ʱ��ƽ
     INC A
     SJMP LOOPJU

STARTSAN:                    ;������ǲ��ӳ���
     MOV DPTR,#0FEFFH        ;����DAC0832�ĵ�ַ
    
UPSAN:
     MOV A,#00H
     CLR C                    ;���õ͵�ƽ

LOOPUPSAN:
     MOVX @DPTR,A              ;����D/Aת���������ʱ��ƽ
     ADD A,#01H
     JC DOWNSAN
     SJMP LOOPUPSAN

DOWNSAN:
     MOV A,#0FFH
     CLR C

LOOPDOWNSAN:
     MOVX @DPTR,A              ;����D/Aת���������ʱ��ƽ
     SUBB A,#1H
     JC UPSAN
     SJMP LOOPDOWNSAN

     END
