#ifndef abstract_astnode_h_included
#define abstract_astnode_h_included

#include <iostream>
#include <stdio.h>

using namespace std;

class abstract_astnode
{
	public:
	virtual void print (int level){
		cout<<string(level, ' ')<<"This is an abstract class"<<endl;
	}
	
	//virtual std::string generate_code(const symbolTable&) = 0;
	//virtual basic_types getType() = 0;
	//virtual bool checkTypeofAST() = 0;
	protected:
	//virtual void setType(basic_types) = 0;
	private:
	//typeExp astnode_type;
};

#endif