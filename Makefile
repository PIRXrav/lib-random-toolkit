CC=gcc

CFLAGS = -Wall -pedantic -std=c99 -O2 -fPIC
LDFLAGS =

SRCDIR = src
OUTDIR = build
INCDIR = include
PREFIX = /usr

SRCS = $(shell find $(SRCDIR) -type f -name *.c)
OBJS = $(patsubst $(SRCDIR)/%,$(OUTDIR)/%,$(SRCS:.c=.o))
SHOBJS = $(patsubst $(SRCDIR)/%,$(OUTDIR)/lib%,$(SRCS:.c=.so))
INC  = -I$(INCDIR)

EXE=azerty

all: libs

libs: $(OBJS) $(SHOBJS)

run_test:
	make -C tests

run_rng_test:
	make -C rng_tests

exe: $(EXE)

$(EXE): $(OBJS)
	$(CC) $(LDFLAGS) $^ -o $@

$(OUTDIR)/%.o: $(SRCDIR)/%.c
	mkdir -p $(OUTDIR)
	$(CC) -c $(CFLAGS) $(INC) $< -o $@

$(OUTDIR)/lib%.so: $(OUTDIR)/%.o
	$(CC) $(CFLAGS) -shared -o $@ $<

clean:
	rm -rf $(OUTDIR) list_test
	make -C tests clean
	make -C rng_tests clean


.PHONY: all default clean test
