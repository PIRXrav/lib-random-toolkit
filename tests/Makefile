# Adapted from  https://github.com/kylelaker/xorlist/blob/master/tests/Makefile

CC=gcc

override CFLAGS := -g -O0 -Wall -pedantic -std=c99 $(CFLAGS)
override LDFLAGS := -g -O0 $(LDFLAGS)

SRCDIR=../src
OUTDIR=../build
INCDIR=../include

TMPSRCS=$(shell find $(SRCDIR) -type f -name "*.c")
SRCS = $(filter-out $(SRCDIR)/main.c, $(TMPSRCS))
OBJS=$(patsubst $(SRCDIR)/%,$(OUTDIR)/%,$(SRCS:.c=.o))
INC=-I$(INCDIR)

# build tests
SRCSTEST=$(shell find . -type f -name "*.c")
OBJSTEST=$(SRCSTEST:.c=.o)

TEST=testsuite
LIBS=-lcheck -lm -lrt
UTESTOUT=utests.txt

all: run_test

run_test: $(TEST)
	@echo "========================================"
	@echo "             UNIT TESTS                 "
	@./$(TEST) 2>/dev/null | sed -n -e '/Checks/,$$p' | sed -e 's/^private.*:[EF]://g'
	@echo "========================================"

$(TEST): $(TEST).o $(OBJSTEST) $(OBJS)
	$(CC) $(LDFLAGS) -o $(TEST) $^ $(LIBS)

$(OUTDIR)/%.o: $(SRCDIR)/%.c
	mkdir -p $(OUTDIR)
	$(CC) -c $(CFLAGS) $(INC) $< -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) $(INC) $< -o $@

clean:
	rm -rf *.o $(TEST) $(UTESTOUT)

.PHONY: all $(EXE) default clean
