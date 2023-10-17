.code16
.text

.globl _start

_start:

loop1:
    call read
    call print
    jmp  loop1

print:
    movb $0x0e, %ah
    int $0x10
    ret

read:
    movb $0, %ah
    int  $0x16
    ret

final:
    # Vai para o 510º byte a partir da posição 0
    . = _start + 510
    # Assinatura MBR boot
    .byte 0x55
    .byte 0xaa