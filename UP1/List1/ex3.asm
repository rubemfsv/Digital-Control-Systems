; Questão 3 da lista de exercícios
    #INCLUDE<P16F84A.INC>
    
    ESTADO EQU 0x20
    ORG 0x00
    GOTO INICIO
    
    ORG 0x04
    GOTO INTER

INICIO
    
    CLRW
    CLRF PORTB
    CLRF PORTA
    BSF STATUS,RP0
    MOVLW 0
    MOVWF TRISA
    MOVLW 1
    MOVWF TRISB
    BCF STATUS,RP0
    BSF INTCON,GIE ;Acionamento geral de interrupções
    BSF INTCON,INTE ; Acionamento específico por borda no pino b0
    BSF ESTADO,0 ; Esse bit serve apenas para indicar a primeira vez que o botão será acionado
    

MAIN
    GOTO MAIN
    
INTER
    BTFSC ESTADO,0
    GOTO ACIONA_ESTADO_0 
    BTFSS PORTA,3
    GOTO ACIONA
    GOTO VOLTA
    
ACIONA_ESTADO_0; Esse estado só é visitado na primeira vez que ocorre a interrupção
    BSF PORTA,0 ; Aciona o led A0 pela primeira vez
    BCF ESTADO,0
    GOTO FIM
    
VOLTA          ;passagem do A3 para o A0
    BCF PORTA,3
    BSF PORTA,0
    GOTO FIM

ACIONA      ;Apaga o led atual e acende o próximo
    MOVF PORTA,0
    ADDWF PORTA,1
    GOTO FIM
FIM     ; Finaliza a interrupção
    BCF INTCON,INTF
    RETFIE

    
    END
