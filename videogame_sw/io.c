
#include "mmio.h"
#include "io.h"

void update_controller(controller_t * controller) {
    controller->xtilt   = *(MMIO__CTLR_BASE_ADDR + MMIO__CTLR_JOYSTICK_X_OFFSET);
    controller->ytilt   = *(MMIO__CTLR_BASE_ADDR + MMIO__CTLR_JOYSTICK_Y_OFFSET);
    button_mask_t new_button_state = *(MMIO__CTLR_BASE_ADDR + MMIO__CTLR_BUTTONS_OFFSET);
    controller->buttons_pressed = ~controller->_prev_button_state & new_button_state;
    controller->_prev_button_state = new_button_state;
}

// WE HAVE FULL 1280x720 access
void draw_pixel(uint16_t rgb, pos_t pos) {
    volatile uint16_t* fb_addr = (void*)MMIO__FRAME_BUFFER_START_ADDR;
    fb_addr += pos.x + pos.y * MMIO__FRAME_BUFFER_WIDTH;
    *fb_addr = rgb;
}

void swap_frame_buffer() {
    *MMIO__FRAME_BUFFER_SWAP_ADDR = 1;
}
