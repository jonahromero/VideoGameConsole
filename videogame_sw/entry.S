

.section .text
.global _entry
_entry:
    # stack is at
    li sp, 0x10010000 # load sp to top of ram
    j main
loop:
    j loop
