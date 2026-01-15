;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;														;;
;; 	Printing function for real mode while in text mode							;;
;; 		In:												;;
;; 			bx: Pointer to string ending with '0'							;;
;;														;;
;; 		Out:												;;
;; 			Printed text on the screen								;;
;;														;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	[bits 16b]
	
print_textm_16b:
	push ax			; used for interrupt
	push bx			; data

	mov ah, 0x0e

print_textm_16b_loop:	
	cmp byte[bx], 0
	je print_textm_16b_end

	mov al, byte[bx]
	int 0x10

	inc bx
	jmp print_textm_16b_loop

print_textm_16b_end:
	pop bx
	pop ax

	ret

print_textm_nl_16b:
	push ax
	mov ah, 0x0e
	mov al, `\r`
	int 0x10
	mov al, `\n`
	int 0x10
	pop ax
	ret
