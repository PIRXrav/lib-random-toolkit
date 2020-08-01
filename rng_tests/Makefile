CC=gcc

LIBDIR=../build
INCDIR=../include

TEST=rng_test

all: run_test

run_test: $(TEST)
	@echo "============================== RUN TEST =============================="
	@./$(TEST)
	@echo "======================================================================"

$(TEST): $(LIBDIR)/librng.so
	$(CC) -L$(LIBDIR) -I$(INCDIR) -o $(TEST) test_testu01.c -ltestu01 -Wl,-rpath=$(LIBDIR) -lrng

$(LIBDIR)/librng.so:
	make -C ..

clean:
	rm -rf *.o $(TEST)

.PHONY: all $(EXE) default clean
