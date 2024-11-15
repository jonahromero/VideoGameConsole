
# All of the gnu binaries used to compiled
CC := riscv32-unknown-elf-gcc
CPP := riscv32-unknown-elf-g++
OBJ_COPY := riscv32-unknown-elf-objcopy
OBJ_DUMP := riscv32-unknown-elf-objdump
LD := riscv32-unknown-elf-ld
PYTHON := ./.venv/bin/python3

# parameters for our program
OBJS := \
	main.o \
	entry.o \
	io.o


LINKER_SCRIPT := script.ld
CC_FLAGS += -fno-common -nostdlib -march=rv32i -mabi=ilp32

ifdef DEBUG
	CC_FLAGS += -O0
else
	CC_FLAGS += -O3
endif


all: program

# rule: requisites => commands
program: $(OBJS) $(LINKER_SCRIPT)
	$(LD) -T $(LINKER_SCRIPT) -o program.elf $(OBJS)
	$(OBJ_COPY) -j .text -O binary program.elf program.bin
	$(OBJ_DUMP) -D -s -z -m riscv:rv32 program.elf > program.asm
	$(PYTHON) ./bintohex.py -i=./program.bin -o=./program.hex
#$(OBJ_DUMP) -b binary -D -m riscv:rv32 program > program.asm

%.o: %.c
	$(CC) $(CC_FLAGS) -c $< -o $@
%.o: %.S
	$(CC) $(CC_FLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f program.elf
	rm -f *.asm
	rm -f $(OBJS)
