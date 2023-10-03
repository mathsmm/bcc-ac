.code16
.text

.globl _start

_start:

    movw $360, %bx   # Move 360 (decimal) para BX
    movw $720, %cx   # Move 720 (decimal) para CX

    add %bx, %cx    # Soma BX com CX, armazenando o resultado no CX
    add %bx, %cx

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
