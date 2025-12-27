	[bits 16]

video_setup_16b:
	push ax

	xor ax, ax
	mov al, 0x13
	int 0x10

video_setup_test_16b:
	push ax
	push bx
	push cx
	push dx

	mov ah, 0x0c
	mov al, 0xaa
	xor bx, bx
	xor cx, cx
	xor dx, dx

	int 0x10

	pop dx
	pop cx
	pop bx
	pop ax

video_setup_end_16b:
	pop ax
	ret
	
