	[bits 32]

paging_64b:
	pushad 			; push all double (e registers)

	mov edi, 0x1000
	xor eax, eax
	mov ecx, 4096

	mov cr3, edi

	rep stosd

	mov edi, 0x1000

	mov dword[edi], 0x2003	; 0x3 => exist + rw
	add edi, 4096
	mov dword[edi], 0x3003
	add edi, 4096
	mov dword[edi], 0x4003

	add edi, 4096

	mov ebx, 0x00000003
	mov ecx, 512

paging_64b_map:
	mov dword[edi], ebx
	add ebx, 0x1000
	add edi, 8
	loop paging_64b_map

paging_64b_finish:
	mov eax, cr4
	or eax, 0x1 << 5	; to set fifth bit a person can just take 1 and binary shift it by 5, and then binary or with place the bit should be set
	mov cr4, eax

paging_64b_end:
	popad
	ret
	
