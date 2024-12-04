
#include "common.h"

#define TILT_IDLE 8

// controller specifics
enum button_id_enum_t {
	BUTTON_A 	 = 1 << 0,
	BUTTON_B 	 = 1 << 1,
	BUTTON_X 	 = 1 << 2,
	BUTTON_Y 	 = 1 << 3,
	BUTTON_LB 	 = 1 << 4,
	BUTTON_RB 	 = 1 << 5,
	BUTTON_BACK  = 1 << 6,
	BUTTON_START = 1 << 7,
};

typedef uint8_t button_id;

typedef struct {
	button_id buttons;
	uint8_t xtilt, ytilt;
} controller_t;

controller_t get_controller_input();
void draw_pixel(uint16_t rgb, pos_t pos);
void swap_frame_buffer();

