#include <types.h>
#include <ports.h>
#include <drivers/video/textm_vga.h>

int kmain() {
	textmvga_cursor_enable(14, 15);
	textmvga_clear(TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_BLACK);
	byte_t msg[] = "Welcone to nay have a great day";
	textmvga_writestring(msg, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_BLACK);
	
	return 0;
}

