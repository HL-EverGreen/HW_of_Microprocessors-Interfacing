LED BIT P1.0
LEDBuf BIT 0
ORG 0000H
LJMP MAIN
ORG 0000BH
LJMP INTERRUPT
ORG 0030H

MAIN:CLR LEDBuf
     CLR LED
     MOV TCON,#00H      ;�����ⲿ�ж�0Ϊ�͵�ƽ����
     MOV IE,#81H        ;�����жϣ������ⲿ�����0�ж�
     LJMP $

INTERRUPT:PUSH PSW      ;�����ֳ�
          CPL LEDBuf    ;ȡ��
	  MOV C,LEDBuf
	  MOV LED,C
	  POP PSW       ;�ָ��ֳ�
	  RETI

     END
