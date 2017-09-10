FLAG BIT 0
ORG 0000H
LJMP MAIN
ORG 0003H
LJMP SUB1  
ORG 0013H
LJMP SUB2         
ORG 0030H
MAIN: 
MOV IE,#10001101B  
MOV A,#1H
loop:
     MOV R6,#1H                  
     CJNE R5, #1, CONDITION1 
     RL A       
     LJMP FINAL
CONDITION1: 
     RR A
BESTAGAIN_SLOW:  MOV R1, #0H  
NEXTAGAIN_SLOW:  MOV R0, #0H  
AGAIN_SLOW: 
     NOP            
	 NOP
	 NOP                           
	 INC R0
	 CJNE R0, #100, AGAIN_SLOW
	 INC R1
	 CJNE R1, #100, NEXTAGAIN_SLOW
	 INC R2
	 CJNE R2, #100, BESTAGAIN_SLOW
FINAL:     
     MOV p1, A  
	 MOV R2, #0H      
BESTAGAIN:  MOV R1, #0H  
NEXTAGAIN:  MOV R0, #0H   
AGAIN: 
     NOP            
	 NOP
	 NOP                          
	 INC R0
	 CJNE R0, #100, AGAIN
	 INC R1
	 CJNE R1, #100, NEXTAGAIN
	 INC R2
	 CJNE R2, #100, BESTAGAIN
	 LJMP loop
SUB1:PUSH ACC  
     MOV A,#0
	 MOV P1,A 
	 NOP
	 NOP
	 NOP
	 NOP
	 POP ACC
	 RETI
SUB2:PUSH ACC  
     MOV A, #0H
     CJNE R6, #1H, TURN
     CPL FLAG 
     MOV C,FLAG
     ADDC A,#0H
     MOV R5, A
TURN:
     NOP
     NOP
     NOP
     NOP
     POP ACC
     MOV R6,#0H
     RETI

END