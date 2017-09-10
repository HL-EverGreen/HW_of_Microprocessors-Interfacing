ORG 0000H  ;改变发光二极管移动时间
LOOP:
   MOV A,#0FEH
   MOV R2,#8

OUTPUT:
   MOV P1,A
   RL A   ;左移
   ACALL DELAY
   DJNZ R2,OUTPUT
   LJMP LOOP
 
DELAY:     ;延时程序,更改了延时时间
   MOV R5,#0
   MOV R6,#0
   MOV R7,#0

DELAYLOOP:
   DJNZ R5,DELAYLOOP
   DJNZ R6,DELAYLOOP
   DJNZ R7,DELAYLOOP
   RET

