#pragma once

#include <stdint.h>

void write_mem(uint32_t* addr, uint32_t data);

extern "C"
void memory_barrier();
