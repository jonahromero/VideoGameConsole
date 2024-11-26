/* 6.200 Gamepad */

#include "input.h"
#include <SPI.h>
#define CLK_PIN 13
#define DATA_PIN 11
#define EXTRA_PIN 12
#define MY_SPI

void setup() {
  Serial.begin(9600);
  pinMode(EXTRA_PIN, OUTPUT);
  init_input();
  // start spi
 #ifdef MY_SPI
  init_custom_spi();
 #else
  SPI.begin();
  SPI.beginTransaction(SPISettings(10000, MSBFIRST, SPI_MODE1));
 #endif
}

void init_custom_spi(){
  pinMode(DATA_PIN, OUTPUT);
  pinMode(CLK_PIN, OUTPUT);  
  digitalWrite(CLK_PIN, LOW);  
  digitalWrite(DATA_PIN, LOW);
}

void sent_byte(uint8_t b) {
 #ifdef MY_SPI
  for (int i = 0; i < 8; i++) {
    digitalWrite(DATA_PIN, (b&0x80)? HIGH : LOW);
    delayMicroseconds(1);
    digitalWrite(CLK_PIN, HIGH);
    delayMicroseconds(1);
    digitalWrite(CLK_PIN, LOW);
    delayMicroseconds(1);
    b <<= 1;
  }  
  digitalWrite(DATA_PIN, LOW);
  delayMicroseconds(2);
 #else
  SPI.transfer(b);
 #endif
}

void loop() {
  update_input();

  sent_byte(0xFF); // start sequence
  for (int i = 0; i < NBUTTONS; i++) {
    bool is_pressed = is_button_pressed((button_type)i);
    // BUTTON_A, BUTTON_B, BUTTON_X, BUTTON_Y, BUTTON_LB, BUTTON_RB, BUTTON_BACK, BUTTON_START
    digitalWrite(EXTRA_PIN,(is_pressed && i == 0) ? HIGH : LOW);
    sent_byte(is_pressed);
  }
  sent_byte(joystick_y(JOYSTICK_LEFT) );
  sent_byte(joystick_x(JOYSTICK_LEFT) );
  delay(1);
}
