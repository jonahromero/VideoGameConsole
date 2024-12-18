
// rom:   0x0FFFF - 0x00000
// ram:   0x1FFFF - 0x10000
// frame: 0x2FFFF - 0x20000
// io:    0x3FFFF - 0x30000

// FB SWAP: 0x2FFFF

#define MMIO_ADDR(addr) ((volatile uint8_t*)(void*)(addr))

// ROM
#define MMIO__ROM_START (MMIO_ADDR(0x00000))

// RAM
#define MMIO__RAM_START (MMIO_ADDR(0x10000))

// Frame Buffer MMIO
#define MMIO__FRAME_BUFFER_START_ADDR (MMIO_ADDR(0x20000))
#define MMIO__FRAME_BUFFER_WIDTH (320)
#define MMIO__FRAME_BUFFER_HEIGHT (180)
#define MMIO__FRAME_BUFFER_SIZE (MMIO__FRAME_BUFFER_WIDTH * MMIO__FRAME_BUFFER_HEIGHT * 2)
#define MMIO__FRAME_BUFFER_SWAP_ADDR  (MMIO_ADDR(0x2FFFF))

// Controller MMIO
#define MMIO__CTLR_BASE_ADDR (MMIO_ADDR(0x30000))
#define MMIO__CTLR_JOYSTICK_X_OFFSET 1
#define MMIO__CTLR_JOYSTICK_Y_OFFSET 2
#define MMIO__CTLR_BUTTONS_OFFSET 3

