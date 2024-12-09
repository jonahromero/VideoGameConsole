
#ifndef GAME_CONSOLE_COMMON_H
#define GAME_CONSOLE_COMMON_H
#include <stdint.h>
#include <stdbool.h>

#define RGB_TO_565(r, g, b) ((r<<11) | ((g & ((1<<6)-1))<<5) | (b&((1<<5)-1)))

typedef uint8_t byte_t;
typedef uint16_t word_t;
typedef uint32_t dword_t;
typedef uint64_t size_t;

typedef struct {
  int16_t x, y;
} pos_t;

#endif
