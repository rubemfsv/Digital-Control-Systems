    #INCLUDE<P16F84A.INC>
    
    ORG 0X00
    GOTO INICIO
    
    ORG 0X04                ;as interrupções sempre levam para a posição 4
    GOTO INTER
    
    ;--- AO MUDAR ALGUM DOS 4 BITS MAIS SIGNIFICATIVOS DE B SOMA 1 EM A ---;
    
INICIO
    CLRW
    CLRF PORTB
    CLRF PORTA
    BSF STATUS,RP0
    MOVLW 0                 ;todos os bits de A sao de saida
    MOVWF TRISA
    MOVLW B'11110000'       ;1111 sao os bits 4,5,6,7 que são de entrada e os outros são de saída
    MOVWF TRISB             
    BCF STATUS,RP0
    
    BSF INTCON,GIE          ;habilitação do bit geral de interrupções
    BSF INTCON,RBIE         ;habilitação da interrupção por mudança na porta B
    
MAIN
    GOTO MAIN               ;não tem nada na lógica principal, só muda algo quando tem uma interrupção
    
INTER
    INCF PORTA,1            ;incrementar 1 na porta A
    MOVF PORTB,0            ;ler o ultimo valor lido de B para ele atualizar, pequeno bug do sistema
    BCF INTCON,RBIE         ;zerar a flag
    RETFIE


    END
    
