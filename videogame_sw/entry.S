

.section .text
.global _entry
_entry:
    li sp, 0x1FFFF # load sp to top of ram
    j main
loop:
    j loop
