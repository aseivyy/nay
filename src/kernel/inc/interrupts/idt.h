#ifndef __INTERRUPTS_IDT
#define __INTERRUPTS_IDT

#include <types.h>

typedef struct {
	word_t isr_low;
	word_t kernel_cs;
	byte_t ist;
	byte_t attr;
	word_t isr_middle;
	dword_t isr_high;
	dword_t reserved;
} __attribute__((packed)) idt_entry_t;

typedef struct {
	word_t limit;
	qword_t base;
} __attribute__((packed)) idt_register_t;

extern idt_entry_t idt_entry[256];
extern idt_register_t idt_register;

void idt_load();
void idt_setentry(byte_t int_id, qword_t isr);

#endif
