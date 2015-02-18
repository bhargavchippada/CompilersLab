all: lex.l tokens driver.cc
	rm -f Scanner*;
	flexc++ lex.l;
	sed -i '/int lex()/r tokens' Scanner.h;
	g++ --std=c++11 lex.cc driver.cc;
clean:
	rm -f Scanner*
	rm ./a.out
	rm lex.cc


