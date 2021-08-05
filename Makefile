.PHONY: clean
.SUFFIXES: .c .o .a

VPATH=bin include lib src

vpath %.c src
vpath %.so lib
vpath %.a lib
vpath %.h include
vpath thebeatles bin

thebeatles: thebeatles.o libjp.a libgr.so
	gcc -o  $@ $^ -I./include -L./lib
	#mv $@ bin

libgr.so: pg.o pr.o #shared library
	$(CC) $(CFLAGS) -shared -o $@ $^ -I./include -L./lib
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:lib
	mv $@ lib

libjp.a: pj.o pp.o #archive library
	$(AR) -rs $@ $^
	mv $@ lib

.o: pg.c pj.c pp.c pr.c
	gcc -c $^ -I./include -L./lib

clean:
	rm -f *.o
	rm -f lib/*.so
	rm -f lib/*.a
	rm -f bin/thebeatles