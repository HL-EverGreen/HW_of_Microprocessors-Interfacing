ORG 0000H
MOV R0,#40H           
MOV DPTR,#1000H
MOV R1,#10H           ;内存单元长度
MOV R2,#1AH
MOV A,#01H   
LOOP: MOV @R0,A       ;将内RAM首地址为40H的一段内存赋值为1
      INC R0
      DJNZ R2,LOOP
      MOV R0,#40H
LOOP1: MOV A,@R0      ;数据复制的过程
      MOVX @DPTR,A
      INC R0
      INC DPTR
      DJNZ R1,LOOP1
      LJMP $
      END

