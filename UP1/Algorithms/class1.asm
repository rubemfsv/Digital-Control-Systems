; Codigo em assembly pra setar um bit para a porta B, um pino configurado como saída

    #INCLUDE <P16F84A.inc>
    
    ORG 0x00
    GOTO INICIO
    
INICIO
    CLRW  ;Zera registrador de trabalho
    CLRF PORTA  ;Limpa porta A
    CLRF PORTB  ;Limpa porta B
    BSF STATUS,RP0 ;Registrador status setando no bip RP0
    CLRF TRISA ;Zerar o primeiro registrador
    CLRF TRISB ;Zerar o segundo registrador
    BCF STATUS,RP0 ; Voltar pra o banco RP0 
    
MAIN
    BSF PORTB,1 ;Seta o bit 1 na porta B
    GOTO MAIN
    
    END
