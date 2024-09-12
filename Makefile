CXX     = g++

TIKTOKEN=./cpp-tiktoken

CPPFLAGS= -Wall -O3 -march=native -fopenmp -fpermissive -I$(TIKTOKEN)
#CPPFLAGS= -Wall -g -fpermissive -I$(TIKTOKEN)
LFLAGS= -fopenmp -L$(TIKTOKEN) -lcpptiktoken -lpcre2-8 -lfmt

default: runq run

run: run.o
	$(CXX) -o $@ $< $(LFLAGS)

runq: runq.o
	$(CXX) -o $@ $< $(LFLAGS)

%.o: %.c
	$(CXX) $(CPPFLAGS) -c $<

clean:;
	rm -rf *.o runq run
