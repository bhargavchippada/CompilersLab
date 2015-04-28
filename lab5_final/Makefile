
all: clean execute ast run

execute:
	rm -f Scanner*;
	flexc++ lex.l;
	bisonc++ parse.y;
	sed -i '/Frank B. Brokken/a extern bool isParam; extern string varType; extern symbTable *localtable;' parse.cc;
	sed -i '/Frank B. Brokken/a extern symbTable *gobltable;' parse.cc;
	./sedscript
	g++ --std=c++0x lex.cc parse.cc main.cc;

clean:
	rm -f Scanner*
	rm -f ./a.out executable
	rm -f lex.cc
	rm -f parse.cc
	rm -f Parser*
	rm -f astjunk

ast:
	./a.out < test.cpp > astjunk;

run: executable
	./executable

executable: machine.cc test.asm
	g++ -Wno-write-strings -g3 -O0 machine.cc -o executable

