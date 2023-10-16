.code16
.text

.globl _start

_start:
    # PREPARAÇÃO DO SEGMENTO DE DADOS
    movw $0x1000, %ax
    movw %ax, %ds # DS (Data Segment)
    # O endereço "verdadeiro" que DS apontará depois da execução
    # do código acima é 0x10000 (0x1000 * 0x10)
    movw $0x0000, %si
    movb $0xcd, %ds:(%si)  # Leva 0xcd para o endereço 
                           # DS * 0X10 + SI, que é
                           # 0x1000 * 0x10 + 0x0000
    movb $0xba, %ds:1(%si) # '═' --> (DS * 0X10 + SI + 1)
    movb $0xc9, %ds:2(%si) # '║' --> (DS * 0X10 + SI + 2)
    movb $0xbb, %ds:3(%si) # '╔' --> (DS * 0X10 + SI + 3)
    movb $0xc8, %ds:4(%si) # '╗' --> (DS * 0X10 + SI + 4)
    movb $0xbc, %ds:5(%si) # '╚' --> (DS * 0X10 + SI + 5)
    movb $0x20, %ds:6(%si) # '╝' --> (DS * 0X10 + SI + 6)

main:
    # BORDA SUPERIOR E CANTOS SUPERIORES DA CAIXA
    movb %ds:2(%si), %al # Move o caractere '╔' para AL
    call print # Empurra pra stack o endereço da instrução
               # atual e depois dá um jump pra print
    movb %ds:(%si), %al  # Move o caractere '=' para AL
    movw $78, %cx        # Move 78 para CX (Para iterar 78 vezes)
    call loop1
    movb %ds:3(%si), %al # '╗'
    call print

    # BORDAS LATERAIS DA CAIXA
    movw $22, %cx # Move 22 para CX (para loop2 iterar 22 vezes)
    call loop2    # loop2

    # BORDA INFERIOR E CANTOS INFERIORES DA CAIXA
    movb %ds:4(%si), %al # '╚'
    call print
    movb %ds:(%si), %al  # '='
    movw $78, %cx
    call loop1
    movb %ds:5(%si), %al # '╝'
    call print

    jmp final

loop1:
    call print
    loop loop1 # Decrementa cx e pula para o rótulo
               # "loop1" se cx não for zero
    ret

loop2:

    # BORDA LATERAL ESQUERDA
    movb %ds:1(%si), %al # '║'
    call print

    # PREENCHER COM ESPAÇOS
    movb %ds:6(%si), %al # ' ' (espaço)
    movw %cx, %dx        # Salva CX em DX
    movw $78, %cx        # Move 78 para CX (Para iterar 78 vezes)
    call loop1
    movw %dx, %cx        # Retorna o conteúdo de CX salvo em DX

    # BORDA LATERAL DIREITA
    movb %ds:1(%si), %al # '║'
    call print
    loop loop2
    ret

print:
    movb $0x0e, %ah # Move o código da interrupção para AH
    int  $0x10      # Interrupção da bios
    ret             # Tira da memória o endereço empurrado
                    # pela instrução call e dá um jump
                    # neste endereço

final:
    # Vai para o 510º byte a partir da posição 0
    . = _start + 510
    # Assinatura MBR boot
    .byte 0x55
    .byte 0xaa