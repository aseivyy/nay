#include <memory/memcpy.h>
#include <types.h>

void* memcpy(void *destinationptr, void *sourceptr, qword_t size) {
	byte_t* destination = (byte_t*) destinationptr;
	byte_t* source = (byte_t*) sourceptr;
	for (qword_t i = 0; i < size; i++) {
		destination[i] = source[i];
	}
	return destinationptr;
}
