	[org 0x7c00]
	[bits 16]

boot:
	xor ax, ax
	mov ss, ax
	mov sp, 0x7bff

	call video_setup_16b
	
	jmp $

	%include "16b/video_setup_16b.asm"

	times 510 - ($ - $$) db 0
	dw 0xaa55
