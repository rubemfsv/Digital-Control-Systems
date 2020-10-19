; Codigo em assembly que faz o acionamento retentivo de um led, agora na porta A, dois botões devem somar e subtrair o valor da porta B. Ou seja, um botão ao ser clicado deve somar 1 ao valor da porta B e o outro deve subtrair.

    #INCLUDE <P16F84A.inc>
    
    ORG 0x00 ;Posicionar o jump pra uma label de inicio
    GOTO INICIO
    
INICIO
    CLRW  ;Zera registrador de trabalho
    CLRF PORTA  ;Limpa porta A
    CLRF PORTB  ;Limpa porta B
    BSF STATUS,RP0 ;Registrador status setando no bip 5 RP0
    MOVLW 4 ;Seta o bit 4
    MOVWF TRISB ;Seta para apenas o bit 2 seja de entrada
    MOVLW 0 ;Seta o bit 0 pra ser de saída o registrador A
    MOVWF TRISA ;Retorna como saída por nao utilizarmos
    BCF STATUS,RP0 ; Voltar pra o banco RP0 
    
MAIN
    BTFSS PORTB,RB2 ;Testar o bit e pular uma linha se for 1, testando no bit de entrada 2 na portaB, condicional
    GOTO BUTTON_PRESS ;Vai pra button press se for 1 no BTFSS
    GOTO MAIN ;Vai pra main se for 0

BUTTON_PRESS
    BTFSS PORTB,RB2 ;Testar o bit e pular uma linha se for 1, testando no bit de entrada 2 na portaB, condicional
    GOTO BUTTON_PRESS
    GOTO CHECK_LED ;Vai pra a checagem do led

CHECK_LED
    BTFSS PORTB,RB4 ;Testa o bit 6
    GOTO LED_ON ;vai ligar
    GOTO LED_OFF ;vai desligar

LED_ON
    BSF PORTB,RB4 ;Seta o bit 6 pra ligar o led
    GOTO MAIN
    
LED_OFF
    BCF PORTB,RB4 ;Reseta o bit e apaga o led
    GOTO MAIN


    END
