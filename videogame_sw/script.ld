
MEMORY {
    ROM(rx) : ORIGIN = 0, LENGTH = 64K
}

SECTIONS {
    .text : {
        entry.o(.text)
        main.o(.text)
        *(.text.*)
    } > ROM
    .data : {
        *(.data.*)
    } > ROM
    .rodata : {
        *(.rodata.*)
    } > ROM
    .bss : {
        *(.bss.*)
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
