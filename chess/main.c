
#include "io.h"
#include "common.h"
#include "mmio.h"
#include "drawlib.h"

// void memcpy(void *dest, const void *src, size_t n) {
// 	for (int i = 0; i < n; i++) {
// 		((uint8_t*)dest)[i] = ((uint8_t*)src)[i];
// 	}
// }
unsigned int __udivsi3(unsigned int a, unsigned int b) {
    unsigned ua = (unsigned)a;
    unsigned ub = (unsigned)b;
    if (ub == 0) {
        return 0;
    }
    unsigned quotient = 0;
    unsigned remainder = 0;
    for (int i = 31; i >= 0; i--) {
        remainder = (remainder << 1) | ((ua >> i) & 1);
        if (remainder >= ub) {
            remainder -= ub;
            quotient |= (1U << i);
        }
    }
    return (int)quotient;
}

int __modsi3(int a, int b) {
    if (b == 0) {
        return 0;
    }
    int neg = 0;
    if (a < 0) { a = -a; neg = !neg; }
    if (b < 0) { b = -b; neg = !neg; }
    while (a >= b) {
        a -= b;
    }
    return neg ? -a : a;
}

#define R_BOARD_LEFT 80
#define R_BOARD_TOP 10
#define R_BOARD_SIZE 160
#define R_SQ_SIZE 20
#define BOARD_WIDTH 8
#define BOARD_HEIGHT 8

enum _piece_type_t {
  NONE = 0,
  KING,
  QUEEN,
  BISHOP,
  KNIGHT,
  ROOK,
  PAWN,
};
enum _piece_color_t {
  BLACKP,
  WHITEP
};

typedef uint8_t square_t;
static square_t INVALID_SQ = -1;

typedef struct {
  uint8_t type, color;
} piece_t;

typedef struct {
  uint8_t to_move;
  piece_t board[64];
} chess_t;

typedef struct {
  square_t sq_from;
  chess_t chess;
  pos_t cursor;
  controller_t controller;
} game_t;

game_t create_game() {
  piece_t brook = (piece_t){ROOK, BLACKP};
  piece_t wrook = (piece_t){ROOK, WHITEP};
  piece_t bknight = (piece_t){KNIGHT, BLACKP};
  piece_t wknight = (piece_t){KNIGHT, WHITEP};
  piece_t bbishop = (piece_t){BISHOP, BLACKP};
  piece_t wbishop = (piece_t){BISHOP, WHITEP};
  piece_t bking = (piece_t){KING, BLACKP};
  piece_t wking = (piece_t){KING, WHITEP};
  piece_t bqueen = (piece_t){QUEEN, BLACKP};
  piece_t wqueen = (piece_t){QUEEN, WHITEP};
  piece_t bpawn = (piece_t){PAWN, BLACKP};
  piece_t wpawn = (piece_t){PAWN, WHITEP};
  piece_t none = (piece_t){NONE, WHITEP};

  chess_t chess = {
    .to_move = WHITEP,
    .board = {
      brook, bknight, bbishop, bqueen, bking, bbishop, bknight, brook,
      bpawn, bpawn,   bpawn,   bpawn,  bpawn, bpawn,   bpawn,   bpawn,
      none,  none,    none,    none,   none,  none,    none,    none,
      none,  none,    none,    none,   none,  none,    none,    none,
      none,  none,    none,    none,   none,  none,    none,    none,
      none,  none,    none,    none,   none,  none,    none,    none,
      wpawn, wpawn,   wpawn,   wpawn,  wpawn, wpawn,   wpawn,   wpawn,
      wrook, wknight, wbishop, wqueen, wking, wbishop, wknight, wrook,
    }
  };
  return (game_t) {
    .sq_from = INVALID_SQ,
    .chess = chess,
    .cursor= (pos_t) {100, 100}
  };
}

square_t get_current_sq(pos_t pos) {
  pos.x -= 80;
  pos.y -= 10;
  if (pos.x >= R_BOARD_SIZE || pos.y >= R_BOARD_SIZE || pos.x < 0 || pos.y < 0) {
    return INVALID_SQ;
  }
  pos.x /= R_SQ_SIZE;
  pos.y /= R_SQ_SIZE;
  return pos.x + pos.y * BOARD_WIDTH;
}


#include "sprites.h"

void update(game_t * game) {
  const int PLAYER_SPEED = 3;
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

  chess_t * chess = &game->chess; 
  if (game->controller.buttons_pressed & BUTTON_A) {
    game->sq_from = get_current_sq(game->cursor);
  }
  else if (game->controller.buttons_pressed & BUTTON_Y) {
    square_t sq_to = get_current_sq(game->cursor);
    if (sq_to != INVALID_SQ && game->sq_from != INVALID_SQ) {
      chess->board[sq_to] = chess->board[game->sq_from];
      chess->board[game->sq_from].type = NONE;
      game->sq_from = INVALID_SQ;
    }
  }
}

void render(game_t * game) {
  // draw the board
  for (int i = 0; i < 64; i++) {
    piece_t * piece = &game->chess.board[i];
    uint8_t const* piece_sprite = get_piece_sprite(*piece);
    uint8_t piece_color = piece->color == WHITEP ? WHITE : BLACK;
    int row = (i/8), col = (i%8);
    uint8_t sq_color = (row + col) % 2 == 0 ? GRAY : WHITE;
    pos_t sq_pos = {
      R_BOARD_LEFT + col * R_SQ_SIZE,
      R_BOARD_TOP + row * R_SQ_SIZE,
    };
    // square
    if (game->sq_from != INVALID_SQ && i == game->sq_from) sq_color = TEAL;
    draw_sprite_one_color(sq_sprite, sq_color, sq_pos, (dim_t) {20, 20});
    // piece
    draw_sprite(piece_sprite, (pos_t) {
      sq_pos.x + 2, sq_pos.y + 2
    }, (dim_t) {16, 16});
  }
  // draw cursor
  uint8_t cursor_bitmap[3][3] = {
    { 0, 1, 0 },
    { 1, 1, 1,},
    { 0, 1, 0,},
  };
  for (int y = 0; y < 3; y++) {
    for (int x = 0; x < 3; x++) {
      pos_t pos = {game->cursor.x + x - 1, game->cursor.y + y - 1};
      if (pos.x < MMIO__FRAME_BUFFER_WIDTH &&
          pos.x > 0 && pos.y > 0 && cursor_bitmap[y][x] && 
          pos.y < MMIO__FRAME_BUFFER_HEIGHT)
      {
        draw_pixel(get_color_value(RED), pos);
      }
    }
  }
}

void main() {
  game_t game = create_game();
  while (true) {
    update(&game);
    render(&game);
    swap_frame_buffer();
  }
}
