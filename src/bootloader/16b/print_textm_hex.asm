	[bits 16]

print_textm_hex:
	push ax
	push bx
	push cx

	mov ah, 0x0E

	mov al, '0'
	int 0x10
	mov al, 'x'
	int 0x10

	mov cx, 0

print_textm_hex_loop:
	cmp cx, 4
	jge print_textm_hex_end

	push bx

	shr bx, 12

	cmp bx, 9
	jg print_textm_hex_loop_letter

	mov al, '0'
	add al, bl
	jmp print_textm_hex_loop_print

print_textm_hex_loop_letter:
	sub bl, 10
	mov al, 'a'
	add al, bl

print_textm_hex_loop_print:
	int 0x10

	pop bx
	shl bx, 4
	inc cx

	jmp print_textm_hex_loop

print_textm_hex_end:
	pop cx
	pop bx
	pop ax

	ret
