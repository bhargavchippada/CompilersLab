
all: clean execute ast

execute:
	rm -f Scanner*;
	flexc++ lex.l;
	#sed -i '/include/a #include "Parserbase.h"' Scanner.ih;
	bisonc++ parse.y;
	sed -i '/Frank B. Brokken/a bool isParam = true; string varType; symbTable *localtable = new symbTable("temp", gobltable);' parse.cc;
	sed -i '/Frank B. Brokken/a symbTable *gobltable = new symbTable("gobl", NULL);' parse.cc;
	#sed -i '/insert preincludes/a #include "ASTClasses.ih"' Parserbase.h;
	#sed -i '/include "Parser.ih"/a #include "ASTClasses.ih"' parse.cc;
	./sedscript
	g++ --std=c++0x lex.cc parse.cc main.cc;

clean:
	rm -f Scanner*
	rm -f ./a.out
	rm -f lex.cc
	rm -f parse.cc
	rm -f Parser*
	rm -f astjunk

ast:
	./a.out < test > astjunk;
