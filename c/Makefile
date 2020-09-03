.PHONY : install

definite : definite.c
	gcc -g -o definite definite.c

install : definite.c
	gcc -O2 -o definite definite.c
	cp definite /usr/local/bin
