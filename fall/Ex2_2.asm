ORG 0000H

ADDNUM:                   ;����洢��50H�ȴ洢���ֵ
MOV R0,#50H
MOV @R0,#0AH
INC R0
MOV @R0,#01H
INC R0
MOV @R0,#03H
INC R0
MOV @R0,#05H
MOV R0,#50H
MOV R1,#3                 ;LOOP����ѭ������
MOV R6,#0                 ;��ʼ��R6             
MOV A,@R0
MOV R7,A

LOOP:
MOV A,R7
MOV B,#10
MUL AB
MOV R7,A
MOV A,B
XCH A,R6
MOV B,#10
MUL AB
ADD A,R6
MOV R6,A  
INC R0                     ;ȡ��һλ�洢���д洢��BCD��
MOV A,R7
ADD A,@R0
MOV R7,A
MOV A,R6
ADDC A,#0
MOV R6,A
DJNZ R1,LOOP
END
