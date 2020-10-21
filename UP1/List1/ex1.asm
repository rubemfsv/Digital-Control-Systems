    #INCLUDE<P16F84A.INC>
    
    ORG 0X00
    GOTO INICIO
    
    ;--- Se uma entrada é acionada, uma saída deve permanecer acionada enquanto a entrada estiver acionada. ---;
    
INICIO
    CLRW
    CLRF PORTA
    CLRF PORTB
    BSF STATUS,RP0
    MOVLW 0
    MOVWF TRISA             ;porta A toda de saida
    MOVLW 1
    MOVWF TRISB             ;porta B apenas com o bit 0 de entrada
    BCF STATUS,RP0
    
MAIN
    BTFSS PORTB,0
    GOTO APAGA          ;se tiver em 0, nao ta pressionado e apaga
    GOTO ACENDE         ;se tiver em 1 ta pressionado e acende
    
ACENDE
    BSF PORTA,0
    GOTO MAIN

APAGA
    BCF PORTA,0
    GOTO MAIN
    
    END
