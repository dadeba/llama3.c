CXX     = g++

DIRTIKTOKEN=./cpp-tiktoken
LIBTIKTOKEN=libcpptiktoken.a

CPPFLAGS= -Wall -O3 -march=native -fopenmp -fpermissive -I$(DIRTIKTOKEN)
LFLAGS= -fopenmp -lpcre2-8 -lfmt

LIBSRCS = $(shell find $(DIRTIKTOKEN) -name '*.cc' )
LIBOBJS = $(LIBSRCS:.cc=.o)

default: runq run

run: run.o $(LIBTIKTOKEN)
	$(CXX) -o $@ $< $(LIBTIKTOKEN) $(LFLAGS)

runq: runq.o $(LIBTIKTOKEN)
	$(CXX) -o $@ $< $(LIBTIKTOKEN) $(LFLAGS)

%.o: %.c
	$(CXX) $(CPPFLAGS) -c $<

%.o: %.cc
	$(CXX) $(CPPFLAGS) -c $< -o $@

$(LIBTIKTOKEN): $(LIBOBJS)
	ar rcs $@ $(LIBOBJS)

clean:;
	rm -rf *.o runq run $(LIBOBJS) $(LIBTIKTOKEN)
