ORG 0000H  ;�ı䷢��������ƶ�ʱ��
LOOP:
   MOV A,#0FEH
   MOV R2,#8

OUTPUT:
   MOV P1,A
   RL A   ;����
   ACALL DELAY
   DJNZ R2,OUTPUT
   LJMP LOOP
 
DELAY:     ;��ʱ����,��������ʱʱ��
   MOV R5,#0
   MOV R6,#0
   MOV R7,#0

DELAYLOOP:
   DJNZ R5,DELAYLOOP
   DJNZ R6,DELAYLOOP
   DJNZ R7,DELAYLOOP
   RET

