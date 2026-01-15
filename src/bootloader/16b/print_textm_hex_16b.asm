;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;														;;
;; 	Hex printing function for real mode while in text mode							;;
;; 		In:												;;
;; 			ebx: 32b data to print									;;
;;														;;
;; 		Out:												;;
;; 			Printed text on the screen, lowercase, prefixed with '0x', example '0x0000f1f1'		;;
;;														;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	[bits 16]

print_textm_hex_16b:
	push ax			; Using for printing
	push ebx		; Data
	push cx			; Counter

	mov ah, 0x0E

	mov al, '0'
	int 0x10
	mov al, 'x'
	int 0x10

	xor cx, cx

print_textm_hex_16b_loop:
	cmp cx, 8
	jge print_textm_hex_16b_end

	push ebx

	shr ebx, 28

	cmp ebx, 9
	jg print_textm_hex_16b_loop_letter

	mov al, '0'
	add al, bl
	jmp print_textm_hex_16b_loop_print

print_textm_hex_16b_loop_letter:
	sub bl, 10
	mov al, 'a'
	add al, bl

print_textm_hex_16b_loop_print:
	int 0x10

	pop ebx
	shl ebx, 4
	inc cx

	jmp print_textm_hex_16b_loop

print_textm_hex_16b_end:
	pop cx
	pop ebx
	pop ax

	ret
