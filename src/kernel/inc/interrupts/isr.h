#ifndef __INTERRUPTS_ISR
#define __INTERRUPTS_ISR

#include <types.h>
#include <registers.h>


char *isr_messages[] = {
	"Division by 0 (0x00)",
	"Debug (0x01)",
       	"NMI (0x02)",
	"Breakpoint (0x03)",
	"Overflow (0x04)",
	"Bound range out (0x05)"
	"Bad opcode (0x06)",
	"Bad device (0x07)",
	"Double Fault (0x08)",
	"None (0x09)",
	"Bad TSS (0x0a)",
	"Bad segment (0x0b)",
	"Bad SS (0x0c)",
	"GPF (0x0d)",
	"Page Fault (0x0e)",
	"None (0x0f)",
	"Bad FPU (0x10)",
	"Aligment check (0x11)",
	"Machine check (0x12)",
	"Bad SIMD (0x13)",
	"Reserved int (0x14)",
	"Reserved int (0x15)",
	"Reserved int (0x16)",
	"Reserved int (0x17)",
	"Reserved int (0x18)",
	"Reserved int (0x19)",
	"Reserved int (0x1a)",
	"Reserved int (0x1b)",
	"Reserved int (0x1c)",
	"Reserved int (0x1d)",
	"Reserved int (0x1e)",
	"Reserved int (0x1f)"
};

/* FUNCTION DEFINITIONS */
void __attribute__((sysv_abi)) isr_general(qword_t int_id, qword_t int_err, registers_int_t *registers);
	
#endif
