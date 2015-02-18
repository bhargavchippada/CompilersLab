
all: clean execute graph

execute:
	rm -f Scanner*;
	flexc++ lex.l;
	sed -i '/include/a #include "Parserbase.h"' Scanner.ih;
	bisonc++ parse.y;
	sed -i '/Frank B. Brokken/a int count=0;' parse.cc;
	sed -i '/include "Parser.ih"/a #include "DotMapFunc.h"' parse.cc;
	g++ --std=c++0x lex.cc parse.cc main.cc;

clean:
	rm -f Scanner*
	rm -f ./a.out
	rm -f lex.cc
	rm -f parse.cc
	rm -f Parser*
	rm -f graph*

graph:
	echo "digraph G{" >graph.gv;
	echo "ordering = out;" >>graph.gv
	./a.out < test >> graph.gv;
	echo "}" >> graph.gv;
	dot -Tps graph.gv -o graph.ps;
