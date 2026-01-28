CC := clang
LD = ld.lld
ASM = nasm

INC_FLAG := -Iinc/
SRC := $(shell find . -type f -name "*.c")
SRC_ASM := $(shell find . -type f -name "*.asm")

OBJ := ${SRC_ASM:.asm=.o} ${SRC:.c=.o}

CCFLAGS := -c -ffreestanding -target x86_64-none-elf -masm=intel
LDFLAGS := kernel.ld
LDFLAGS_BIN := ${LDFLAGS} --oformat binary
ASMFLAGS = -f elf64

all: kernel

kernel: ${OBJ}
	${LD} -o $@ ${LDFLAGS_BIN} $^

%.o: %.c
	${CC} ${CCFLAGS} ${INC_FLAG} -o $@ $^

%.o: %.asm
	${ASM} $< ${ASMFLAGS} -o $@

