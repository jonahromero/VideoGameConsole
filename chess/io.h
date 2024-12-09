
#include "common.h"
// This defines a coherent interface for interacting with all/any memory mapped IO with the console system

// MMIO: Controller
#define TILT_IDLE 8
enum {
	BUTTON_START = 1 << 0,
	BUTTON_RB	 = 1 << 1,
	BUTTON_LB	 = 1 << 2,
	BUTTON_Y 	 = 1 << 3,
	BUTTON_X  	 = 1 << 4,
	BUTTON_B 	 = 1 << 5,
	BUTTON_A 	 = 1 << 6,
	BUTTON_SELET = 1 << 7,
};

typedef uint8_t button_mask_t;

typedef struct {
	button_mask_t _prev_button_state;
	button_mask_t buttons_pressed, buttons_held;
	uint8_t xtilt, ytilt;
} controller_t;

void update_controller(controller_t * controller);

// MMIO: Frame buffer
#define RGB_TO_565(r, g, b) ((r<<11) | ((g & ((1<<6)-1))<<5) | (b&((1<<5)-1)))
void draw_pixel(uint16_t rgb, pos_t pos);
void swap_frame_buffer();

