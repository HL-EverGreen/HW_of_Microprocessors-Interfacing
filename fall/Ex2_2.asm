ORG 0000H

ADDNUM:                   ;输入存储在50H等存储块的值
MOV R0,#50H
MOV @R0,#0AH
INC R0
MOV @R0,#01H
INC R0
MOV @R0,#03H
INC R0
MOV @R0,#05H
MOV R0,#50H
MOV R1,#3                 ;LOOP部分循环次数
MOV R6,#0                 ;初始化R6             
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
INC R0                     ;取下一位存储块中存储的BCD数
MOV A,R7
ADD A,@R0
MOV R7,A
MOV A,R6
ADDC A,#0
MOV R6,A
DJNZ R1,LOOP
END
