	[org 0x7c00]
	[bits 16]

boot:
	xor ax, ax
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov gs, ax
	mov fs, ax
	mov sp, 0x7bff

	mov byte[DRIVE_NUMBER], dl

	mov al, 0x01
	mov ch, 0x00
	mov cl, 0x02
	mov dh, 0x00
	mov bx, 0x7e00
	
	call disk_16b

	mov bx, word[DISK_TEST]
	call print_textm_hex
	
	jmp $

	;; %include "16b/video_setup_16b.asm"
	%include "16b/print_textm_hex.asm"
	%include "16b/disk_16b.asm"

DRIVE_NUMBER:			db 0
	
	times 510 - ($ - $$) db 0
	dw 0xaa55

DISK_TEST:	dw 0xDDDD
