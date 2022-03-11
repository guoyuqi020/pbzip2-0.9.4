# Make file for parallel BZIP2
SHELL=/bin/sh

# Compiler to use
CC=/Data2/guoyq/InstrumentTool_build/bin/clang++

# Where you want pbzip2 installed when you do 'make install'
PREFIX=/Data2/guoyq/program_install

all: pbzip2

# Standard pbzip2 compile
pbzip2: pbzip2.cpp
	$(CC) -O0 -g -fsanitize=trace -o pbzip2 pbzip2.cpp -pthread -lpthread -lbz2

# Choose this if you want to compile in a static version of the libbz2 library
pbzip2-static: libbz2.a pbzip2.cpp
	$(CC) -O0 -g -fsanitize=trace -o pbzip2 pbzip2.cpp -pthread -lpthread -I. -L. -lbz2

# Compatability mode for 32bit file sizes (less than 2GB) and systems
# that have compilers that treat int as 64bit natively (ie: modern AIX)
pbzip2-compat: pbzip2.cpp
	$(CC) -O0 -g -fsanitize=trace -o pbzip2 pbzip2.cpp -pthread -lpthread -lbz2

# Install the binary pbzip2 program and man page
install: pbzip2
	if ( test ! -d $(PREFIX)/bin ) ; then mkdir -p $(PREFIX)/bin ; fi
	if ( test ! -d $(PREFIX)/man ) ; then mkdir -p $(PREFIX)/man ; fi
	if ( test ! -d $(PREFIX)/man/man1 ) ; then mkdir -p $(PREFIX)/man/man1 ; fi
	cp -f pbzip2 $(PREFIX)/bin/pbzip2
	chmod a+x $(PREFIX)/bin/pbzip2
	cp -f pbzip2.1 $(PREFIX)/man/man1
	chmod a+r $(PREFIX)/man/man1/pbzip2.1

clean:
	rm *.o pbzip2
