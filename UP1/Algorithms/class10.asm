
    #INCLUDE<P16F84A.INC>
    
    
    MEM EQU 0X2C            ;memoria que vai ser incrementada pelas interrupcoes
    TEMP EQU 0X2D
    ORG 0X00
    GOTO INICIO
    
    ORG 0X04                ;as interrupções sempre levam para a posição 4
    GOTO INTERRUPT
    
    ;--- A PARTIR DE 4 ENTRADAS NA PORTA B, AO PULSO DE CADA UMA UMA MEMÓRIA DEVE SER INCREMENTADA COM OS VALORES 1,2,3,4 ---;
    ;--- SE O VALOR DA MEMÓRIA FOR MAIOR QUE 20, UM LED DEVE SER ACESSO NO BIT 0 DA PORTA A ---;
    
INICIO
    CLRW
    CLRF PORTA
    CLRF PORTB
    BSF STATUS,RP0
    MOVLW 0                 ;todos os bits de A sao de saida
    MOVWF TRISA
    MOVLW B'11110000'       ;1111 sao os bits 4,5,6,7 que são de entrada e os outros são de saída
    MOVWF TRISB             
    BCF STATUS,RP0
    MOVLW D'20'             ;coloca o valor 20 no registrador de trabalho
    MOVWF TEMP              ;copia o valor do registrador de trabalho (20) para temp
    BSF INTCON,GIE          ;habilitação do bit geral de interrupções
    BSF INTCON,RBIE         ;habilitação da interrupção por mudança na porta B


    ;--- ROTINA PRINCIPAL ---;  
MAIN
    MOVF MEM,0              ;coloca o valor de MEM no registrador de trabalho
    SUBWF TEMP,0            ;faz a subtração de 20 pelo valor de MEM, que está alocado no registrador de trabalho
    BTFSS STATUS,C
    GOTO ACENDE             ;se o valor de c for 0, a subtração deu negativa então o valor era maior que 31 então acende
    GOTO APAGA              ;se o valor de c for 1 a subtração deu maior ou igual a zero entao o valor era no maximo 31
    
ACENDE
    BSF PORTA,0             ;acende o bit 0 de A
    GOTO MAIN

APAGA
    BCF PORTA,0             ;apaga o bit 0 de A
    GOTO MAIN

    ;--- ROTINA DA INTERRUPCAO ---;
    ;--- A INTERRUPÇÃO NÃO MOSTRA QUAL DOS 4 BITS QUE FOI ALTERADO, ENTÃO TEM QUE TESTAR 1 POR 1 PARA VER QUAL MUDOU PARA O ESTADO 1 ---;
    ;--- BTFSC TESTA SE UM BIT É 0 ---;
    
INTERRUPT
    BTFSC PORTB,4               ;testa se o bit 4 é 0
    GOTO ROUTINE4               ;se for 1 vai para a rotina referente ao bit 4
    BTFSC PORTB,5               ;se o bit 4 for 0 pula uma linha e vem para cá testar se o bit 5 é 0
    GOTO ROUTINE5               ;se for 1 vai para a rotina referente ao bit 5
    BTFSC PORTB,6               ;se o bit 5 for 0 pula uma linha e vem para cá testar se o bit 6 é 0
    GOTO ROUTINE6               ;se for 1 vai para a rotina referente ao bit 6
    BTFSC PORTB,7               ;se o bit 6 for 0 pula uma linha e vem para cá testar se o bit 7 é 0
    GOTO ROUTINE7               ;se for 1 vai para a rotina referente ao bit 7
    GOTO FIM
    
ROUTINE4
    MOVLW 1                 ;coloca o valor 1 no registrador de trabalho
    ADDWF MEM,1             ;soma o valor do registrador de trabalho (1) a memoria a ser incrementada MEM
    GOTO FIM

ROUTINE5
    MOVLW 2                 ;coloca o valor 2 no registrador de trabalho
    ADDWF MEM,1             ;soma o valor do registrador de trabalho (2) a memoria a ser incrementada MEM
    GOTO FIM

ROUTINE6
    MOVLW 3                 ;coloca o valor 3 no registrador de trabalho
    ADDWF MEM,1             ;soma o valor do registrador de trabalho (3) a memoria a ser incrementada MEM
    GOTO FIM

ROUTINE7
    MOVLW 4                 ;coloca o valor 4 no registrador de trabalho
    ADDWF MEM,1             ;soma o valor do registrador de trabalho (4) a memoria a ser incrementada MEM
    GOTO FIM
    
FIM
    MOVF PORTB,0            ;ler a porta B para guardar o valor, pequeno bug do programa precisar disso
    BCF INTCON,RBIF         ;resetar a flag da interrupcao
    RETFIE                  ;sair da interrupcao
    
    END
   
