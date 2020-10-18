; Codigo em assembly que lê a entrada de um botão no microcontrolador, aciona um led em outro pino quando o botão estiver pressionado e desacione quando o botão estiver

    #INCLUDE <P16F84A.inc>
    
    ORG 0x00
    GOTO INICIO
    
INICIO
    CLRW  ;Zera registrador de trabalho
    CLRF PORTA  ;Limpa porta A
    CLRF PORTB  ;Limpa porta B
    BSF STATUS,RP0 ;Registrador status setando no bip RP0
    CLRF TRISA ;Zerar o primeiro registrador
    MOVLW 4 ;Seta o bit 4
    MOVWF TRISB ;Seta no registrador TRISB
    BCF STATUS,RP0 ; Voltar pra o banco RP0 
    
MAIN
    BTFSS PORTB,2 ;Testar o bit e pular uma linha se for 1, testando no bit de entrada 2 na portaB, condicional
    GOTO DESLIGA ;Vai pra desliga se for 0
    GOTO LIGA ;Vai pra liga se for 1 no BTFSS

DESLIGA
    BCF PORTB,6 ;Resetar o bit de saída
    GOTO MAIN ;Vai pra o main

LIGA
    BSF PORTB,6 ;Seta o bit 6
    GOTO MAIN ;Vai pra o main
    
    END
