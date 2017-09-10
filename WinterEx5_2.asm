DBUF EQU 30H
TEMP EQU 40H
ORG 0000H
LJMP DISP
ORG 0100H

DISP:MOV 30H,#8
     MOV 31H,#6
     MOV 32H,#1
     MOV 33H,#8
     MOV 34H,#6
     MOV 35H,#1
     MOV R0,#DBUF
     MOV R1,#TEMP
     MOV R2,#6
     MOV DPTR,#SEGTAB

DP00:MOV A,@R0
     MOVC A,@A+DPTR
     MOV @R1,A
     INC R1
     INC R0
     DJNZ R2,DP00
     MOV R3,#40H

DISP0:
     MOV R0,#TEMP
     MOV R1,#6H  
     MOV R2,#1H

DP01:MOV A,@R0
     MOV P0,A
     MOV A,R2
     MOV P2,A
     ACALL DELAY
     MOV A,R2
     RL A
     MOV R2,A
     INC R0
     DJNZ R1,DP01
     DJNZ R3,DISP0
     MOV R3,#40H
     MOV A,#0
     MOV P2,A
     ACALL DELAY2
     SJMP DISP0

DELAY:
     MOV R4,#03H

AA1:
     MOV R5,#0FFH

AA:
     NOP
     NOP
     DJNZ R5,AA
     DJNZ R4,AA1
     RET

DELAY2:
     MOV R4,#0FFH

AA2: MOV R5,#0FFH
AA3: NOP
     NOP
     DJNZ R5,AA3
     DJNZ R4,AA2
     RET
 
SEGTAB:
     DB 3FH,06H,5BH,4FH,66H,6DH  ;0,1,2,3,4,5
     DB 7DH,07H,7FH,6FH,77H,7CH  ;6,7,8,9,A,B
     DB 58H,5EH,7BH,71H,00H,40H  ;C,D,E,F,/,/
     END