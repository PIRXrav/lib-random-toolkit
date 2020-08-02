CC=gcc

LIBDIR=../build
INCDIR=../include

GENERATOR=generator
LIB=randtools
LIBFILE=lib$(LIB).so

TEST=test_distribution.R

all: run_test

run_test: $(GENERATOR)
	@echo "====================== RUN TEST DISTRIBUTION ========================="
	@echo " H_0: { F_emp = F_the }"
	@./test.sh
	@echo "======================================================================"

$(GENERATOR): $(LIBDIR)/$(LIBFILE) $(GENERATOR).c
	$(CC) -L$(LIBDIR) -I$(INCDIR) -o $(GENERATOR) $(GENERATOR).c -Wl,-rpath=$(LIBDIR) -l$(LIB)

$(LIBDIR)/$(LIBFILE):
	make -C ..

clean:
	rm -rf *.o $(GENERATOR)

.PHONY: all $(EXE) default clean
