#include "canvas.h"

bool valid_screen_pos(int x, int y) {
  return x > 0 && x < MMIO__FRAME_BUFFER_WIDTH && y > 0 && y < MMIO__FRAME_BUFFER_HEIGHT;
}

void render_canvas(canvas_t * canvas) {
  // draw canvas
  for (word_t y = 0; y < CANVAS_HEIGHT; y++) {
    for (word_t x = 0; x < CANVAS_WIDTH; x++) {
      draw_pixel(canvas->pixels[y][x],(pos_t){x, y});
    }
  }
}

color_t next_color(word_t idx) {
  return (idx + 1) % TOTAL_COLORS;
}

color_t get_color(word_t idx) {
  static color_t color_pallette[TOTAL_COLORS] = {
    [WHITE] RGB_TO_565(255, 255, 255),
    [BLACK] RGB_TO_565(0, 0, 0),
    [RED]   RGB_TO_565(255, 0, 0),
    [GREEN] RGB_TO_565(0, 255, 0),
    [BLUE]  RGB_TO_565(0, 0, 255),
  };
  return color_pallette[idx];
}
