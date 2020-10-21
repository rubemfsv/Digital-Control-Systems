; Codigo em assembly que faz o acionamento retentivo de um led, agora na porta A, dois botões devem somar e subtrair o valor da porta B. Ou seja, um botão ao ser clicado deve somar 1 ao valor da porta B e o outro deve subtrair.


    INCLUDE<P16F84A.INC>
    
    #DEFINE BOTAO0 PORTA,0          ;define o pino 0 de A como o botao 0. SOMA
    #DEFINE BOTAO1 PORTA,1          ;define o pino 1 de A como o botao 1. SUBTRAI
    
    ORG 0X00
    GOTO INICIO
    
    ;--- A CONTEM 2 BOTOES, UM QUE SOMA 1 EM B E OUTRO QUE SUBTRAI 1 EM B ---;
    
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
    BTFSS BOTAO0                    ;quando a entrada ta em 1 o botao ta  solto, quando ta em 0 o botao ta pressionado
    GOTO BOTAO0_PRESS               ;quando da 0 ele ta pressionado
    GOTO CHECA_BOTAO1               ;se chegou e ta solto vai chegar o proximo botao
      
BOTAO0_PRESS    
    BTFSS BOTAO0                    
    GOTO BOTAO0_PRESS               ;se ele permanecer em 0 o botao ainda ta pressionado 
    GOTO SOMA                       ;quando tiver 1 soltou o botao e vai realizar a soma
    
CHECA_BOTAO1
    BTFSS BOTAO1
    GOTO BOTAO1_PRESS               ;se tiver 0 o botao ta pressionado e vai para a label de pressionar
    GOTO MAIN                       ;se tiver 1 volta o botao ta solto e volta pro comeco para checar o botao 0 novamente
      
BOTAO1_PRESS
    BTFSS BOTAO1
    GOTO BOTAO1_PRESS               ;se tiver 0 ainda ta pressionado
    GOTO SUB                        ;se tiver em 1 foi solto e vai realizar a subtracao
    
    ;--- OPERACOES ---;
    
SOMA
    INCF PORTB, 1                   ;incrementa 1 no registrador
    GOTO MAIN
    
SUB
    DECF PORTB,1                    ;decrementa 1 no registrador
    GOTO MAIN
    
    END
