
#include "io.h"
#include "common.h"
#include "mmio.h"

// being careful to not unintentionally use any globals, because id rather not access untested mmio rom
#define TOTAL_COLORS 5
#define RGB_TO_565(r, g, b) ((r<<11) | ((g & ((1<<6)-1))<<5) | (b&((1<<5)-1)))
#define CLAMP(a, mi, ma) ((a>ma? ma : (a < mi ? mi : a)))
#define CANVAS_WIDTH (MMIO__FRAME_BUFFER_WIDTH / 4)
#define CANVAS_HEIGHT (MMIO__FRAME_BUFFER_HEIGHT / 4)

void memcpy(void *dest, const void *src, size_t n) {
	for (int i = 0; i < n; i++) {
		((uint8_t*)dest)[i] = ((uint8_t*)src)[i];
	}
}

enum color_enum_t {
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

typedef struct {
  // colors
  word_t color_idx;
  color_t color_pallette[TOTAL_COLORS];

  pos_t cursor;
  canvas_t canvas;
  controller_t controller;
} game_t; 

void update(game_t * game) {
  game->controller = get_controller_input();
  if (game->controller.xtilt < TILT_IDLE - 2) {
    if (game->cursor.x != 0) game->cursor.x -= 1;
  }
  else if (game->controller.xtilt > TILT_IDLE + 2) {
    if (game->cursor.x != MMIO__FRAME_BUFFER_WIDTH) game->cursor.x += 1;
  }
  if (game->controller.ytilt < TILT_IDLE - 2) {
    if (game->cursor.y != 0) game->cursor.y -= 1;
  }
  else if (game->controller.ytilt > TILT_IDLE + 2) {
    if (game->cursor.y != MMIO__FRAME_BUFFER_HEIGHT) game->cursor.y += 1;
  }

  if (game->controller.buttons | BUTTON_A) {
    game->color_idx = BLACK;
  }
  else if (game->controller.buttons | BUTTON_Y) {
    game->color_idx = (game->color_idx + 1) % TOTAL_COLORS; 
  }
  else if (game->controller.buttons | BUTTON_RB) {
    game->canvas.pixels[game->cursor.y][game->cursor.x] = game->color_pallette[game->color_idx];
  }
}

void render(game_t * game) {
  // draw canvas
  for (uint16_t y = 0; y < CANVAS_HEIGHT; y++) {
    for (uint16_t x = 0; x < CANVAS_WIDTH; x++) {
      draw_pixel(game->canvas.pixels[y][x],(pos_t){x, y});
    }
  }
  // draw cursor
  draw_pixel(game->color_pallette[game->color_idx], game->cursor);
  pos_t cursor_adj[4] = {
    (pos_t) { game->cursor.x, game->cursor.y + 1 },
    (pos_t) { game->cursor.x, game->cursor.y - 1 },
    (pos_t) { game->cursor.x + 1, game->cursor.y },
    (pos_t) { game->cursor.x - 1, game->cursor.y },
  };
  for (int i = 0; i < 4; i++) {
    //if (cursor_adj[i].x < MMIO__FRAME_BUFFER_WIDTH &&
    //    cursor_adj[i].x > 0 && cursor_adj[i].y > 0 &&
    //    cursor_adj[i].y < MMIO__FRAME_BUFFER_HEIGHT)
    {
      draw_pixel(game->color_pallette[WHITE], cursor_adj[i]);
    }
  }
  swap_frame_buffer();
}

game_t create_game() {
  game_t game;
  game.cursor.x = 100;
  game.cursor.y = 100;
  game.color_pallette[WHITE] = RGB_TO_565(255, 255, 255);
  game.color_pallette[BLACK] = RGB_TO_565(0, 0, 0);
  game.color_pallette[RED]   = RGB_TO_565(255, 0, 0);
  game.color_pallette[GREEN] = RGB_TO_565(0, 255, 0);
  game.color_pallette[BLUE]  = RGB_TO_565(0, 0, 255);
  return game;
}

void main() {
  draw_pixel(RGB_TO_565(255, 255, 255),(pos_t){1,3});
  game_t game = create_game();
  while (true) {
    update(&game);
    render(&game);
  }
}
