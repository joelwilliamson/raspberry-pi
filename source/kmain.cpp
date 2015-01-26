#include "sleep.hpp"
#include "light_control.hpp"

#include <stddef.h>
#include <stdint.h>


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
