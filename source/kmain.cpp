#include "sleep.hpp"

#include <stddef.h>
#include <stdint.h>

#define GPIO_addr 0x20200000

void write_mem(uint32_t addr, uint32_t data) {
  asm volatile (R"(
str %[data],[%[addr]]
)" : : [data] "r" (data), [addr] "r" (addr) : "memory");
}

void activate_light() {
  write_mem(GPIO_addr+4,1<<18); // Set pin 16 to output
}

void light_on() {
  write_mem(GPIO_addr+40,1<<16); // Trigger GPFSET0 on pin 16
}

void light_off() {
   write_mem(GPIO_addr+28,1<<16); // Trigger GPFCLR0 on pin 16
}


extern "C" int kmain() __attribute__((noreturn));

extern "C"
int kmain() {
  activate_light();
  do {
    light_on();
    sleep(1);
    light_off();
    sleep(1);
  } while (true);
}
