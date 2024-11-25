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
  
  //SPI.transfer('S'); // start sequence
  for (int i = 0; i < NBUTTONS; i++) {
    bool is_pressed = is_button_pressed((button_type)i);
    // Sending buttons over in this order
    Serial.print(button_name((enum button_type)i));
    Serial.print(":");
    Serial.println(is_pressed);
    // BUTTON_A, BUTTON_B, BUTTON_X, BUTTON_Y, BUTTON_LB, BUTTON_RB, BUTTON_BACK, BUTTON_START
    SPI.transfer(0x65);
  }
  SPI.transfer(0);//joystick_y(JOYSTICK_LEFT));
  SPI.transfer(0);//joystick_x(JOYSTICK_LEFT));
  delay(20);
}
