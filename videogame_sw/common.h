
#ifndef GAME_CONSOLE_COMMON_H
#define GAME_CONSOLE_COMMON_H
#include <stdint.h>
#include <stdbool.h>

typedef uint8_t byte_t;
typedef uint16_t word_t;
typedef uint32_t dword_t;

typedef struct {
  word_t x, y;
} pos_t;


#endif