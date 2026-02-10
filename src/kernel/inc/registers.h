#ifndef __REGISTERS
#define __REGISTERS

typedef struct {
	qword_t r15, r14, r13, r12, rbp, rbx, r11, r10, r9, r8, rax, rcx, rdx, rsi, rdi, int_id, int_err, rip, cs, eflags, rsp, ss;
} __attribute__((packed)) registers_int_t;

#endif
