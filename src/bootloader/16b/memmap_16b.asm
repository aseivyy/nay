;; 	[bits 16]

;; memmap_16b:
;; 	push eax
;; 	push ebx
;; 	push ecx
;; 	push edx
;; 	push di
;; 	push si
	
;; 	xor ebx, ebx
;; 	xor si, si

;; 	mov edx, 0x0534d4150
;; 	mov eax, 0xe820

;; 	mov [di + 20], dword 1
;; 	mov ecx, 24

;; 	int 0x15
;; 	jc memmap_16b_fatal

;; 	mov edx, 0x0534d4150
;; 	cmp eax, edx
;; 	jne memmap_16b_fatal

;; 	test ebx, ebx
;; 	je memmap_16b_fatal

;; 	jmp memmap_16b_end

;; ;; memmap_16b_nextcall:
;; ;; 	mov eax, 0xe820
;; ;; 	mov [di + 20], dword 1
;; ;; 	mov ecx, 24
;; ;; 	int 0x15
;; ;; 	jc memmap_16b_end
;; ;; 	mov edx, 0x0534d4150
	
;; ;; memmap_16b_loop:
;; ;; 	jcxz memmap_16b_ignore	; jmp if cx and dx are equal to 0
;; ;; 	cmp cl, 20
;; ;; 	jbe memmap_16b_test
;; ;; 	test byte[di + 20], 1
;; ;; 	je memmap_16b_ignore

;; ;; memmap_16b_test:
;; ;; 	mov ecx, [di + 8]
;; ;; 	or ecx, [di + 12]
;; ;; 	jz memmap_16b_ignore
;; ;; 	inc si
;; ;; 	add di, 24
	
;; ;; memmap_16b_ignore:
;; ;; 	test ebx, ebx
;; ;; 	jne memmap_16b_nextcall
	
;; memmap_16b_end:
;; 	pop si
;; 	pop di
;; 	pop edx
;; 	pop ecx
;; 	pop ebx
;; 	pop eax

;; 	ret

;; memmap_16b_fatal:
	;; 	mov ebx, 0xFFFFF

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
