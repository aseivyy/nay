	[bits 32]

upmode_64b:
	mov ecx, 0xC0000080
	rdmsr
	or eax, 1 << 8
	wrmsr
	
	mov eax, cr0
	or eax, 1 << 31
	mov cr0, eax

	lgdt [gdt_64b_desc]
	jmp codeseg_64b:upmode_64b_setup

	[bits 64]
	
upmode_64b_setup:
	cli
	
	mov ax, dataseg_64b
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	jmp boot_64b
