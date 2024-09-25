CXX     = g++

DIRSP=/usr/local/
LIBSP=-lsentencepiece

CPPFLAGS= -Wall -O3 -march=native -fopenmp -fpermissive -I$(DIRTIKTOKEN) -I$(DIRSP)/include
LFLAGS= -fopenmp -L$(DIRSP)/lib $(LIBSP)

LIBSRCS = $(shell find $(DIRTIKTOKEN) -name '*.cc' )
LIBOBJS = $(LIBSRCS:.cc=.o)

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
	rm -rf *.o runq run $(LIBOBJS) $(LIBTIKTOKEN)
