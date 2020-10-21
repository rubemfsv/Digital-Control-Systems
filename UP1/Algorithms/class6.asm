    INCLUDE<P16F84A.INC>
    
    #DEFINE BOTAO0 PORTA,0          ;define o pino 0 de A como o botao 0. SOMA
    #DEFINE BOTAO1 PORTA,1          ;define o pino 1 de A como o botao 1. SUBTRAI
    TEMP EQU 0X2C                   ;registrador temporario 
    
    ORG 0X00
    GOTO INICIO
    
    ;--- A CONTÉM 2 BOTÕES, UM QUE SOMA 1 EM B E OUTRO QUE SUBTRAI 1 EM B ---;
    ;--- SE A SOMA PASSAR DE 1O ESSA SOMA NÃO DEVE MAIS FUNCIONAR ---;
    ;--- SE A SUBTRAÇÃO CHEGAR A 0 PARA ---;
    
    ;--- LÓGICA SOMA: FAZER 10 - VALOR ATUAL, SE DER 0 ATIVA O BIT Z (VAI PRA 1) E USA ISSO COMO CONDIÇÃO DE PARADA ---;
    ;--- SE NAO DER 0 O BIT Z FICA 0 ENTAO PODE REALIZAR A SOMA ---;
    
INICIO
    CLRW
    CLRF PORTA
    CLRF PORTB
    
    BCF STATUS, RP0
    BSF TRISA, 0                    ;seta o bit 0 de A como de entrada
    BSF TRISB, 1                    ;seta o bit 1 de A como de entrada
    CLRF PORTB                      ;todos os bit de B sao 0 (de saida)
    BSF STATUS, RP0                 
   
   
   ;---CONTROLE DOS BOTOES ---; 
    
MAIN
    BTFSS BOTAO0                    ;quando a entrada ta em 1 o botão ta  solto, quando ta em 0 o botão ta pressionado
    GOTO BOTAO0_PRESS               ;quando da 0 ele ta pressionado
    GOTO CHECA_BOTAO1               ;se chegou e ta solto vai chegar o proximo botão
      
BOTAO0_PRESS    
    BTFSS BOTAO0                    
    GOTO BOTAO0_PRESS               ;se ele permanecer em 0 o botao ainda ta pressionado 
    GOTO CHECA_SOMA                ;antes de somar precisa checar se ja chegou a 10
    
CHECA_BOTAO1
    BTFSS BOTAO1
    GOTO BOTAO1_PRESS               ;se tiver 0 o botão ta pressionado e vai para a label de pressionar
    GOTO MAIN                       ;se tiver 1 volta o botão ta solto e volta pro começo para checar o botão 0 novamente
      
BOTAO1_PRESS
    BTFSS BOTAO1
    GOTO BOTAO1_PRESS               ;se tiver 0 ainda ta pressionado
    GOTO CHECA_SUB                        ;se tiver em 1 foi solto e vai realizar a subtracao
    
CHECA_SOMA
    MOVF PORTB,0                    ;coloca o que tem na porta B no registrador de trabalho 
    MOVWF TEMP                      ;move o que tem no registrador de trabalho para temp
    MOVLW 0XA                       ;move a constante A que vale 10 (em hex) para o registrador de trabalho         
    SUBWF TEMP,0                    ;subtrai o que tem em temp do registrador de trabalho. registrador de trabalho(10) - temp
    BTFSS STATUS,Z                  ;chegar o valor do bit Z do registrador de trabalho
    GOTO SOMA                       ;se ele tiver em 0 é pq a subtração nao deu 0
    GOTO MAIN                       ;se ele tiver 1 é pq a subtração deu 1 então já atingiu 0
    
CHECA_SUB
    MOVF PORTB,0                    ;coloca o que tem na porta B no registrador de trabalho 
    MOVWF TEMP                      ;move o que tem no registrador de trabalho para temp
    MOVLW 0X0                       ;move a constante 0 para o registrador de trabalho         
    SUBWF TEMP,0                    ;subtrai o que tem em temp do registrador de trabalho. registrador de trabalho(0) - temp
    BTFSS STATUS,Z                  ;chegar o valor do bit Z do registrador de trabalho
    GOTO SUB                        ;se ele tiver em 0 é pq a subtração nao deu 0, então pode continuar
    GOTO MAIN                       ;se ele tiver 1 é pq a subtração deu 0 entao para 
    
    
    ;--- OPERACOES ---;
    
SOMA
    INCF PORTB, 1                   ;incrementa 1 no registrador
    GOTO MAIN
    
SUB
    DECF PORTB,1                    ;decrementa 1 no registrador
    GOTO MAIN
        
    END
