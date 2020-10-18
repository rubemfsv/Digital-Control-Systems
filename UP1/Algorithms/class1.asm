    #INCLUDE <P16F84A.inc>
    
    ORG 0x00
    GOTO INICIO
    
INICIO
    CLRW  ;Zera registrador de trabalho
    CLRF PORTA  ;Limpa porta A
    CLRF PORTB  ;Limpa porta B
    ;Definição de estado
