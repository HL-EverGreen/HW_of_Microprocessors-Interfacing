	ORG 0000H
	clr P2.1
L0:		MOV P3,#0FFH
L1:		MOV A,P3
		CJNE A,#0FH,KEYPUT
		SJMP L1

KEYPUT:	CJNE A,#1EH,NEXT1
		SJMP K0
NEXT1:	CJNE A,#1DH,NEXT2
		SJMP K1
NEXT2:	CJNE A,#1BH,NEXT3
		SJMP K2
NEXT3:	CJNE A,#17H,NEXT4
		SJMP K3
NEXT4:	CJNE A,#2EH,NEXT5
		SJMP K4
NEXT5:	CJNE A,#2DH,NEXT6
		SJMP K5
NEXT6:	CJNE A,#2BH,NEXT7
		SJMP K6
NEXT7:	CJNE A,#27H,NEXT8
		SJMP K7
NEXT8:	CJNE A,#4EH,NEXT9
		SJMP K8
NEXT9:	CJNE A,#4DH,NEXT10
		SJMP K9
NEXT10:	CJNE A,#4BH,NEXT11
		SJMP K10
NEXT11:	CJNE A,#47H,NEXT12
		SJMP K11
NEXT12:	CJNE A,#8EH,NEXT13
		SJMP K12
NEXT13:	CJNE A,#8DH,NEXT14
		SJMP K13
NEXT14:	CJNE A,#8BH,NEXT15
		SJMP K14
NEXT15:	CJNE A,#8EH,L0
		SJMP K15

K0:		MOV P0,#0C0H
		LJMP L0
K1:		MOV P0,#0F9H
		LJMP L0
K2:		MOV P0,#0A4H
		LJMP L0
K3:		MOV P0,#0B0H
		LJMP L0
K4:		MOV P0,#99H
		LJMP L0
K5:		MOV P0,#92H
		LJMP L0
K6:		MOV P0,#82H
		LJMP L0
K7:		MOV P0,#0F8H
		LJMP L0
K8:		MOV P0,#80H
		LJMP L0
K9:		MOV P0,#90H
		LJMP L0
K10:	MOV P0,#88H
		LJMP L0
K11:	MOV P0,#83H
		LJMP L0
K12:	MOV P0,#0C6H
		LJMP L0
K13:	MOV P0,#0A1H
		LJMP L0
K14:	MOV P0,#86H
		LJMP L0
K15:	MOV P0,#8EH
		LJMP L0