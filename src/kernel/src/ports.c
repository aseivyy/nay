#include <ports.h>
#include <types.h>

void port_write(byte_t data, dword_t port) {
	__asm__ volatile ("out dx, al" : : "a" (data), "d" (port));
	return;
}

byte_t port_read(dword_t port) {
	byte_t readen;
	__asm__ volatile ("in al, dx" : "=a" (readen) : "d" (port));
	return readen;
}
