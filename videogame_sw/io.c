
#include "mmio.h"
#include "io.h"

controller_t get_controller_input() {
    controller_t result;
    result.xtilt   = *(MMIO__CTLR_BASE_ADDR + MMIO__CTLR_JOYSTICK_X_OFFSET);
    result.ytilt   = *(MMIO__CTLR_BASE_ADDR + MMIO__CTLR_JOYSTICK_Y_OFFSET);
    result.buttons = *(MMIO__CTLR_BASE_ADDR + MMIO__CTLR_BUTTONS_OFFSET);
    return result;
}

void draw_pixel(uint16_t rgb, pos_t pos) {
    volatile uint16_t* fb_addr = (void*)MMIO__FRAME_BUFFER_START_ADDR;
    fb_addr += pos.x + pos.y * MMIO__FRAME_BUFFER_WIDTH;
    *fb_addr = rgb;
}

void swap_frame_buffer() {
    *MMIO__FRAME_BUFFER_SWAP_ADDR = 1;
}
