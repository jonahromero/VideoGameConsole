
#include "io.h"
#include <stdbool.h>

void main() {
  struct controller_input controller1, controller2;
  while (true) {
    get_controller_input(&controller1, 1);
    get_controller_input(&controller2, 2);
    if (controller2.buttons & BUTTON_UP) {
      // do something on up
    }
  }
}
