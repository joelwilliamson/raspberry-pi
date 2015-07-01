#include "memory.hpp"

void write_mem(uint32_t* addr, uint32_t data) {
  *addr = data;
}

void memory_barrier() {
  // See B6.6.5
  asm volatile(R"(
mcr p15,0,r5,c7,c10,#5
)" : : : "r5");
}
	  
