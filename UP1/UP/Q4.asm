; Compare um valor colocado nos pinos 0, 1 e 2, através de chaves LIGA/DESLIGA, 
; com um valor colocado nos pinos 0, 1 e 2 da porta B. Se o valor da porta A for
; exatamente o  dobro da porta B, um led no pino 7 da porta B deve acender. Caso
; contrário, deve permanecer  apagado. 

    #INCLUDE<P16F84A.inc>

    TEMPA EQU 0x2C
    TEMPB EQU 0x2D
    
    ORG 0x00
    GOTO INICIO

INICIO
    CLRW
    CLRF PORTB
    CLRF PORTA
    BSF STATUS,RP0
    MOVLW B'00000111'             
    MOVWF TRISA
    MOVLW B'00000111'             
    MOVWF TRISB
    BCF STATUS,RP0
    
MAIN
    MOVF PORTA,0       
    MOVWF TEMPA  
    MOVF PORTB,0
    MOVWF TEMPB
    ADDWF TEMPB,0
    SUBWF TEMPA, 1
    BTFSS STATUS, Z
    GOTO LED_OFF           
    GOTO LED_ON

LED_OFF
    BCF PORTB,7
    GOTO MAIN
    
LED_ON
    BSF PORTB,7        
    GOTO MAIN
    
    END
