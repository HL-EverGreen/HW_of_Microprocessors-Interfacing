ORG 0000H
MOV R0,#40H           
MOV DPTR,#1000H
MOV R1,#10H           ;�ڴ浥Ԫ����
MOV R2,#1AH
MOV A,#01H   
LOOP: MOV @R0,A       ;����RAM�׵�ַΪ40H��һ���ڴ渳ֵΪ1
      INC R0
      DJNZ R2,LOOP
      MOV R0,#40H
LOOP1: MOV A,@R0      ;���ݸ��ƵĹ���
      MOVX @DPTR,A
      INC R0
      INC DPTR
      DJNZ R1,LOOP1
      LJMP $
      END

