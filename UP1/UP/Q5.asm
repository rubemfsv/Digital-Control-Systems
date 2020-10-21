; Um sistema de medição de nível deve ser executado com um microcontrolador. A  porta B funcionará 
; como um leitor de um sensor de nível. Logo, esse sensor irá variar de 0 a 255.  O sistema funciona
; de duas formas distintas, a depender do estado do pino 1 da porta A: 
; Pino 1 da porta A em ALTO. Se o nível estiver abaixo do valor 20, uma saída no pino 0 da porta  A
; deve ser acionada pra ligar uma bomba e encher o tanque. Se o nível passar de 190, a bomba deve ser desligada; 
; Pino 1 da porta A em BAIXO. O sistema de bombeamento estará desligado.

    #INCLUDE<P16F84A.inc>
    
    TEMP EQU 0x2C 
    MIN EQU 0x2D
    MAX EQU 0x2E
    
    ORG 0x00 
    GOTO INICIO

INICIO
	  CLRW   
	  CLRF PORTA
	  CLRF PORTB
    BSF STATUS,RP0 
    MOVLW B'00000010' 
    MOVWF TRISA   
    MOVLW B'11111111' 
    MOVWF TRISB 
    BCF STATUS,RP0 
    GOTO MAIN

MAIN
	  BTFSC PORTA,1 
	  GOTO PINO
	  BCF PORTA,0
    GOTO MAIN 

PINO
    MOVLW D'19'
    MOVWF TEMP
    MOVF PORTB,0
    MOVWF MIN
    MOVWF MAX
    MOVF MIN,0
    SUBWF TEMP,0 
    BTFSC STATUS,C 
	GOTO PINO_ALTO
	GOTO PINO_BAIXO    
    
PINO_ALTO
    BCF STATUS,C
    BCF STATUS,Z
    BSF PORTA,0
    GOTO MAIN

PINO_BAIXO
    BCF STATUS,C
    BCF STATUS,Z
    MOVF D'191'
    MOVWF TEMP
    MOVF MAX,0
    SUBWF TEMP,0 
    BTFSC STATUS,C
    GOTO MAIN
    BCF PORTA,0
    GOTO MAIN


	END
