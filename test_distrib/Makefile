CC=gcc

LIBDIR=../build
INCDIR=../include

GENERATOR=generator
LIB=randtools
LIBFILE=lib$(LIB).so

TEST=test_distribution.R

all: run_test

run_test: $(GENERATOR)
	@echo "============================== RUN TEST =============================="
	@./$(GENERATOR)
	@echo "======================================================================"

$(GENERATOR): $(LIBDIR)/$(LIBFILE)
	$(CC) -L$(LIBDIR) -I$(INCDIR) -o $(GENERATOR) $(GENERATOR).c -Wl,-rpath=$(LIBDIR) -l$(LIB)

$(LIBDIR)/$(LIBFILE):
	make -C ..

clean:
	rm -rf *.o $(GENERATOR)

.PHONY: all $(EXE) default clean
