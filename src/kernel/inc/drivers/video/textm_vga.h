#ifndef __DRIVERS_VIDEO_TEXTMVGA
#define __DRIVERS_VIDEO_TEXTMVGA

#include <types.h>

/* VGA details */
#define TEXTMVGA_STARTADDR 0xB8000
#define TEXTMVGA_WIDTH 80
#define TEXTMVGA_HEIGHT 25
#define TEXTMVGA_CELLS 2000

/* VGA LETTERS */
/* Use them in "foreground" and "background" function arguments */
#define TEXTMVGA_COLOR_BLACK 0
#define TEXTMVGA_COLOR_BLUE 1
#define TEXTMVGA_COLOR_GREEN 2
#define TEXTMVGA_COLOR_CYAN 3
#define TEXTMVGA_COLOR_RED 4
#define TEXTMVGA_COLOR_MAGENTA 5
#define TEXTMVGA_COLOR_BROWN 6
#define TEXTMVGA_COLOR_GRAY 8
#define TEXTMVGA_COLOR_YELLOW 14
#define TEXTMVGA_COLOR_WHITE 15

#define TEXTMVGA_COLOR_LGRAY 7
#define TEXTMVGA_COLOR_LBLUE 9
#define TEXTMVGA_COLOR_LGREEN 10
#define TEXTMVGA_COLOR_LCYAN 11
#define TEXTMVGA_COLOR_LRED 12
#define TEXTMVGA_COLOR_LMAGENTA 13

/* STRUCTS */
typedef struct __attribute__((packed)) {
	byte_t character;
	byte_t appearance; /* bits 0-3 foreground, 4-6 backgroud, set 7 for blinking */
} textmvga_char;

/* FUNCTION DEFINITIONS */
void textmvga_cursor_enable(byte_t lowscanline, byte_t highscanline);
void textmvga_cursor_disable();

void textmvga_clear(byte_t foreground, byte_t background);
void textmvga_writestring(byte_t *string, byte_t foreground, byte_t background);
void textmvga_writehex(qword_t hex, byte_t foreground, byte_t background);

#endif
