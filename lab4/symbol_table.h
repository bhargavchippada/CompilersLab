#ifndef symbol_table_h_included
#define symbol_table_h_included

#include <iostream>
#include <stdio.h>
#include <string>
#include <vector>
#include <map>

using namespace std;

struct symbTable;

struct entity{
	string name;
	string varType;		// var or fun
	string type;	// int float		
	int size;
	int offset;
	vector<int> dimensions;
	symbTable* funcPtr;

	entity(){}
	entity(string n, string t, string ty, int s, int o, symbTable* ptr) : name(n), varType(t), type(ty), size(s), offset(o), funcPtr(ptr){}
	
	
	void printVarInfo(){
		cout<< "symbol name: " << name << "\n";
		cout << "var/fun : " << varType << "\n";
		cout << "type/return.type : " << type << "\n";
		cout << "size : " << size << "\n";
		cout << "offset : " << offset << "\n";
		
		if(dimensions.size() != 0){
			cout << "Array: ";
			for(int i = 0; i < dimensions.size(); i++){
				cout << " [" << dimensions[i] << "] ";
			}
			cout << endl;
		}
		// if(funcPtr==NULL) cout << "Entity Type : local variable\n";
		// else funcPtr->printTable();
	}
	
};


struct symbTable{
	string tablename, returntype;
	map<string, entity> table;		// maps variable name to entity
	symbTable* parentPtr;
	int paramoffset, offset;

	symbTable(string n, symbTable* ptr){
		tablename = n;
		parentPtr = ptr;
		paramoffset = 0;
		offset = 0;
	}

	int giveSize(string s){
		if (s == "int") return 4;
		if (s == "float") return 8;
		if (s == "void") return 0;
		return -1;
	}

	void addArray(string arrayName, int dimension, bool isParam){
		map<string, entity> :: iterator mapItr = table.find(arrayName);
		if (mapItr == table.end()){
			// can't arise
			cout << "Error: " << arrayName << " not defined!\n";
		}
		else{
			if(isParam) {
				paramoffset += (mapItr->second).size;
				paramoffset -= ((mapItr->second).size * dimension);
				(mapItr->second).size = ((mapItr->second).size * dimension);
				(mapItr->second).offset = paramoffset;
				(mapItr->second).dimensions.push_back(dimension);
			}else{
				offset -= (mapItr->second).size;
				(mapItr->second).offset = offset;
				offset += ((mapItr->second).size * dimension);
				(mapItr->second).size = ((mapItr->second).size * dimension);
				(mapItr->second).dimensions.push_back(dimension);
			}
		}
	}

	int addEntity(string n, string t, string ty, bool isParam, symbTable* pptr){
		map<string, entity> :: iterator mapItr = table.find(n);
		if (mapItr != table.end()){
			cerr << "Previously defined: "  << n  << "\n";
			return -1;
		}

		int s = giveSize(ty);
		if (t == "fun") s = 0;
		if(isParam) {
			paramoffset-=s;
			entity newEntity(n, t, ty, s, paramoffset, pptr);
			table.insert(map<string, entity>::value_type(n, newEntity));
		}else{
			entity newEntity(n, t, ty, s, offset,pptr);
			offset+=s;
			table.insert(map<string, entity>::value_type(n, newEntity));
		}
		return 0;
	}


	bool inScope(string varName){
		map<string, entity> :: iterator mapItr = table.find(varName);
		if (mapItr == table.end()){
			if(parentPtr!=NULL){
				return parentPtr->inScope(varName);
			}
			cerr << "Undeclared variable : " << varName << "\n";
			return false;
		}else{
			return true;
		}
	}

	string giveVarType(string varName){
		map<string, entity> :: iterator mapItr = table.find(varName);
		if (mapItr == table.end()){
			if(parentPtr!=NULL){
				return parentPtr->giveVarType(varName);
			}
			return "NULL"; // or "NOT FOUND"
		}else{
			return (mapItr->second).varType;
		}
	}

	string giveType(string varName){
		map<string, entity> :: iterator mapItr = table.find(varName);
		if (mapItr == table.end()){
			if(parentPtr!=NULL){
				return parentPtr->giveType(varName);
			}
			return "NULL"; // or "NOT FOUND"
		}else{
			return (mapItr->second).type;
		}
	}

	void printTable(){
		cout << "----------------------\nTable Name : "<<tablename<<"\n";
		if (parentPtr != NULL) cout << "Return Type : "<< returntype <<"\n\n";
		map<string, entity> :: iterator mapItr = table.begin();
		while(mapItr != table.end()){
			(mapItr->second).printVarInfo();
			
			if((mapItr->second).varType == "fun" and ((mapItr->second).funcPtr) != NULL){
				((mapItr->second).funcPtr)->printTable();
			}
			
			mapItr++;
			cout<<endl;
		}
		if(parentPtr==NULL) cout << "Table Type : Global\n";
		else cout << "Table Type : Local\n";
		cout << "----------------------\n";
	}
};



// entity::entity(string n, string t, string ty, int s, int o, symbTable* ptr) : name(n), varType(t), type(ty), size(s), offset(o), funcPtr(ptr){}

// void entity::printVarInfo(){
// 		cout<< "symbol name: " << name << "\n";
// 		cout << "var/fun : " << varType << "\n";
// 		cout << "type/return.type : " << type << "\n";
// 		cout << "size : " << size << "\n";
// 		cout << "offset : " << offset << "\n";
		
// 		if(funcPtr==NULL) cout << "Entity Type : local variable\n";
// 		else funcPtr->printTable();
// 	}
//ebp -> base pointer
/*



struct globalSymbolTable{
	map<string, symbTable> GST;			// maps function name to symbol table of function
	map<string, symbTable> :: iterator globItr;

	// If a global offset is used
	int currentOffset;

	globalSymbolTable(){
		currentOffset = 0;	// may be different
		GST.clear();
	}

	void addEntityToFunction(string funcName, string varName, string type, int size, bool isPar){
		globItr = GST.find(funcName);
		if (globItr == GST.end()){
			symbTable* newSymbTable = new symbTable();
			GST[funcName] = *newSymbTable;
			globItr = GST.find(funcName);
		}
		
		(globItr->second).addEntity(varName, type, size, isPar, currentOffset);
		currentOffset+=size;
	}

	bool inScopeOfFunction(string funcName, string varName){
		globItr = GST.find(funcName);
		if (globItr == GST.end()) return false;
		return (globItr->second).inScope(varName);
	}

	string giveTypeInFunction(string funcName, string varName){			// inherited attribute and varname lexeme
		globItr = GST.find(funcName);
		if (globItr == GST.end()) return "NULL"; // i.e. function doesn't exists
		return (globItr->second).giveType(varName);
	}

	void printAll(){
		printf("%s\n\n", "Printing global symbol table: ");
		globItr = GST.begin();
		while(globItr != GST.end()){
			cout << "Printing local symbol table of function " << globItr->first << " :\n";
			(globItr->second).printLocalTable();
			globItr++;
		}
	}
};
*/


#endif
