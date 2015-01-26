#include "sleep.hpp"

static unsigned int freq = 13; //This number is experimentally derived to give the number of loop iterations per 1μs

extern "C"
unsigned int usleep(unsigned int useconds) {
  // This is just a busy-waiting loop to implement a simple delay.
  // It is accurate to within 10% of the requested time.
  unsigned int target{useconds};
  asm volatile (R"(
usleep_loop:
sub %0, %0, #1
cmp %0, #0
bne usleep_loop
)" : : "r" (useconds*freq));
  return target;
}

extern "C"
unsigned int sleep(unsigned int seconds) {
  return usleep(seconds*1000000);
}
