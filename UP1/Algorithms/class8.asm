
    #INCLUDE<P16F84A.INC>
    
    ORG 0X00
    GOTO INICIO
    
    ORG 0X04                ;as interrupções sempre levam para a posição 4
    GOTO INTER
    
    ;--- ACIONAMENTO DE UM LED ATRAVÉS DE UM CLICK NO RB0 ---;
    
INICIO
    CLRW
    CLRF PORTB
    CLRF PORTA
    BSF STATUS,RP0
    MOVLW 0                 ;todos os bits de A sao de saida
    MOVWF TRISA
    MOVLW 1                 ;1 = 00000001
    MOVWF TRISB             ;apenas o bit 0 de B é entrada
    BCF STATUS,RP0
    
    BSF INTCON,GIE          ;habilitação do bit geral de interrupções
    BSF INTCON,INTE         ;habilitação da interrupção por borda do pino rb0
    
MAIN
    GOTO MAIN               ;como o programa só faz algo quando é gerada uma interrupção de click a lógica principal fica parada aguardando essa interrupção acontecer
    
INTER                       ;se chegou aqui é pq houve a interrupção, então vai ligar o led
    BSF PORTA,0
    BCF INTCON,INTF         ;zerar a flag para que só execute a interrupção qd ela acontecer novamente
    RETFIE                  ;return from interruption. usado no final das interrupcoes
    
    END
