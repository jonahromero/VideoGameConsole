
#ifndef GAME_CONSOLE_COMMON_H
#define GAME_CONSOLE_COMMON_H
#include <stdint.h>
#include <stdbool.h>

// define some types used everywhere in the console

typedef uint64_t size_t;

typedef struct {
  int16_t x, y;
} pos_t;

typedef struct {
  int16_t width, height;
} dim_t;

#endif
