#ifndef __INTERRUPTS_PIC
#define __INTERRUPTS_PIC

/* PIC DETAILS */
#define PIC_MASTER_COMMAND 0x20
#define PIC_MASTER_DATA 0x21
#define PIC_SLAVE_COMMAND 0xA0
#define PIC_SLAVE_DATA 0xA1

#define PIC_EOI 0x20
#define PIC_INIT 0x10
#define PIC_ENVINFO_P 0x1
#define PIC_SLAVEATIRQ_2 1 << 2
#define PIC_BEINGSLAVE 1 << 1
#define PIC_8086MODE 0x1

/* FUNCTION DEFINITIONS */
void pic_remap();

#endif
