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
	byte_t padding[] = "     ";
	byte_t nl[] = "\r\n";
	textmvga_clear(TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring(general_message, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring((byte_t*) message, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);

	for (byte_t i = 0; i < 3; i++) {
		textmvga_writestring(nl, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	}
		
	textmvga_writestring((byte_t*) "RAX: ", TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writehex(registers->rax, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring(padding, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);

	textmvga_writestring((byte_t*) "RBX: ", TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writehex(registers->rbx, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring(padding, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);

	textmvga_writestring((byte_t*) "RCX: ", TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writehex(registers->rcx, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring(nl, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);

	textmvga_writestring((byte_t*) "RDX: ", TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writehex(registers->rdx, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring(padding, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);

	textmvga_writestring((byte_t*) "RIP: ", TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writehex(registers->rip, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring(padding, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);

	textmvga_writestring((byte_t*) "RSP: ", TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writehex(registers->rdx, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring(nl, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);

	textmvga_writestring((byte_t*) " SS: ", TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writehex(registers->ss, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring(padding, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);

	textmvga_writestring((byte_t*) "RBP: ", TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writehex(registers->rbp, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring(nl, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);

	textmvga_writestring((byte_t*) "ERR: ", TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writehex(registers->int_err, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	textmvga_writestring(padding, TEXTMVGA_COLOR_WHITE, TEXTMVGA_COLOR_RED);
	
	textmvga_cursor_disable();
}
