CC=gcc

LIBDIR=../build
INCDIR=../include

TEST=test_testu01
LIB=randtools
LIBFILE=lib$(LIB).so

all: run_test

run_test: $(TEST)
	@echo "============================== RUN TEST =============================="
	@./$(TEST)
	@echo "======================================================================"

$(TEST): $(LIBDIR)/$(LIBFILE)
	$(CC) -L$(LIBDIR) -I$(INCDIR) -o $(TEST) $(TEST).c -ltestu01 -Wl,-rpath=$(LIBDIR) -l$(LIB)

$(LIBDIR)/$(LIBFILE):
	make -C ..

clean:
	rm -rf *.o $(TEST)

.PHONY: all $(EXE) default clean
