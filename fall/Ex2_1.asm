ORG 0000H

MOV R3,#132    ;����������ʮ���Ʒ�ʽ����
MOV B,#100 
MOV A,R3
DIV AB
MOV R4,A
MOV A,B
MOV B,#10
DIV AB
SWAP A         ;�̵ĵ���λ��Ϊ3λѹ��BCD���е��м���λ
ADD A,B        ;�����ĵ���λ��Ϊ3λѹ��BCD��������λ
MOV R5,A

END
