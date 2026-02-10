#include <interrupts/interrupts.h>
#include <interrupts/idt.h>
#include <types.h>

void interrupts_enable() {
	// reserved
	idt_setentry(0, (qword_t) isr_0);
	idt_setentry(1, (qword_t) isr_1);
	idt_setentry(2, (qword_t) isr_2);
	idt_setentry(3, (qword_t) isr_3);
	idt_setentry(4, (qword_t) isr_4);
	idt_setentry(5, (qword_t) isr_5);
	idt_setentry(6, (qword_t) isr_6);
	idt_setentry(7, (qword_t) isr_7);
	idt_setentry(8, (qword_t) isr_8);
	idt_setentry(9, (qword_t) isr_9);
	idt_setentry(10, (qword_t) isr_10);
	idt_setentry(11, (qword_t) isr_11);
	idt_setentry(12, (qword_t) isr_12);
	idt_setentry(13, (qword_t) isr_13);
	idt_setentry(14, (qword_t) isr_14);
	idt_setentry(15, (qword_t) isr_15);
	idt_setentry(16, (qword_t) isr_16);
	idt_setentry(17, (qword_t) isr_17);
	idt_setentry(18, (qword_t) isr_18);
	idt_setentry(19, (qword_t) isr_19);
	idt_setentry(20, (qword_t) isr_20);
	idt_setentry(21, (qword_t) isr_21);
	idt_setentry(22, (qword_t) isr_22);
	idt_setentry(23, (qword_t) isr_23);
	idt_setentry(24, (qword_t) isr_24);
	idt_setentry(25, (qword_t) isr_25);
	idt_setentry(26, (qword_t) isr_26);
	idt_setentry(27, (qword_t) isr_27);
	idt_setentry(28, (qword_t) isr_28);
	idt_setentry(29, (qword_t) isr_29);
	idt_setentry(30, (qword_t) isr_30);
	idt_setentry(31, (qword_t) isr_31);

	// pic
	idt_setentry(32, (qword_t) isr_32);
	idt_setentry(33, (qword_t) isr_33);
	idt_setentry(34, (qword_t) isr_34);
	idt_setentry(35, (qword_t) isr_35);
	idt_setentry(36, (qword_t) isr_36);
	idt_setentry(37, (qword_t) isr_37);
	idt_setentry(38, (qword_t) isr_38);
	idt_setentry(39, (qword_t) isr_39);
	idt_setentry(40, (qword_t) isr_40);
	idt_setentry(41, (qword_t) isr_41);
	idt_setentry(42, (qword_t) isr_42);
	idt_setentry(43, (qword_t) isr_43);
	idt_setentry(44, (qword_t) isr_44);
	idt_setentry(45, (qword_t) isr_45);
	idt_setentry(46, (qword_t) isr_46);
	idt_setentry(47, (qword_t) isr_47);

	idt_load();

	__asm__ volatile ("sti");
}
