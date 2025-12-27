all: bootloader image
.PHONY: all

bootloader:
	make -C src/bootloader

image:
	mv src/bootloader/boot.bin boot.img
