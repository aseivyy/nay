	[bits 64]
	[extern kmain]

	global _ksetup

	section .setup

_ksetup:
	call kmain
	jmp $
