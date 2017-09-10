ORG 0000H
MOV R0,#-4             ;输入数据
START:
    MOV A,R0
    MOV B,#2
    CJNE A,#0,NEXT1   ;判断是否等于0
    MOV A,#2
    LJMP FINAL

NEXT1:
    JB ACC.7,NEXT2    ;判断是否小于0
    ADD A,R0          ;A=A+R0=2*A
    LJMP FINAL

NEXT2:
    CPL A             ;取反加1
    ADD A,#1
    RRC A             ;除2
    CPL A
    ADD A,#1          ;取反加1
FINAL:
    MOV 30H,A
    
    END
    
