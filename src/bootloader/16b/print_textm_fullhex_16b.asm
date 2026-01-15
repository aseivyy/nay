;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;														;;
;; 	Hex printing function for real mode while in text mode but for 64bit data				;;
;; 		In:												;;
;;			edx: Higher 32 bits of 64 bit hex data							;; 
;; 			ebx: Lower 64 bits of 64 bit hex data							;;
;;														;;
;; 		Out:												;;
;; 			Printed text on the screen, lowercase, prefixed with '0x', example '0x0000f1f1'		;;
;;														;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	[bits 16]

print_textm_fullhex_16b:
	push ax			; Using for printing
	push ebx		; Data
	push cx			; Counter
	push edx		; Data

	mov ah, 0x0E

	mov al, '0'
	int 0x10
	mov al, 'x'
	int 0x10

	xor cx, cx

print_textm_fullhex_16b_loop_high:
	cmp cx, 8
	jge print_textm_fullhex_16b_lowsetup

	push edx

	shr edx, 28

	cmp edx, 9
	jg print_textm_fullhex_16b_loop_high_letter

	mov al, '0'
	add al, dl
	jmp print_textm_fullhex_16b_loop_high_print

print_textm_fullhex_16b_loop_high_letter:
	sub dl, 10
	mov al, 'a'
	add al, dl

print_textm_fullhex_16b_loop_high_print:
	int 0x10

	pop edx
	shl edx, 4
	inc cx

	jmp print_textm_fullhex_16b_loop_high

print_textm_fullhex_16b_lowsetup:
	xor cx, cx
	
print_textm_fullhex_16b_loop_low:
	cmp cx, 8
	jge print_textm_fullhex_16b_end

	push ebx

	shr ebx, 28

	cmp ebx, 9
	jg print_textm_fullhex_16b_loop_low_letter

	mov al, '0'
	add al, bl
	jmp print_textm_fullhex_16b_loop_low_print

print_textm_fullhex_16b_loop_low_letter:
	sub bl, 10
	mov al, 'a'
	add al, bl

print_textm_fullhex_16b_loop_low_print:
	int 0x10

	pop ebx
	shl ebx, 4
	inc cx

	jmp print_textm_fullhex_16b_loop_low

print_textm_fullhex_16b_end:
	mov al, ' '
	int 0x10
	
	pop edx
	pop cx
	pop ebx
	pop ax

	ret
