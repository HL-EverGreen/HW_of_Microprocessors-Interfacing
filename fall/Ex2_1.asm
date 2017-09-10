ORG 0000H

MOV R3,#132    ;二进制数以十进制方式输入
MOV B,#100 
MOV A,R3
DIV AB
MOV R4,A
MOV A,B
MOV B,#10
DIV AB
SWAP A         ;商的低四位作为3位压缩BCD码中的中间四位
ADD A,B        ;余数的低四位作为3位压缩BCD码的最后四位
MOV R5,A

END
