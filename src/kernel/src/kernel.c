#include <types.h>
#include <ports.h>
#include <drivers/video/textm_vga.h>
#include <interrupts/interrupts.h>
#include <interrupts/pic.h>

int kmain() {
	pic_remap();
	interrupts_enable();
	
	//__asm__ volatile ("int 0x01");

	textmvga_cursor_enable(14, 15);
	textmvga_clear(TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_BLACK);
	byte_t msg[] = "Welcome to nay have a great day";
	textmvga_writestring(msg, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_BLACK);
	return 0;
}

