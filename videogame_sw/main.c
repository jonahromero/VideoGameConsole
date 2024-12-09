
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
int __modsi3(int a, int b) {
    if (b == 0) {
        // You might want to handle this differently, but let's just return 0 here.
        return 0;
    }

    // Record sign and make both a and b positive
    int neg = 0;
    if (a < 0) { a = -a; neg = !neg; }
    if (b < 0) { b = -b; neg = !neg; }

    // Subtract b until what's left is less than b
    while (a >= b) {
        a -= b;
    }

    // If remainder should be negative, flip sign
    return neg ? -a : a;
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
  const int PLAYER_SPEED = 4;
  update_controller(&game->controller);
  if (game->controller.xtilt < TILT_IDLE - 2) {
    if (game->cursor.x >  PLAYER_SPEED) game->cursor.x -= PLAYER_SPEED;
    else game->cursor.x = 0;
  }
  else if (game->controller.xtilt > TILT_IDLE + 2) {
    if (game->cursor.x + PLAYER_SPEED < MMIO__FRAME_BUFFER_WIDTH) game->cursor.x += PLAYER_SPEED;
    else game->cursor.x = MMIO__FRAME_BUFFER_WIDTH - 1;
  }
  if (game->controller.ytilt > TILT_IDLE + 2) {
    if (game->cursor.y > PLAYER_SPEED) game->cursor.y -= PLAYER_SPEED;
    else game->cursor.y = 0;
  }
  else if (game->controller.ytilt < TILT_IDLE - 2) {
    if (game->cursor.y +  PLAYER_SPEED < MMIO__FRAME_BUFFER_HEIGHT) game->cursor.y += PLAYER_SPEED;
    else game->cursor.y = MMIO__FRAME_BUFFER_HEIGHT - 1;
  }

  if (game->controller.buttons_pressed & BUTTON_A) {
    game->color_idx = BLACK;
  }
  else if (game->controller.buttons_pressed & BUTTON_Y) {
    game->color_idx = (game->color_idx + 1) % TOTAL_COLORS; 
  }
  else if (game->controller.buttons_pressed & BUTTON_RB) {
    game->canvas.pixels[game->cursor.y/4][game->cursor.x/4] = game->color_pallette[game->color_idx];
  }
}

void render(game_t * game) {
  // draw canvas
  for (uint16_t y = 0; y < CANVAS_HEIGHT * 4; y++) {
    for (uint16_t x = 0; x < CANVAS_WIDTH * 4; x++) {
      draw_pixel(game->canvas.pixels[y / 4][x / 4],(pos_t){x, y});
    }
  }
  // draw cursor
  uint8_t cursor_bitmap[4][4] = {
    { 0, 1, 1, 0},
    { 1, 1, 1, 1},
    { 1, 1, 1, 1},
    { 0, 1, 1, 0},
  };
  for (int y = 0; y < 4; y++) {
    for (int x = 0; x < 4; x++) {
      pos_t pos = {game->cursor.x + x - 2, game->cursor.y + y - 2};
      if (pos.x < MMIO__FRAME_BUFFER_WIDTH &&
          pos.x > 0 && pos.y > 0 && cursor_bitmap[y][x] && 
          pos.y < MMIO__FRAME_BUFFER_HEIGHT)
      {
        draw_pixel(game->color_pallette[WHITE], pos);
      }
    }
  }
  draw_pixel(game->color_pallette[game->color_idx], game->cursor);
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
  game_t game = create_game();
  while (true) {
    update(&game);
    render(&game);
  }
}
