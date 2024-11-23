/* 6.200 Gamepad */

#include "input.h"
#include <SPI.h>

void setup() {
  Serial.begin(9600);
  init_input();
  // start spi
  SPI.begin();
  SPI.beginTransaction(SPISettings(1000000, MSBFIRST, SPI_MODE0));
}

void loop() {
  update_input();
  
  SPI.transfer('S'); // start sequence
  for (int i = 0; i < NBUTTONS; i++) {
    // Sending buttons over in this order
    // BUTTON_A, BUTTON_B, BUTTON_X, BUTTON_Y, BUTTON_LB, BUTTON_RB, BUTTON_BACK, BUTTON_START
    SPI.transfer(is_button_pressed((button_type)i));
  }
  SPI.transfer(joystick_y(JOYSTICK_LEFT));
  SPI.transfer(joystick_x(JOYSTICK_LEFT));
  delay(20);
}
