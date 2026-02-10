#include <interrupts/idt.h>

idt_entry_t idt_entry[256];
idt_register_t idt_register;

void idt_load() {
	idt_register.base = (qword_t) &idt_entry[0];
	idt_register.limit = (dword_t) sizeof(idt_entry_t) * 256 - 1;

	__asm__ volatile ("lidt [%0]" : : "r" (&idt_register));
}

void idt_setentry(byte_t int_id, qword_t isr) {
	idt_entry[int_id].isr_low = (word_t) (isr & 0xffff);
	idt_entry[int_id].kernel_cs = 0x08;
	idt_entry[int_id].ist = 0;
	idt_entry[int_id].attr = 0b10001110;
	idt_entry[int_id].isr_middle = (word_t) ((isr >> 16) & 0xffff);
	idt_entry[int_id].isr_high = (dword_t) (isr >> 32);
	idt_entry[int_id].reserved = 0;
}
