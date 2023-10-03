.code16

# espaço: 0x20
# ╚: 0xda, ═: 0xc4, ║: 0xba, 
# ╝: 0xd9, ╗: 0xbf, ╔: 0xc9

# https://github.com/CelioSlomp/Faculdade/blob/main/ArquiteturaComputadores/Lista_1/Ex_3/ques3.s

.data
lin:
    .byte 0xc4
col:
    .byte 0xba
se:
    .byte 0xc9
sd:
    .byte 0xbf
ie:
    .byte 0xda
id:
    .byte 0xd9

.text

.globl _start

_start:
    movb $0,  %cl # Move 0 para CL
    movb $80, %ch # Move 80 (decimal) para CH
    jmp inicio

print0:
    movb 0xc4, %al # Move o caractere '0' para AL
    movb $0x0e, %ah # Move o código da interrupção para AH
    int  $0x10      # Interrupção da bios
    ret             # Tira da memória o endereço empurado
                    # pela instrução call e dá um jump
                    # neste endereço

inicio:
    call print0 # Empurra pra stack o endereço da instrução
                # atual e depois dá um jump pra print0

    incb %bl # Incrementa BL em 1

    cmpb %bh, %bl # Compara --> BL é menor que BH?
    jl inicio     # Se for menor, pula para o inicio

final:
    # Vai para o 510º byte a partir da posição 0
    . = _start + 510

    # MBR boot signature 
    .byte 0x55
    .byte 0xaa