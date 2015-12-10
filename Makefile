# vim: tabstop=8 shiftwidth=8 noexpandtab:

P	= mips-mti-elf-
QEMU	= qemu-system-mipsel -machine pic32mz-wifire -sdl -serial stdio -s -S
CC	= $(P)gcc -mips32r2 -EL -g -nostdlib
AS	= $(P)as -mips32r2 -EL -g
GDB	= $(P)gdb
OBJCOPY	= $(P)objcopy
OBJDUMP	= $(P)objdump
CFLAGS	= -O -Wall -Werror -DPIC32MZ  -nostdinc
ASFLAGS = -O -Wall -Werror -DPIC32MZ
LDSCRIPT= pic32mz.ld
LDFLAGS	= -T $(LDSCRIPT) -Wl,-Map=pic32mz.map

PROGNAME = main
SOURCES = main.c uart_raw.c
SOURCES_ASM = startup.S
OBJECTS := $(SOURCES:.c=.o)
OBJECTS_ASM := $(SOURCES_ASM:.S=.o)
OBJECTS += $(OBJECTS_ASM)

INCLUDES = -I. -Ipdclib/includes -Ipdclib/platform/includes -Ipdclib/internals -Ipdclib/platform/internals -Ipdclib/platform/c_locale

EXT_LIBS = pdclib/pdclib.a
# libgcc is needed for __udivi3 and __umodi3
LIBS = -lgcc

all: $(PROGNAME).srec

$(PROGNAME).srec: $(OBJECTS) $(LDSCRIPT) pdclib
	$(CC) $(LDFLAGS) $(OBJECTS) $(EXT_LIBS) $(LIBS) -o $(PROGNAME).elf
	$(OBJCOPY) -O srec $(PROGNAME).elf $(PROGNAME).srec

%.S: %.c
	$(AS) $(ASFLAGS) -c $<

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $<

debug: $(PROGNAME).srec
	$(GDB) $(PROGNAME).elf

qemu: $(PROGNAME).srec
	$(QEMU) -kernel $(PROGNAME).srec

pdclib:
	$(MAKE) -C pdclib pdclib.a

clean:
	$(MAKE) -C pdclib clean
	rm -f *.o *.lst *~ *.elf *.srec *.map

.PHONY: pdclib
