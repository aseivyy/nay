#include <drivers/video/textm_vga.h>
#include <types.h>
#include <ports.h>
#include <memory/memcpy.h>


/* Local */

volatile textmvga_char *vga_area = (textmvga_char*) TEXTMVGA_STARTADDR;

word_t textmvga_cursor_locate() {
	word_t pos = 0;
	port_write(0x0f, PORT_TEXTMVGA_CONTROL);
	pos |= port_read(PORT_TEXTMVGA_DATA);
	port_write(0x0e, PORT_TEXTMVGA_CONTROL);
	pos |= ((word_t) port_read(PORT_TEXTMVGA_DATA)) << 8;
	return pos;
}

void textmvga_cursor_relocate(dword_t x, dword_t y, word_t pos) {
	if (pos == '\0') {
		pos = (y * TEXTMVGA_WIDTH) + x;
	}

	port_write(0x0f, PORT_TEXTMVGA_CONTROL);
	port_write((byte_t) (pos & 0xff), PORT_TEXTMVGA_DATA);
	port_write(0x0e, PORT_TEXTMVGA_CONTROL);
	port_write((byte_t) ((pos >> 8) & 0xFF), PORT_TEXTMVGA_DATA);
}

byte_t textmvga_genappearance(byte_t foreground, byte_t background) {
	byte_t appearance = (background << 4) | (foreground & 0x0f);
	return appearance;
}

word_t textmvga_scroll() {
	for (byte_t i = 0; i < TEXTMVGA_HEIGHT - 1; i++) {
		for (byte_t j = 0; j < TEXTMVGA_WIDTH; j++) {
			vga_area[(i * TEXTMVGA_WIDTH) + j] = vga_area[((i + 1) * TEXTMVGA_WIDTH) + j];
		}
	}

	for (byte_t i = 0; i < TEXTMVGA_WIDTH; i++) {
		textmvga_char linebefore = vga_area[0];
		vga_area[((TEXTMVGA_HEIGHT - 1) * TEXTMVGA_WIDTH) + i].character = ' ';
		vga_area[((TEXTMVGA_HEIGHT - 1) * TEXTMVGA_WIDTH) + i].appearance = linebefore.appearance;
	}

	word_t currlocation = textmvga_cursor_locate();
	word_t newpos = currlocation - TEXTMVGA_WIDTH - 1;
	textmvga_cursor_relocate(0, 0, newpos);
	return newpos;
}

void textmvga_writechar(byte_t character, byte_t appearance, word_t pos, word_t *counterlocationptr) {
	if (pos >= (TEXTMVGA_WIDTH) * (TEXTMVGA_HEIGHT)) {
		textmvga_scroll();
		counterlocationptr[0] -= TEXTMVGA_WIDTH;
	}

	if (character == '\r') {
		counterlocationptr[0] = ((*counterlocationptr / TEXTMVGA_WIDTH) * TEXTMVGA_WIDTH) - 1;
	} else if (character == '\n') {
		if (*counterlocationptr >= TEXTMVGA_WIDTH * (TEXTMVGA_HEIGHT - 1)) {
			textmvga_scroll();
			counterlocationptr[0] = (((TEXTMVGA_HEIGHT - 1) * TEXTMVGA_WIDTH)) - 1;
		} else {
			*counterlocationptr += TEXTMVGA_WIDTH - 1;
		}
	} else {
		/* Fixed the bug where it would not use the background appearance, i probably copied and pasted the code from the textmvga_scrool(), but keeping the old thing commented in case me fixing will cause another bug. Appearance was linebefore.appearance. */
		/* textmvga_char linebefore = vga_area[(*counterlocationptr / TEXTMVGA_WIDTH) * TEXTMVGA_HEIGHT]; */
		vga_area[*counterlocationptr].character = character;
		vga_area[*counterlocationptr].appearance = appearance;
	}
}

/* Global */

void textmvga_cursor_enable(byte_t lowscanline, byte_t highscanline) {
	port_write(0x09, PORT_TEXTMVGA_CONTROL);
	port_write(0x0f, PORT_TEXTMVGA_DATA);
	
	port_write(0x0a, PORT_TEXTMVGA_CONTROL);
	port_write(((port_read(PORT_TEXTMVGA_DATA) & 0xc0) | lowscanline), PORT_TEXTMVGA_DATA);

	port_write(0x0b, PORT_TEXTMVGA_CONTROL);
	port_write(((port_read(PORT_TEXTMVGA_DATA) & 0xe0) | highscanline), PORT_TEXTMVGA_DATA);
}

void textmvga_cursor_disable() {
	port_write(0x0a, PORT_TEXTMVGA_CONTROL);
	port_write(0x20, PORT_TEXTMVGA_DATA);
}

void textmvga_clear(byte_t foreground, byte_t background) {
	byte_t appearance = textmvga_genappearance(foreground, background);
	const byte_t empty = ' ';
	
	for (word_t i = 0; i < TEXTMVGA_CELLS; i++) {
		vga_area[i].character = empty;
		vga_area[i].appearance = appearance;
	}

	textmvga_cursor_relocate(0, 0, '\0');
}

void textmvga_writestring(byte_t *string, byte_t foreground, byte_t background) {
	byte_t appearance = textmvga_genappearance(foreground, background);
	word_t i = textmvga_cursor_locate();
	word_t x = 0;
	word_t *counterlocationptr = &i;
	while (string[x] != '\0') {
		textmvga_writechar(string[x], appearance, i, counterlocationptr);
		i++;
		x++;
	}
	textmvga_cursor_relocate(0, 0, i);
}

void textmvga_writehex(qword_t hex, byte_t foreground, byte_t background) {
	byte_t print[19];
	print[0] = '0';
	print[1] = 'x';
	print[18] = 0;
	
	for (byte_t i = 2; i <= 17; i++) {
		byte_t current = hex >> 60;
		if (current > 9) {
			current -= 10;
			print[i] = (byte_t) ('a' + current);
		} else {
			print[i] = (byte_t) ('0' + current);
		}

		hex = hex << 4;
	}
	textmvga_writestring(print, foreground, background);
}
