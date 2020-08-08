CC=gcc

CFLAGS = -Wall -pedantic -std=c99 -O2 -fPIC
LDFLAGS =

SRCDIR = src
OUTDIR = build
INCDIR = include
PREFIX = /usr

SRCS = $(shell find $(SRCDIR) -type f -name *.c)
OBJS = $(patsubst $(SRCDIR)/%,$(OUTDIR)/%,$(SRCS:.c=.o))
INC  = -I$(INCDIR)

LIB=randtools
LIBFILE=lib$(LIB).so

all: $(OUTDIR)/$(LIBFILE)

$(OUTDIR)/%.o: $(SRCDIR)/%.c
	mkdir -p $(OUTDIR)
	$(CC) -c $(CFLAGS) $(INC) $< -o $@

$(OUTDIR)/$(LIBFILE): $(OBJS)
	$(CC) $(CFLAGS) -shared -o $@ $^ -lm

run_test:
	make -C tests

run_rng_test:
	make -C rng_tests

run_test_distrib:
	make -C test_distrib


run_test_noise:
	make -C test_noise


clean:
	rm -rf $(OUTDIR)
	make -C tests clean
	make -C rng_tests clean
	make -C test_distrib clean


.PHONY: all default clean test
