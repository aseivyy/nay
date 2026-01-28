ksize=$(wc -c < src/kernel/kernel)
ksectors=$(( ($ksize + 511) / 512 ))
printf %02x ${ksectors} | xxd -r -p | dd of=src/bootloader/boot.bin bs=1 seek=2 count=1 conv=notrunc
