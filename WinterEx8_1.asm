ORG 0000H    ;用延时方式改写
LJMP MAIN
ORG 0100H

MAIN:MOV DPTR,#0FE0H
     MOVX @DPTR,A
     LJMP DELAY

AD:  MOVX A,@DPTR
     MOV R7,A

DELAY:MOV R2,#100

LOOP:DJNZ R2,LOOP
     LJMP AD

     END
