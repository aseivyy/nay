	[extern isr_general]

SREGISTER:	equ 0x78

%macro PUSHALL 0
	push rdi
	push rsi
	push rdx
	push rcx
	push rax
	push r8
	push r9
	push r10
	push r11
	push rbx
	push rbp
	push r12
	push r13
	push r14
	push r15
%endmacro

%macro POPALL 0
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
	pop rbx
	pop r11
	pop r10
	pop r9
	pop r8
	pop rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
%endmacro

%macro SAVE_AND_CONNECT 1
	PUSHALL
	
	mov rdx, rsp
	mov rdi, [rsp + SREGISTER]
	mov rsi, [rsp + SREGISTER + 64]
	
	call %1
	
	POPALL
%endmacro

%macro ISR_HASINTERR_P 1
	global isr_%1

isr_%1:
	cli
	push qword %1

	SAVE_AND_CONNECT isr_general

	add rsp, 0x10
	sti

	jmp $
%endmacro

%macro ISR_HASINTERR_N 1
	global isr_%1

isr_%1:
	cli
	push qword 0
	push qword %1
	
	SAVE_AND_CONNECT isr_general
	
	add rsp, 0x10
	sti
	
	jmp $
%endmacro

%macro ISR_PCI 1
	global isr_%1

isr_%1:
	cli
	push qword 0
	push qword %1
	
	SAVE_AND_CONNECT isr_general
	
	add rsp, 0x10
	sti
	
	iretq
%endmacro

	
	ISR_HASINTERR_N 0
	ISR_HASINTERR_N 1
	ISR_HASINTERR_N 2
	ISR_HASINTERR_N 3
	ISR_HASINTERR_N 4
	ISR_HASINTERR_N 5
	ISR_HASINTERR_N 6
	ISR_HASINTERR_N 7
	ISR_HASINTERR_P 8
	ISR_HASINTERR_N 9
	ISR_HASINTERR_P 10
	ISR_HASINTERR_P 11
	ISR_HASINTERR_P 12
	ISR_HASINTERR_P 13
	ISR_HASINTERR_P 14
	ISR_HASINTERR_N 15
	ISR_HASINTERR_N 16
	ISR_HASINTERR_P 17
	ISR_HASINTERR_N 18
	ISR_HASINTERR_N 19
	ISR_HASINTERR_N 20
	ISR_HASINTERR_P 21
	ISR_HASINTERR_N 22
	ISR_HASINTERR_N 23
	ISR_HASINTERR_N 24
	ISR_HASINTERR_N 25
	ISR_HASINTERR_N 26
	ISR_HASINTERR_N 27
	ISR_HASINTERR_N 28
	ISR_HASINTERR_N 29
	ISR_HASINTERR_N 30
	ISR_HASINTERR_N 31

	ISR_PCI 32
	ISR_PCI 33
	ISR_PCI 34
	ISR_PCI 35
	ISR_PCI 36
	ISR_PCI 37
	ISR_PCI 38
	ISR_PCI 39
	ISR_PCI 40
	ISR_PCI 41
	ISR_PCI 42
	ISR_PCI 43
	ISR_PCI 44
	ISR_PCI 45
	ISR_PCI 46
	ISR_PCI 47

