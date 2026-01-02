;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 									;;
;;	Function to enable VESA mode    				;;
;;		In:							;;
;;			ax: 	Width of demanded mode			;;
;; 			bx: 	Height of demanded mode			;;
;; 			cl: 	BPP of demanded mode			;;
;; 		Out:							;;
;;			Enabled VESA mode and maybe cleared screen	;;
;; 									;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	[bits 16]

video_setup_16b:
	push ax			; general purpose
	push bx
	push cx
	push dx
	push di			; kind of general purpose
	push si
	push fs			; segment register
	push es			; apparently it destroys the register
	
	mov [VIDEO_SETUP_16B_WIDTH], ax
	mov [VIDEO_SETUP_16B_HEIGHT], bx
	mov [VIDEO_SETUP_16B_BPP], cl

	mov ax, 0x4f00
	mov di, VESA_RETURN
	int 0x10
	pop es
	cmp ax, 0x004f
	jne video_setup_16b_error_vbiosinfo

	mov ax, word[VESARETURN_MODES_OFFSET]
	mov [VIDEO_SETUP_16B_OFFSET], ax
	mov ax, word[VESARETURN_MODES_SEGMENT]
	mov [VIDEO_SETUP_16B_SEGMENT], ax

video_setup_16b_trymode:	
	mov ax, [VIDEO_SETUP_16B_SEGMENT]
	mov fs, ax
	mov si, [VIDEO_SETUP_16B_OFFSET]

	mov dx, [fs:si]
	add si, 2
	mov [VIDEO_SETUP_16B_OFFSET], si
	mov [VIDEO_SETUP_16B_MODE], dx
	pop fs

	cmp [VIDEO_SETUP_16B_MODE], 0xffff
	je video_setup_16b_error_nomodes

	push es

	mov ax, 0x4f01
	mov cx, [VIDEO_SETUP_16B_MODE]
	mov di, VESA_MODE_RETURN
	int 0x10

	pop es
	push es

	cmp ax, 0x004f
	jne video_setup_16b_error_modeinfo

	mov ax, [VIDEO_SETUP_16B_WIDTH]
	cmp ax, [VESA_MODE_RETURN_WIDTH]
	jne video_setup_16b_trymode

	mov ax, [VIDEO_SETUP_16B_HEIGHT]
	cmp ax, [VESA_MODE_RETURN_HEIGHT]
	jne video_setup_16b_trymode

	mov al, [VIDEO_SETUP_16B_BPP]
	cmp al, [VESA_MODE_RETURN_BPP]
	jne video_setup_16b_trymode

video_setup_16b_modeexportvars:
	mov ax, [VIDEO_SETUP_16B_WIDTH]
	mov word[VESASCREEN_WIDTH], ax
	mov ax, [VIDEO_SETUP_16B_HEIGHT]
	mov word[VESASCREEN_HEIGHT], ax
	mov eax, [VESA_MODE_RETURN_LFBADDRESS]
	mov dword[VESASCREEN_FRAMEBUFFER], eax
	mov ax, [VESA_MODE_RETURN_BYTESPERSCANLINE]
	mov word[VESASCREEN_BYTESPERSCANLINE], ax

video_setup_16b_setmode:
	mov ax, 0x4f02
	mov bx, [VIDEO_SETUP_16B_MODE]
	or bx, 0x4000
	xor di, di
	int 0x10
	pop es

	cmp ax, 0x004f
	jne video_setup_16b_error_setmode

video_setup_16b_end:
	pop si
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	
	ret

video_setup_16b_error_vbiosinfo:
	mov bx, 0x11FF
	call print_textm_hex_16b
	jmp $

video_setup_16b_error_nomodes:
	mov bx, 0x1FFF
	call print_textm_hex_16b
	jmp $

video_setup_16b_error_modeinfo:
	mov bx, 0x1AFF
	call print_textm_hex_16b
	jmp $

video_setup_16b_error_setmode:
	mov bx, 0x123F
	call print_textm_hex_16b
	jmp $
	

VIDEO_SETUP_16B_WIDTH:			dw 0
VIDEO_SETUP_16B_HEIGHT:			dw 0
VIDEO_SETUP_16B_MODE:			dw 0
VIDEO_SETUP_16B_SEGMENT:		dw 0
VIDEO_SETUP_16B_OFFSET:			dw 0
VIDEO_SETUP_16B_BPP:			db 0
	
