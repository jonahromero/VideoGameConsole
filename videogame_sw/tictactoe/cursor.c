#include "cursor.h"

void update_cursor(cursor_t* cursor, controller_t * controller) {
  if (controller->xtilt < TILT_IDLE - 2) {
    cursor->x -= 1;
  }
  else if (controller->xtilt > TILT_IDLE + 2) {
    cursor->x += 1;
  }
  if (controller->ytilt < TILT_IDLE - 2) {
    cursor->y -= 1;
  }
  else if (controller->ytilt > TILT_IDLE + 2) {
    cursor->y += 1;
  }
}

void render_cursor(cursor_t const* cursor) {
  draw_pixel(get_color(WHITE), game->cursor);
  pos_t cursor_adj[4] = {
    (pos_t) { game->cursor.x, game->cursor.y + 1 },
    (pos_t) { game->cursor.x, game->cursor.y - 1 },
    (pos_t) { game->cursor.x + 1, game->cursor.y },
    (pos_t) { game->cursor.x - 1, game->cursor.y },
  };
  for (int i = 0; i < 5; i++) {
    draw_pixel(get_color(WHITE), cursor_adj[i]);
  }
}
