ORG 0000H  ;�ı䷢��������ƶ�����
LOOP:
   MOV A,#0FEH
   MOV R2,#8

OUTPUT:
   MOV P1,A
   RR A   ;��Ϊ������
   ACALL DELAY
   DJNZ R2,OUTPUT
   LJMP LOOP
 
DELAY:     ;��ʱ����
   MOV R6,#0
   MOV R7,#0

DELAYLOOP:
   DJNZ R6,DELAYLOOP
   DJNZ R7,DELAYLOOP
   RET

