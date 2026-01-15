;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;														;;
;; 	32 bit gdt structure											;;
;; 		Description:											;;
;; 			No code, just data for gdt								;;
;;														;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	[bits 16]

gdt_32b:

gdt_32b_unused:
	dd 0x00000000
	dd 0x00000000

gdt_32b_code:
	dw 0xFFFF
	dw 0x0000
	db 0x00
	db 0b10011010
	db 0b11001111
	db 0x00

gdt_32b_data:
	dw 0xFFFF
	dw 0x0000
	db 0x00
	db 0b10010010
	db 0b11001111
	db 0x00

gdt_32b_end:

gdt_32b_desc:
	dw gdt_32b_end - gdt_32b - 1 		; size -1, calculated same as in padding zeros for sectors in boot.asm
	dd gdt_32b
	
codeseg_32b:	equ gdt_32b_code - gdt_32b 	; equ is for creating symbols or something like this
dataseg_32b:	equ gdt_32b_data - gdt_32b

