#include <interrupts/isr.h>
#include <types.h>
#include <registers.h>
#include <drivers/video/textm_vga.h>

void __attribute__((sysv_abi)) isr_general(qword_t int_id, qword_t int_err, registers_int_t *registers) {
	if (int_id > 31) {
		return;
	}

	byte_t general_message[] = "Unhandled interrupt was made. Interrupt:\r\n"; 
	char *message = isr_messages[int_id];
	textmvga_clear(TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring(general_message, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring((byte_t*) message, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_cursor_disable();
}
