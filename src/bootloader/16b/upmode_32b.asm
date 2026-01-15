;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;														;;
;; 	Function to get from 16b mode to 32b mode								;;
;; 		In:												;;
;; 			none											;;
;;														;;
;; 		Out:												;;
;; 			Loaded gdt, enabled 32b mode, jumped to 32b area					;;
;;														;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	[bits 16]

upmode_32b:
	cli

	lgdt [gdt_32b_desc]

	mov eax, cr0
	or eax, 0x01
	mov cr0, eax

	jmp codeseg_32b:upmode_32b_setup

	[bits 32]

upmode_32b_setup:
	mov ax, dataseg_32b
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	mov esp, 0x80000
	jmp boot_32b
