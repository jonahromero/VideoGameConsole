
#include "drawlib.h"
#include "io.h"

uint16_t get_color_value(uint8_t type);

void draw_sprite(uint8_t* colors, pos_t pos, dim_t dim) {
  for (int y = 0; y < dim.height; y++) {
    for (int x = 0; x < dim.width; x++) {
      uint8_t color = *(colors + x + y * dim.width);
      if (color != TRANSPARENT) {
        pos_t pix_pos = (pos_t){
            .x = x + pos.x,
            .y = y + pos.y
        };
        draw_pixel(get_color_value(color), pix_pos);
      }
    }
  }
}

void draw_sprite_one_color(uint8_t* bitmap, uint8_t color, pos_t pos, dim_t dim) {
    for (int y = 0; y < dim.height; y++) {
        for (int x = 0; x < dim.width; x++) {
            uint8_t bitmap_value = *(bitmap + x + y * dim.width);
            if (bitmap_value) {
                pos_t pix_pos = (pos_t){
                    .x = x + pos.x,
                    .y = y + pos.y
                };
                draw_pixel(RGB_TO_565(255, 255, 255)/*get_color_value(color)*/, pix_pos);
            }
        }
    }
}

uint16_t get_color_value(uint8_t type) {
  static uint16_t values[] = {
    [TRANSPARENT] = RGB_TO_565(0,0,0),
    [WHITE] = RGB_TO_565(255, 255, 255),
    [BLACK] = RGB_TO_565(0, 0, 0),
    [RED]   = RGB_TO_565(255, 0, 0),
    [GREEN] = RGB_TO_565(0, 255, 0),
    [BLUE]  = RGB_TO_565(0, 0, 255),
    [BROWN] = RGB_TO_565(240, 153, 60),
    [TAN] = RGB_TO_565(245, 208, 169),
    [AQUA] = RGB_TO_565(169, 245, 231),
    [GRAY] = RGB_TO_565(158, 158, 158)
  };
  return values[type];
}