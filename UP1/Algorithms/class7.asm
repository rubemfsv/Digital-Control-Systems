
    #INCLUDE<P16F84A.INC>
    
    #DEFINE BANK0 BCF STATUS,RP0
    #DEFINE BANK1 BSF STATUS,RP0
    #DEFINE BOTAO0 PORTA,0
    #DEFINE BOTAO1 PORTA,1
    TEMP EQU 0x2C
    
    ORG 0x00
    GOTO INICIO

;--- SE UM VALOR ACIMA DE 31 É INSERIDO NA PORTA B O LED A0 DEVE FICAR ACESO ---;

INICIO
    CLRW
    CLRF PORTB
    CLRF PORTA
    BANK1
    MOVLW 0             ;todos os bits de A sao de saida
    MOVWF TRISA
    MOVLW 0xFF          ;todos os bits de B sao de entrada
    MOVWF TRISB     
    BANK0
    
MAIN
    MOVLW D'31'         ;atribui o valor 31 pro registrador de trabalho
    MOVWF TEMP          ;move o valor do registrador de trabalho (31) para temp
    MOVF PORTB,0        ;move o valor de portb para o registrador de trabalho
    SUBWF TEMP          ;subtrai do registrador de trabalho o valor de temp. 31 - portb
    BTFSS STATUS,C      ;se o bit c de status tiver
    GOTO ACENDE         ;se o valor de c for 0, a subtração deu negativa então o valor era maior que 31 então acende
    GOTO APAGA        ;se o valor de c for 1 a subtração deu maior ou igual a zero então o valor era no máximo 31
    
ACENDE
    BSF PORTA,0         ;acende o led 0 de A
    GOTO MAIN

APAGA
    BCF PORTA,0         ;apaga o led 0 de A
    GOTO MAIN
    
    END


