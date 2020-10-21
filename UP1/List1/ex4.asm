; Questão 4 da lista de exercícios
    #INCLUDE<P16F84A.INC>
    
    ESTADO EQU 0x20
    DIGITO1 EQU 0x21
    DIGITO2 EQU 0x22
    DIGITO3 EQU 0x23
    DIGITO4 EQU 0x24
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
    MOVLW B'11110000'
    MOVWF TRISB
    BCF STATUS,RP0
    BSF INTCON,GIE ;Acionamento geral de interrupções
    BSF INTCON,RBIE ; Acionamento específico por borda no pino b0
    BSF ESTADO,0
    

MAIN
   GOTO MAIN
   
INTER ; Checa qual tecla foi pressionada
    BTFSC PORTB,4
    GOTO TECLA_1
    BTFSC PORTB,5
    GOTO TECLA_2
    BTFSC PORTB,6
    GOTO TECLA_3
    BTFSC PORTB,7
    GOTO TECLA_4
    GOTO FIM

TECLA_1 ; Atribui o valor 1 ao digito 1,2,3 ou 4, dependendo em qual fase está no preenchimento da senha
    MOVLW 1
    BTFSC ESTADO,0
    MOVWF DIGITO1
    BTFSC ESTADO,1
    MOVWF DIGITO2
    BTFSC ESTADO,2
    MOVWF DIGITO3
    BTFSC ESTADO,3
    MOVWF DIGITO4
    GOTO CHEGOU_DIGITO4
   
    
TECLA_2 ;Atribui o valor 2 ao digito 1,2,3 ou 4, dependendo em qual fase está no preenchimento da senha
    MOVLW 2
    BTFSC ESTADO,0
    MOVWF DIGITO1
    BTFSC ESTADO,1
    MOVWF DIGITO2
    BTFSC ESTADO,2
    MOVWF DIGITO3
    BTFSC ESTADO,3
    MOVWF DIGITO4
    GOTO CHEGOU_DIGITO4
   
TECLA_3   ;Atribui o valor 3 ao digito 1,2,3 ou 4, dependendo em qual fase está no preenchimento da senha
    MOVLW 3
    BTFSC ESTADO,0
    MOVWF DIGITO1
    BTFSC ESTADO,1
    MOVWF DIGITO2
    BTFSC ESTADO,2
    MOVWF DIGITO3
    BTFSC ESTADO,3
    MOVWF DIGITO4
    GOTO CHEGOU_DIGITO4
      
    
TECLA_4   ;Atribui o valor 4 ao digito 1,2,3 ou 4, dependendo em qual fase está no preenchimento da senha
    MOVLW 4
    BTFSC ESTADO,0
    MOVWF DIGITO1
    BTFSC ESTADO,1
    MOVWF DIGITO2
    BTFSC ESTADO,2
    MOVWF DIGITO3
    BTFSC ESTADO,3
    MOVWF DIGITO4
    GOTO CHEGOU_DIGITO4
    
CHEGOU_DIGITO4    ;Checa se o último dígito foi preenchido
    BTFSS ESTADO,3
    GOTO ATUALIZA_ESTADO
    GOTO COMPARA

ATUALIZA_ESTADO ; Se não chegou no último dígito da senha, passa para o próximo
    MOVF ESTADO,0
    ADDWF ESTADO,1
    GOTO FIM
    
COMPARA ;Compara os 4 dígitos com a senha padrão
    MOVLW 3
    SUBWF DIGITO1,0
    BTFSS STATUS,Z
    GOTO FECHA
    MOVLW 3
    SUBWF DIGITO2,0
    BTFSS STATUS,Z
    GOTO FECHA
    MOVLW 1
    SUBWF DIGITO3,0
    BTFSS STATUS,Z
    GOTO FECHA
    MOVLW 4
    SUBWF DIGITO4,0
    BTFSS STATUS,Z
    GOTO FECHA
    GOTO ABRE

ABRE  ; Abre a porta (Liga o led no A0)
    BSF PORTA,0
    BCF ESTADO,3
    BSF ESTADO,0
    GOTO FIM

FECHA   ; Fecha a porta (desliga o led A0(
    BCF PORTA,0
    BCF ESTADO,3
    BSF ESTADO,0
    GOTO FIM
FIM      ; Encerra a interrupção
    MOVF PORTB,0
    BCF INTCON,RBIF
    RETFIE

    
    END

