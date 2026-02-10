#include <interrupts/pic.h>
#include <types.h>
#include <ports.h>

void pic_remap() {
	port_write(PIC_INIT | PIC_ENVINFO_P, PIC_MASTER_COMMAND);
	port_write(PIC_INIT | PIC_ENVINFO_P, PIC_SLAVE_COMMAND);

	port_write(0x20, PIC_MASTER_DATA);
	port_write(0x28, PIC_SLAVE_DATA);

	port_write(PIC_SLAVEATIRQ_2, PIC_MASTER_DATA);
	port_write(PIC_BEINGSLAVE, PIC_SLAVE_DATA);

	port_write(PIC_8086MODE, PIC_MASTER_DATA);
	port_write(PIC_8086MODE, PIC_SLAVE_DATA);

	port_write(0, PIC_MASTER_DATA);
	port_write(0, PIC_SLAVE_DATA);
}
