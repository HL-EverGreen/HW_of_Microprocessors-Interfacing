ORG 0000H    ;改变发光二极管移动步长
LOOP: MOV A,#0FEH
      MOV R2,#8

OUTPUT: MOV P1,A
        RL A ;左移
        RL A
        RL A
        ACALL DELAY
        DJNZ R2,OUTPUT
        LJMP LOOP

DELAY:  MOV R6,#0    ;延时程序
        MOV R7,#0

DELAYLOOP:DJNZ R6,DELAYLOOP
          DJNZ R7,DELAYLOOP
          RET

    
