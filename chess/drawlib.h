
#ifndef GAME_CONSOLE_DRAWLIB_H
#define GAME_CONSOLE_DRAWLIB_H
#include "common.h"

enum {
  TRANSPARENT = 0,
  WHITE,
  BLACK,
  RED  ,
  GREEN,
  BLUE ,
  BROWN,
  TAN,
  AQUA,
  GRAY,
};

uint16_t get_color_value(uint8_t type);
void draw_sprite(uint8_t const* colors, pos_t pos, dim_t dim);
void draw_sprite_one_color(uint8_t const* bitmap, uint8_t color, pos_t pos, dim_t dim);

#endif