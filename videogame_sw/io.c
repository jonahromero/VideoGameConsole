
#include "mmio.h"
#include "io.h"


int get_controller_input(struct controller_input* input, int controller_id) {
    volatile uint8_t* keypad;
    switch (controller_id) {
        case 1: keypad = (uint8_t*)MMIO_ADDR_CONTROLLER1; break;
        case 2: keypad = (uint8_t*)MMIO_ADDR_CONTROLLER2; break;
        default: return -1;
    };
    input->buttons = *keypad;
    return 0;
}
