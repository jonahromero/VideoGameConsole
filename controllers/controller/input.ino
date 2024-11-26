
#include "input.h"

int button_pins[NBUTTONS] = {
  20,19,21,18, 5, 22, 16, 17
};

const char* button_names[NBUTTONS] = {
  "BUTTON_A", "BUTTON_B", "BUTTON_X", "BUTTON_Y", 
  "BUTTON_LB", "BUTTON_RB", "BUTTON_BACK", "BUTTON_START"
};

const char* button_name(enum button_type b) {
  return *(button_names + (int)b);  
}

uint8_t is_button_pressed_raw[NBUTTONS] = {};

uint8_t left_xaxis, left_yaxis;
uint8_t right_xaxis, right_yaxis;

uint8_t joystick_y(enum joystick_type j) {
  return j == JOYSTICK_RIGHT ? right_yaxis : left_yaxis;  
}
uint8_t joystick_x(enum joystick_type j) {
  return j == JOYSTICK_RIGHT ? right_xaxis : left_xaxis ;  
}
uint8_t is_button_pressed(enum button_type b) {
  return is_button_pressed_raw[b];  
}

void init_input() {
  analogReadResolution(4);
  for (int i=0; i< NBUTTONS; i++) {
    pinMode(button_pins[i], INPUT_PULLUP);
  }
}
void update_input() {
  left_xaxis = analogRead(0);
  left_yaxis = analogRead(1);
  
  right_xaxis = analogRead(0);
  right_yaxis = analogRead(1);

  for (int i=0; i< NBUTTONS; i++) {
    is_button_pressed_raw[i] = !digitalRead(button_pins[i]);
  }
}
