CXX     = g++

DIRSENTENCEPIECE=./sentencepiece
INCSP=-I$(DIRSENTENCEPIECE)/src
LIBSP=-L$(DIRSENTENCEPIECE)/build/src -lsentencepiece

CPPFLAGS= -Wall -O3 -march=native -fopenmp -fpermissive
LFLAGS= -fopenmp -L$(DIRSP)/lib $(LIBSP)

default: runq run

run: run.o
	$(CXX) -o $@ $< $(LFLAGS)

runq: runq.o
	$(CXX) -o $@ $< $(LFLAGS)

%.o: %.c
	$(CXX) $(CPPFLAGS) -c $<

%.o: %.cc
	$(CXX) $(CPPFLAGS) -c $< -o $@

clean:;
	rm -rf *.o runq run
