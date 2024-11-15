
#include <stdint.h>

// controller specifics
enum button_id : uint8_t {
	BUTTON_UP = 1,
	BUTTON_DOWN = 2,
	BUTTON_RIGHT = 4,
	BUTTON_LEFT = 8
};

struct controller_input {
	enum button_id buttons;
	uint8_t xtilt, ytilt;
};

int get_controller_input(struct controller_input* input, int controller_id);

// frame buffer
void swap_buffer();

