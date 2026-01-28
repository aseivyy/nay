;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;														;;
;; 	64 bit gdt structure											;;
;; 		Description:											;;
;; 			No code, just data for gdt								;;
;;														;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	[bits 32]

gdt_64b:

gdt_64b_unused:
	dd 0x00000000
	dd 0x00000000

gdt_64b_code:
	dw 0xFFFF
	dw 0x0000
	db 0x00
	db 0b10011010
	db 0b10101111
	db 0x00

gdt_64b_data:
	dw 0x0000
	dw 0x0000
	db 0x00
	db 0b10010010
	db 0b10101111
	db 0x00

gdt_64b_end:

gdt_64b_desc:
	dw gdt_64b_end - gdt_64b - 1 		; size -1, calculated same as in padding zeros for sectors in boot.asm
	dd gdt_64b
	
codeseg_64b:	equ gdt_64b_code - gdt_64b 	; equ is for creating symbols or something like this
dataseg_64b:	equ gdt_64b_data - gdt_64b

