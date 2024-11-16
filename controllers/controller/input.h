
#ifndef INPUT_H
#define INPUT_H

#define NBUTTONS 8

enum button_type {
  BUTTON_A, BUTTON_B, BUTTON_X, BUTTON_Y, BUTTON_LB, BUTTON_RB, BUTTON_BACK, BUTTON_START
};
enum joystick_type {
  JOYSTICK_LEFT,
  JOYSTICK_RIGHT  
};

uint8_t joystick_y(enum joystick_type);
uint8_t joystick_x(enum joystick_type);
uint8_t is_button_pressed(enum button_type);

void init_input();
void update_input();

#endif
