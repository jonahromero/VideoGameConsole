
#include "io.h"
#include "common.h"
#include "mmio.h"
#include "canvas.h"

// being careful to not unintentionally use any globals, because id rather not access untested mmio rom

#define MAX_SPRAYS 20
#define SPRAY_RADIUS 10

enum {
  TTT_X, TTT_O
};

typedef struct {
  pos_t pos;
  byte_t player;
} spray_t;

bool skip_rule_xs(int x, int y) {
  bool passes = (x == y) || y == (SPRAY_RADIUS - 1 - x);
  return !passes; 
}

bool skip_rule_os(int x, int y) {
  return x != 0 && y != 0;
}

void render_spray(spray_t * spray) {
  color_t color = spray->player == TTT_X ? RED : WHITE;
  bool (*skip_rule)(int, int) = spray->player == TTT_X ? skip_rule_xs : skip_rule_os;
  for (int y = 0; y < SPRAY_RADIUS; y++) {
    for (int x = 0; x < SPRAY_RADIUS; x++) {
      if (skip_rule(x, y)) continue;
      int new_x = (spray->pos.x - SPRAY_RADIUS / 2) + x;
      int new_y = (spray->pos.y - SPRAY_RADIUS / 2) + y;
      if (valid_screen_pos(new_x, new_y)) {
        draw_pixel((pos_t) {new_x, new_y}, color);
      }
    }
  }
}

typedef struct {
  cursor_t cursor;
  controller_t controller;

  byte_t player_to_move;
  word_t total_sprays;
  spray_t sprays[MAX_SPRAYS];
} game_t; 

void update(game_t * game) {
  game->controller = get_controller_input();
  update_cursor(game->cursor, game->controller);
  if (game->controller.buttons | BUTTON_A && total_sprays < MAX_SPRAYS) {
    pos_t current_pos = game->controller.pos;
    game->sprays[game->total_sprays++] = (spray_t) {
      .pos = current_pos,
      .player = game->player_to_move
    };
    game->player_to_move = !game->player_to_move;
  }
}

void render(game_t * game) {
  for (int i = 0; i < game->total_sprays; i++) {
    render_spray(&game->sprays[i]);
  }
  render_cursor(&game->cursor);
  swap_frame_buffer();
}

game_t create_game() {
  game_t game;
  game.total_sprays = 0;
  game.player_to_move = TTT_O;
  return game;
}

void main() {
  game_t game = create_game();
  while (true) {
    update(&game);
    render(&game);
  }
}
