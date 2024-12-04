
#ifndef VIDEOGAME_CONSOLE_CANVAS_H
#define VIDEOGAME_CONSOLE_CANVAS_H
#include "common.h"

#define CANVAS_WIDTH MMIO__FRAME_BUFFER_WIDTH
#define CANVAS_HEIGHT MMIO__FRAME_BUFFER_HEIGHT
#define TOTAL_COLORS 5

enum {
  WHITE,
  BLACK,
  RED  ,
  GREEN,
  BLUE ,
};

typedef word_t color_t;
typedef struct {
  color_t pixels[CANVAS_HEIGHT][CANVAS_WIDTH];
} canvas_t;

bool valid_screen_pos(int x, int y);
void render_canvas(canvas_t * canvas);
color_t next_color(word_t color_idx)
color_t get_color(word_t color_idx);

#endif