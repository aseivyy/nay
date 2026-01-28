all: bootloader kernel ksize image
.PHONY: all

bootloader:
	make -C src/bootloader

kernel:
	make -C src/kernel

ksize:
	sh utils/ksize.sh

image:
	cp src/bootloader/boot.bin image.img
	cat src/kernel/kernel >> image.img
	echo "Done, have fun"

clean:
	rm src/kernel/kernel
	rm src/kernel/kernel.elf
