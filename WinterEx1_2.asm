ORG 0000H  ;改变发光二极管移动方向
LOOP:
   MOV A,#0FEH
   MOV R2,#8

OUTPUT:
   MOV P1,A
   RR A   ;改为向右移
   ACALL DELAY
   DJNZ R2,OUTPUT
   LJMP LOOP
 
DELAY:     ;延时程序
   MOV R6,#0
   MOV R7,#0

DELAYLOOP:
   DJNZ R6,DELAYLOOP
   DJNZ R7,DELAYLOOP
   RET

