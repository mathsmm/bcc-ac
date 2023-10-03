.code16
.text

.globl _start

_start:

    movb $10, %bx   # Move 10 (decimal) para BH
    movb $15, %cx   # Move 15 (decimal) para BL

    add %bh, %bl    # Soma BH com BL, armazenando o resultado no BL

    movb %bl, %al   # Move o resultado da soma para o AL
    movb $0x0e, %ah # Move o código da interrupção para o AH
    int  $0x10      # Interrupção da bios
                    # Printa na tela o caractere "END OF MEDIUM"
                    # este caractere 0x19 (25 em decimal) da tabela ASCII

    # Foi possível visualizar o código em execução 
    # usando os seguintes comandos no debugger do Bochs:
    # b 0x7c00 --> para colocar um breakpoint no endereço 0x7c00
    # c        --> para continuar a execução até o breakpoint
    # s        --> para executar as instruções uma por uma
    # r        --> para visualizar os valores nos registradores


    # mov to 510th byte from 0 pos
    . = _start + 510
    
    # MBR boot signature 
    .byte 0x55
    # MBR boot signature 
    .byte 0xaa
