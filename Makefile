# Author: Éder Augusto Penharbel

.PHONY: clean image
SOURCE = escrevex

all: image

# gerar arquivo floppy.img (um arquivo que corresponde ao disquete)
# o arquivo será preenchido com zero e terá o tamanho de um disquete
floppy.img:
	dd if=/dev/zero of=$@ bs=512 count=2880

# "compilar" o arquivo que contém os mnemônicos das instruções
$(SOURCE).o: $(SOURCE).s
	as $< -o $@

# linkeditar para um binário de 16 bits com endereços relativos a 0x7c00
$(SOURCE).bin: $(SOURCE).o
	ld --Ttext 0x7c00 --oformat=binary $(SOURCE).o -o $(SOURCE).bin

# copiar o arquivo binário executável para o arquivo floppy.img
image: $(SOURCE).bin floppy.img
	dd if=$(SOURCE).bin of=floppy.img bs=512 count=1 conv=notrunc

# deletar arquivos 
clean:
	$(RM) -f floppy.img
	$(RM) -f $(SOURCE).o
	$(RM) -f $(SOURCE).bin
