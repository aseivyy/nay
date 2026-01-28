	[bits 32]

archcheck_32b:
archcheck_32b_cpuidcheck:	
	pushad
	pushfd

	pop eax

	mov ebx, eax
	xor eax, 1 << 21
	push eax

	popfd

	pushfd
	pop eax
	push ebx
	popfd

	cmp eax, ebx
	je archcheck_32b_error

archcheck_32b_extcpuid:
	mov eax, 0x80000000
	cpuid
	cmp eax, 0x80000001
	jb archcheck_32b_error

archcheck_32b_longmode:
	mov eax, 0x80000001
	cpuid
	test edx, 1 << 29	; use test to see if a bit is set, use jnz if is, jz if not
	jz archcheck_32b_error

archcheck_32b_end:
	popad
	ret

archcheck_32b_error:
	mov al, 'R'
	mov ah, 0x0E
	int 0x10
	jmp $
