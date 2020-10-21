;Implemente um código, em Assembly, que controle a seguinte situação: Um botão, 
;ao ser ligado no pino 3 da porta A, quando pressionado (através de PULSOS) 
;deve  somar de um valor de 5 o que estiver na porta B. Isso deve ser refletido 
;no estado dos LEDs da  porta. 


    #INCLUDE <P16F84A.inc>
    
    ORG 0x00 
    GOTO INICIO

INICIO
	  CLRW   
	  CLRF PORTA
	  CLRF PORTB
    BSF STATUS,RP0  
    MOVLW D'8' 
    MOVWF TRISA   
    CLRF TRISB 
    BCF STATUS,RP0 
    CLRW
    GOTO MAIN

MAIN
    BTFSS PORTA,3 
    GOTO SOMA 
    GOTO MAIN 

SOMA
    BTFSS PORTA,3 
    GOTO SOMA
    ADDLW 5
    MOVWF PORTB
    GOTO MAIN

    END
