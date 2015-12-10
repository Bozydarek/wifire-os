P	= mips-mti-elf-
CC	= $(P)gcc -mips32r2 -EL -nostdlib -nostdinc

INCLUDES = -Iincludes -Iinternals -Iplatform/internals -Iplatform/includes -Iplatform/c_locale
INCLUDES += -I../ # For uart_raw.h

SOURCES =  $(shell find functions/ -name '*.c')
SOURCES += $(shell find platform/ -name '*.c')
# Compile .c files in-tree.
OBJECTS = $(patsubst %.c,%.o,$(SOURCES))

# -Werror disabled for building a third-party external lib
# C99 or C11 is needed to compile PDClib
CFLAGS =  -Wall -DPIC32MZ -std=c99
# No optimisations, emit debugging info.
CFLAGS += -O0 -g

# Required for correct feature detection.
CDEFS = -D_POSIX_C_SOURCE=200809L

%.o: %.c
	$(CC) $(CFLAGS) $(CDEFS) $(INCLUDES) -c $< -o $@

all: pdclib.a

pdclib.a: $(OBJECTS)
	ar rvs $@ $(OBJECTS)

clean:
	rm -f pdclib.a
	rm -f $(OBJECTS)
