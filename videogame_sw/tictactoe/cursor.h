#ifndef VIDEOGAME_CONSOLE_CURSOR_H
#define VIDEOGAME_CONSOLE_CURSOR_H

typedef pos_t cursor_t;
void update_cursor(cursor_t* cursor, controller_t * controller);
void render_cursor(cursor_t const* cursor);

#endif