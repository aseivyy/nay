;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 												;;
;;	Function to print the memory table							;;
;;		In:										;;
;;			si: 	Location of the memory table (Last entry must be zeros)		;;
;; 		Out:										;;
;;			Cleared screen, memory map printed					;;
;; 												;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	[bits 16]

print_textm_memtable_16b:
	push eax
	push ebx
	push ecx
	push edx
	push si

	mov ah, 0x06
	xor al, al
	mov bh, 0x07
	xor cx, cx
	mov dh, 24
	mov dl, 79

	int 0x10

	mov ah, 0x02
	xor bx, bx
	xor dx, dx

	int 0x10

	mov bx, MSG_MEMTABLE
	call print_textm_16b

	mov ah, 0x0e

print_textm_memtable_16b_loop:	
	mov ecx, dword[si + 8]
	or ecx, dword[si + 12]
	jz print_textm_memtable_16b_end

	mov ebx, dword[si]
	mov edx, dword[si + 4]
	call print_textm_fullhex_16b

	mov ebx, dword[si + 8]
	mov edx, dword[si + 12]
	call print_textm_fullhex_16b

	mov ebx, dword[si + 16]
	call print_textm_hex_16b

	call print_textm_nl_16b

	add si, 24

	jmp print_textm_memtable_16b_loop


print_textm_memtable_16b_end:
	pop si
	pop edx
	pop ecx
	pop ebx
	pop eax

	ret

MSG_MEMTABLE:	db `Memory table: \r\n`, 0
