;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 												;;
;;	Function to read sectors from the disk							;;
;;		In:										;;
;;			al: 	Number of sectors to read (1 - 128)				;;
;; 			ch: 	Cylinder number (0 - 1023)					;;
;; 			cl: 	First sector number to read					;;
;;			dh: 	Head number (0 - 15)						;;
;; 			dl: 	Drive type (Set on boot)					;;
;; 			es:bx:	Pointer in memory where things from the disk should be placed	;;
;; 		Out:										;;
;;			Sector(s) placed in memory on success					;;
;; 												;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	[bits 16]

disk_16b:
	push ax
	push bx
	push cx
	push dx
	push di
	push si
	
	mov ah, 0x02
	mov di, 0		; di is used for destination generally but here for attempts
	mov si, ax		; si is used for source generally but here for sectors attempted
	
disk_16b_loop:
	cmp di, 3
	jge disk_16b_fatal
	
	int 0x13

	jc disk_16b_fail

	mov bx, si
	cmp al, bl
	jne disk_16b_fail

	cmp ah, 0x00
	jne disk_16b_fail

disk_16b_end:
	pop si
	pop di
	pop dx
	pop cx
	pop bx
	pop ax

	ret

disk_16b_fail:
	inc di
	jmp disk_16b_loop

disk_16b_fatal:
	mov bx, 0xDFFF
	call print_textm_hex_16b
	jmp $

	
