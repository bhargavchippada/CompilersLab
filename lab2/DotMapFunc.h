#ifndef DotMapFunc_h_included
#define DotMapFunc_h_included

#include <string>
#include <iostream>

void DotGraphMapping(std::string child, int child_id, std::string parent, int parent_id){
	std::cout<<"\""<<parent<<" ("<<parent_id<<")\" -> \""<<child<<" ("<<child_id<<")\";"<<std::endl;
}

#endif