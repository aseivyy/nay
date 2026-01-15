;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 										;;
;;	Function to get the memory map from the BIOS    			;;
;;		In:								;;
;;			di: 	Address to where to put the memory map		;;
;; 		Out:								;;
;;			Table at address on di					;;
;; 										;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	[bits 16]

memmap_16b:
	push eax
	push ebx
	push ecx
	push edx
	push di

	mov eax, 0xe820
	xor ebx, ebx
	mov ecx, 24
	mov edx, 0x0534D4150

	int 0x15

	jc memmap_16b_fatal
	
	mov edx, 0x0534D4150
	cmp eax, edx
	jne memmap_16b_fatal

	test ebx, ebx		; alternative way to cmp bx, 0, propably more efficent
	jz memmap_16b_fatal

	jmp memmap_16b_test

memmap_16b_loop:
	test ebx, ebx
	jz memmap_16b_end
	
	mov eax, 0xe820
	mov edx, 0x0534D4150

	int 0x15

	jc memmap_16b_end

memmap_16b_test:
	jcxz memmap_16b_bad
	mov edx, [di + 8]
	or edx, [di + 12]
	jz memmap_16b_bad

	add di, 24

memmap_16b_bad:
	jmp memmap_16b_loop
	
memmap_16b_end:
	pop di
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret

memmap_16b_fatal:
	mov ebx, 0xFFFFFFFF
	call print_textm_hex_16b
	jmp $
