;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;																;;
;; 	Screen clearing function for protected mode while in text mode								;;
;; 		In:														;;
;; 			none													;;
;;																;;
;; 		Out:														;;
;; 			Cleared screen (displayed cursor doesnt move, but placed text is at the right position			;;
;;																;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	[bits 32]

clear_textm_32b:
	pusha

	mov ecx, 2000
	mov edi, 0xB8000

clear_textm_32b_loop:
	test ecx, ecx
	jz clear_textm_32b_end

	mov al, ` `
	mov ah, 0x07
	mov word[edi], ax

	add edi, 2
	dec ecx

	jmp clear_textm_32b_loop

clear_textm_32b_end:
	popa
	ret

CHAR_SPACE:	db ` `
	
