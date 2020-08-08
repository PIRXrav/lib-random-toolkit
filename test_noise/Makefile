CC=gcc

LIBDIR=../build
INCDIR=../include

LIB=randtools
LIBFILE=lib$(LIB).so

CFLAGS = -Wall -pedantic -std=c99 -O2 -fPIC -L$(LIBDIR) -I$(INCDIR)
LDFLAGS =

SRCS = $(shell find . -type f -name *.c)
TESTS = $(SRCS:.c=)

all: $(TESTS)
	@ echo $(TESTS)

$(TESTS): %: %.c $(LIBDIR)/$(LIBFILE)
	$(CC) $(CFLAGS) -o $@ $< -Wl,-rpath=$(LIBDIR) -l$(LIB) -lm

$(LIBDIR)/$(LIBFILE):
	make -C ..

clean:
	rm -rf *.o $(TESTS)

.PHONY: all $(TESTS) default clean
