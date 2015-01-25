#include "sleep.hpp"

static unsigned int freq = 700;

unsigned int usleep(unsigned int useconds) {
  unsigned int target{useconds};
  // To sleep for 1 microsecond at 700MHz, we need to delay for 700 instructions
  while (useconds--) {
    asm volatile (R"(
usleep_loop:
sub %0, %0, #4
cmp %0, #0
ble usleep_loop
)" : : "r" (useconds*freq));
  }
  return target;
}

unsigned int sleep(unsigned int seconds) {
  return usleep(seconds*1000000);
}
