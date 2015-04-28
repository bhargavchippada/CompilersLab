#ifndef symbol_table_h_included
#define symbol_table_h_included

#include <iostream>
#include <stdio.h>
#include <string>
#include <vector>
#include <stack>
#include <map>

using namespace std;

#define I 4
#define F 4

struct symbTable;

struct regHandler{
	vector<string> allregs;
	map<string,string> regdesp;

	stack<string> regs;
	int max_regs;

	regHandler(){
		max_regs = 2;
		//regs.push("esi");
		//regs.push("edi");
		//regs.push("edx");
		//regs.push("ecx");
		regs.push("ebx");
		regs.push("eax");
		regdesp["ebx"] = "NULL";
		regdesp["eax"] = "NULL";

		allregs.push_back("ebx");
		allregs.push_back("eax");
	}

	string topstack(){
		if(regs.size()==0) {
			cerr<<"registers stack empty!"<<endl;
			return "NULL";
		}
		return regs.top();
	}

	string pop(){
		if(regs.size()==0) {
			cerr<<"registers stack empty!"<<endl;
			return "NULL";
		}
		string s = regs.top();
		regs.pop();
		return s;
	}

	void push(string s){
		regs.push(s);
	}

	int size(){
		return regs.size();
	}

	void swap(){
		string top = pop();
		string second = pop();
		regs.push(top);
		regs.push(second);
	}

	

};


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
	}
	
};


struct symbTable{
	string tablename, returntype;
	int numofparams=0;
	vector<entity*> symtable;
	symbTable* parentPtr;
	int paramoffset, offset;

	symbTable(string n, symbTable* ptr){
		tablename = n;
		parentPtr = ptr;
		paramoffset = 0;
		offset = 0;
	}

	int giveSize(string s){
		if (s == "INT") return I;
		if (s == "FLOAT") return F;
		if (s == "VOID") return 0;
		return -1;
	}

	int totalParameterOffset(){
		int res = 0;
		for(int i=0; i<symtable.size();i++){
			if (res < -(symtable[i]->offset))
				res = -(symtable[i]->offset);
		}
		return res;
	}

	int totalLocalOffset(){
		return offset;
	}

	entity* find(string varName){
		for(int i=0; i<symtable.size();i++){
			if(symtable[i]->name==varName) return symtable[i];
		}
		return NULL;
	}

	entity* findInScope(string varName, string varType){
		for(int i=0; i<symtable.size();i++){
			if(symtable[i]->name==varName && symtable[i]->varType==varType) return symtable[i];
		}
		if(parentPtr!=NULL) return parentPtr->findInScope(varName,varType);
		return NULL;
	}

	entity* findFunctionInScope(string varName){
		for(int i=0; i<symtable.size();i++){
			if(symtable[i]->name==varName && symtable[i]->varType=="fun") return symtable[i];
		}
		if(parentPtr!=NULL) return parentPtr->findFunctionInScope(varName);
		return NULL;
	}

	int addArray(string arrayName, int dimension, bool isParam){
		if(dimension<=0){
			cerr<<"Error! Invalid indice "<<dimension<<" for array "<<arrayName<<endl;
			return -1;
		}

		entity *var = find(arrayName);
		if(var==NULL){
			// can't arise
			cerr << "Error! " << arrayName << " not defined!\n";
			return -1;
		}else{
			if(isParam) {
				paramoffset += var->size;
				paramoffset -= (var->size * dimension);
				var->size = (var->size * dimension);
				var->offset = paramoffset;
				var->dimensions.push_back(dimension);
			}else{
				offset -= var->size;
				var->offset = offset;
				offset += (var->size * dimension);
				var->size = (var->size * dimension);
				var->dimensions.push_back(dimension);
			}
		}

		return 0;
	}

	int addEntity(string n, string t, string ty, bool isParam, symbTable* pptr){
		entity *var;
		if(t == "var") var = find(n);
		else {
			var = findFunctionInScope(n);
		}
		if (var != NULL){
			cerr << "Error! Previously defined "+t+": "  << n  << "\n";
			return -1;
		}

		int s = giveSize(ty);

		if (t == "var" && s==0){
			//means variable of type void which is not valid
			cerr << "Error! Variable declaration of type void is not valid: "  << n  << endl;
			return -1;
		}
		
		if (t == "fun") s = 0;
		if(isParam) {
			paramoffset-=s;
			entity *newEntity = new entity(n, t, ty, s, paramoffset, pptr);
			symtable.push_back(newEntity);
		}else{
			entity *newEntity = new entity(n, t, ty, s, offset,pptr);
			offset+=s;
			symtable.push_back(newEntity);
		}

		return 0;
	}


	bool inScope(string varName){
		entity *var = find(varName);
		if (var == NULL){
			if(parentPtr!=NULL){
				return parentPtr->inScope(varName);
			}
			cerr << "Error! Undeclared variable : " << varName << "\n";
			return false;
		}else{
			return true;
		}
	}

	string giveVarType(string varName){
		entity *var = find(varName);
		if (var == NULL){
			if(parentPtr!=NULL){
				return parentPtr->giveVarType(varName);
			}
			return "NULL"; // or "NOT FOUND"
		}else{
			return var->varType;
		}
	}

	string giveType(string varName){
		entity *var = find(varName);
		if (var == NULL){
			if(parentPtr!=NULL){
				return parentPtr->giveType(varName);
			}
			return "NULL"; // or "NOT FOUND"
		}else{
			return var->type;
		}
	}

	void printTable(){
		cout << "----------------------\nTable Name : "<<tablename<<"\n";
		if (parentPtr != NULL) cout << "Return Type : "<< returntype <<"\n";
		cout<<"Num of params: "<<numofparams<<"\n\n";
		for(int i=0; i<symtable.size();i++){
			symtable[i]->printVarInfo();
			if(symtable[i]->varType == "fun" and (symtable[i]->funcPtr) != NULL){
				(symtable[i]->funcPtr)->printTable();
			}
			cout<<endl;
		}
		if(parentPtr==NULL) cout << "Table Type : Global\n";
		else cout << "Table Type : Local\n";
		cout << "----------------------\n";
	}
};

#endif
