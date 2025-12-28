	[bits 16]

video_setup_16b:
	push ax
	push bx
	push cx
	push es
	
	mov [VIDEO_SETUP_16B_WIDTH], ax
	mov [VIDEO_SETUP_16B_HEIGHT], bx
	mov [VIDEO_SETUP_16B_MODE], cl



VIDEO_SETUP_16B_WIDTH:			dw 0
VIDEO_SETUP_16B_HEIGHT:			dw 0
VIDEO_SETUP_16B_MODE:			dw 0
VIDEO_SETUP_16B_SEGMENT:		dw 0
VIDEO_SETUP_16B_OFFSET:			dw 0
VIDEO_SETUP_16B_BPP:			db 0
	
