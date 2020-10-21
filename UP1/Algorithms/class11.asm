    #INCLUDE<P16F84A.INC>
    
    ORG 0X00
    GOTO INICIO
    
    ORG 0X04                    ;as interrupções sempre levam para a posição 4
    GOTO INTERRUPT
    
    ;--- ACENDER E APAGAR UM LED ATRAVÉS DE BOTOES USANDO INTERRUPCAO ---;
    
INICIO
    CLRW
    CLRF PORTB
    CLRF PORTA
    BSF STATUS,RP0
    MOVLW 0                     ;todos os bits de A sao de saida
    MOVWF TRISA
    MOVLW 1                     ;1 = 00000001
    MOVWF TRISB                 ;apenas o bit 0 de B é entrada
    BCF STATUS,RP0  
    BSF INTCON,GIE              ;habilitação do bit geral de interrupções
    BSF INTCON,INTE             ;habilitação da interrupção por borda do pino rb0
    
MAIN
    GOTO MAIN                   ;como o programa só faz algo quando é gerada uma interrupção de click a lógica principal fica parada aguardando essa interrupção acontecer
    
INTERRUPT                       ;se chegou aqui é pq houve a interrupção
    BSF PORTA,0
    GOTO ACENDE                 ;se tiver em 0 vai acender
    GOTO APAGA                  ;se tiver em 1 vai apagar    

ACENDE
    BSF PORTA,0
    GOTO FIM
    
APAGA
   BCF PORTA,0
   GOTO FIM
   
FIM
    MOVF PORTB,0            ;ler a porta B pra salvar seu ultimo valor
    BCF INTCON,RBIF         ;reset da flag
    RETFIE                  ;return from interruption. usado no final das interrupcoes
    
    END
