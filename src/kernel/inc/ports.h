#ifndef __PORTS
#define __PORTS

#include <types.h>

#define PORT_TEXTMVGA_CONTROL 0x3d4
#define PORT_TEXTMVGA_DATA 0x3d5

void port_write(byte_t data, dword_t port);
byte_t port_read(dword_t port);

#endif
