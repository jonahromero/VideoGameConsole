
MEMORY {
    ROM(rx) : ORIGIN = 0, LENGTH = 64K
}

SECTIONS {
    .text : {
        entry.o(.text)
        main.o(.text)
        *(.text.*)
        *(.text)
    } > ROM
    .data : {
        *(.data)
    }
    .rodata : {
        *(.rodata)
    }
    .bss : {
        *(.bss)
    }

    /DISCARD/ : {
    *(.eh_frame)
    *(.eh_frame_hdr)
    *(.comment)
    *(.note*)
    *(.debug*)
    *(.gnu*)
    *(.riscv.attributes)
}
}
