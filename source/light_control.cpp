#include "light_control.hpp"

#include "memory.hpp"

#define GPIO_addr 0x20200000

void activate_light() {
  *(uint32_t*)(GPIO_addr+4) = 1<<18; // Set pin 16 to output
}

void light_on() {
  *(uint32_t*)(GPIO_addr+40) = 1<<16; // Trigger GPFSET0 on pin 16
}

void light_off() {
  *(uint32_t*)(GPIO_addr+28) = 1<<16; // Trigger GPFCLR0 on pin 16
}
