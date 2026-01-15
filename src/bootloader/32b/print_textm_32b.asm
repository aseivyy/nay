;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;														;;
;; 	Printing function for protected mode while in text mode							;;
;; 		In:												;;
;; 			ebx: Pointer to string ending with '0'							;;
;;														;;
;; 		Out:												;;
;; 			Printed text on the screen								;;
;;														;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	[bits 32]

print_textm_32b:
	pusha
	mov edx, 0xB8000

print_textm_32b_loop:
	cmp byte[ebx], 0
	je print_textm_32b_end

	mov al, byte[ebx]
	mov ah, 0x07
	
	mov word[edx], ax

	inc ebx
	add edx, 2

	jmp print_textm_32b_loop

print_textm_32b_end:
	popa
	ret
