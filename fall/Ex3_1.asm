ORG 0000H
MOV R0,#-4             ;��������
START:
    MOV A,R0
    MOV B,#2
    CJNE A,#0,NEXT1   ;�ж��Ƿ����0
    MOV A,#2
    LJMP FINAL

NEXT1:
    JB ACC.7,NEXT2    ;�ж��Ƿ�С��0
    ADD A,R0          ;A=A+R0=2*A
    LJMP FINAL

NEXT2:
    CPL A             ;ȡ����1
    ADD A,#1
    RRC A             ;��2
    CPL A
    ADD A,#1          ;ȡ����1
FINAL:
    MOV 30H,A
    
    END
    
