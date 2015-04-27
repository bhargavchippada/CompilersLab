#ifndef Ast_h_included
#define Ast_h_included

#include "abstract_astnode.h"
#include "symbol_table.h"
#include <iostream>
#include <stdio.h>
#include <string>
#include <list>
#include <vector>
#include <fstream>
#include <iomanip>

using namespace std;

#define I 4
#define F 4

namespace // anonymous
{
    bool isParam = true;
    bool funType = true;
    string varType;
    int globalLabel = 1;
    vector<string> goblcodearray;

    symbTable *gobltable = new symbTable("gobl", NULL);
    symbTable *localtable = new symbTable("temp", gobltable);
    bool exitcode = false;
    ofstream outputFile("test.asm");

    regHandler *reghandler = new regHandler();

    void gencode(string s){
        goblcodearray.push_back(s);
    }

    int computelabel(int l1, int l2){
        if(l1==l2) return l1+1;
        else if(l1>l2) return l1;
        else return l2;
    }
} 

class ExpAst : public abstract_astnode {
    protected:
    string type="default";

	public:
    int label = -1;

    virtual void print (int level){
        cout<<string(level, ' ')<<"This is an abstract ExpAst class" << endl;
    }

    virtual string getType(){
        return type;
    }

    virtual string getExpStr(){
        return "Virtual expstr";
    }

    virtual bool validate(){
        cerr<<"Error! default validation"<<endl;
    }


    virtual bool isConstant(){
        return false;
    }

    virtual int labelcalc(bool left){
        label = -1;
        return label;
    }

    virtual void genCode(){
        gencode("\t\texpast dummy gen code");
    }
};

class StmtAst : public abstract_astnode {
    public:

    virtual void print (int level){
        cout<<string(level, ' ')<<"This is an abstract StmtAst class"<<endl;
    }

    virtual bool validate(){
        cerr<<"Error! stmtast default validation"<<endl;
    }

    virtual void genCode(){
        gencode("\t\tstmtast dummy gen code");
    }
};

class INTCONST : public ExpAst {
  protected:
    int Num;
    string type = "INT";

  public:
    int label = -1;

    INTCONST(int n){
    	Num = n;
    }

    void setValue(int n){
    	Num = n;
    }

    string getType(){
        return type;
    }

    int evaluate(){
    	return Num;
    }

    bool validate(){
        return true;
    }

    bool isConstant(){
        return true;
    }

    string getExpStr(){
        return "(IntConst "+to_string(Num)+")";
    }

    void print(int level){
    	cout<<string(level, ' ')<<"(IntConst_"<<label<<" "<<Num<<")";
    }

    int labelcalc(bool left){
        if(left) {
            label = 1;
            // gencode("\tmove("+to_string(Num)+","+reghandler->topstack()+");");
        }
        else {
            label = 0;
        }
        
        return label;
    }

    void genCode(){
        if(label == 1) {
            gencode("\tmove("+to_string(Num)+","+reghandler->topstack()+");");
        }
    }

};

class FLOATCONST : public ExpAst {
  protected:
    float Num;
    string type = "FLOAT";

  public:
    int label = -1;

    FLOATCONST(float f){
        Num = f;
    }

    void setValue(float f){
        Num = f;
    }

    string getType(){
        return type;
    }

    float evaluate(){
        return Num;
    }

    bool validate(){
        return true;
    }

    bool isConstant(){
        return true;
    }

    string getExpStr(){
        return "(FloatConst "+to_string(Num)+")";
    }

    void print(int level){
        cout<<string(level, ' ')<<"(FloatConst_"<<label<<" "<<Num<<")";
    }

    int labelcalc(bool left){
        if(left) {
            label = 1;
            // gencode("\tmove("+to_string(Num)+","+reghandler->topstack()+");");
        }
        else label = 0;
        
        return label;
    }

    void genCode(){
        if(label == 1) {
            gencode("\tmove("+to_string(Num)+","+reghandler->topstack()+");");
        }
    }
};

class STRINGCONST : public ExpAst {
  protected:
    string strlit;
    string type = "STRING";

  public:
    int label = -1;

    STRINGCONST(string s){
        strlit = s;
    }

    void setValue(string s){
        strlit = s;
    }

    string getType(){
        return type;
    }

    string evaluate(){
        return strlit;
    }

    bool validate(){
        return true;
    }

    bool isConstant(){
        return true;
    }

    string getExpStr(){
        return "(StringConst "+strlit+")";
    }

    void print(int level){
        cout<<string(level, ' ')<<"(StringConst_"<<label<<" "<<strlit<<")";
    }

    int labelcalc(bool left){
        if(left) label = 1;
        else label = 0;
        
        return label;
    }
};

class IDENTIFIERAST : public ExpAst {
  protected:
    string identifier;
    string type="NULL";

  public:
    int label = -1;

    IDENTIFIERAST(string s){
        identifier = s;
    }

    void setValue(string s){
        identifier = s;
    }

    string getType(){
        return type;
    }

    string getId(){
        return identifier;
    }

    string evaluate(){
        return identifier;
    }

    bool validate(){
        entity *ent = localtable->findInScope(identifier,"var");
        if(ent==NULL){
            cerr<<"Error! Variable is used without declaration: "+identifier<<endl;
            exitcode=true;
            return false;
        }else {
            type = ent->type;
            return true;
        }
    }

    string getExpStr(){
        return "(Id "+identifier+")";
    }

    void print(int level){
        cout<<string(level, ' ')<<"(Id_"<<label<<" \""<<identifier<<"\")";
    }

    int labelcalc(bool left){
       label = 1;
       
       return label;
    }
};

class ArrayRef : public ExpAst {
  protected:
    IDENTIFIERAST *identifier;
    list<ExpAst*> *expAstList;
    string type;

  public:
    int label = -1;

    ArrayRef(IDENTIFIERAST *id){
        identifier = id;
        expAstList = new list<ExpAst*>();
    }

    bool addExpAst(ExpAst *expast){
        if(expast->getType()!="INT"){
            cerr<<"Error! Invalid array index, not of type INT: "+expast->getExpStr()<<endl;
            exitcode=true;
            return false;
        }
    	(*expAstList).push_back(expast);
        return true;
    }

    string getType(){
        return type;
    }

    bool validate(){
        string varName = identifier->getId();
        entity *ent = localtable->findInScope(varName,"var");
        if(ent==NULL){
            cerr<<"Error! Variable is used without declaration: "+varName<<endl;
            exitcode=true;
            return false;
        }else{
            if(ent->dimensions.size() == expAstList->size()){
                type = ent->type;
                return true;
            }else{
                cerr<<"Error! Wrong number of indices: "+varName<<endl;
                exitcode=true;
                return false;
            }
        }
    }

    string getExpStr(){
        string expstr="";
        if(expAstList->size()==0){
            expstr+=identifier->getExpStr();
        }else{
            expstr+="(ArrayRef "+identifier->getExpStr();
            for (list<ExpAst*>::iterator it = expAstList->begin(); it != expAstList->end(); it++){
                expstr+="[";
                expstr+=(*it)->getExpStr();
                expstr+="]";
            }
            expstr+=")";
        }
        return expstr;
    }

    void print(int level){
        if(expAstList->size()==0){
            identifier->print(level);
        }else{
            cout<<string(level, ' ')<<"(ArrayRef_"<<label<<" ";
            identifier->print(0);
            for (list<ExpAst*>::iterator it = expAstList->begin(); it != expAstList->end(); it++){
                cout<<"[";
                (*it)->print(0);
                cout<<"]";
            }
            cout<<")";
        }
        
    }

    int labelcalc(bool left){
        label = identifier->labelcalc(true);

        for (list<ExpAst*>::iterator it = expAstList->begin(); it != expAstList->end(); it++){
            label = computelabel(label, (*it)->labelcalc(true));
        }
        
        return label;
    }

    int getOffset(){
        string varName = identifier->getId();
        entity *ent = localtable->findInScope(varName,"var");
        
        int offset = ent->offset;
        
        if (type == "INT"){
            offset = (offset >= 0 ? -offset - I : -offset);  // + I for ebp, -I beccause higher to lower addr stack
        }
        else if (type == "FLOAT"){
            offset = (offset >= 0 ? -offset - F : -offset + I - F);
        }

        if (ent->dimensions.size() == 0) {  // or expAstList->size() == 0
            return offset;
        }

        int prod = 1;
        for (int i = 0; i < ent->dimensions.size(); i++){
            prod = prod * ent->dimensions[i];
        }

        if (type == "INT"){
            prod *= I;  // + I for ebp, -I beccause higher to lower addr stack
        }
        else if (type == "FLOAT"){
            prod *= F;
        }

        int i = 0;
        for (list<ExpAst*>::iterator it = expAstList->begin(); it != expAstList->end(); it++)
        {
            prod /= (ent->dimensions[i]);

            (*it)->genCode();   // assuming the value is in eax

            gencode("\tmuli(-"+to_string(prod)+","+reghandler->topstack()+");");
        
            gencode("\tpushi(" + reghandler->topstack() + ");");

            i++;
        }

        gencode("\tmove(" + to_string(offset) + "," + reghandler->topstack()+");");
        string regtop = reghandler->pop();
        for (list<ExpAst*>::iterator it = expAstList->begin(); it != expAstList->end(); it++){
            gencode("\tloadi(ind(esp)," + reghandler->topstack()+");");
            gencode("\taddi("+reghandler->topstack() + "," + regtop + ");");
            gencode("\tpopi(1);");
        }

        reghandler->push(regtop);

        return 1;  // means it's not a constant offset i.e. present in ebx
    }

    void genCode(){
        int x = getOffset();
        if (x == 1){
            if (type == "INT")
                gencode("\tloadi(ind(ebp," + reghandler->topstack() + ")," + reghandler->topstack()  + ");");
            else
                gencode("\tloadf(ind(ebp," + reghandler->topstack() + ")," + reghandler->topstack()  + ");");
                
        }
        else{
            if (type == "INT")
                gencode("\tloadi(ind(ebp," + to_string(x)  + "), " + reghandler->topstack()  + ");");
            else 
                gencode("\tloadf(ind(ebp," + to_string(x)  + "), " + reghandler->topstack()  + ");");
        }
    }
};

class Cast : public ExpAst{
    protected:
        ExpAst *singleExpAst;
        string type;
    public:
        int label = -1;

        Cast(string ty, ExpAst *singleExp): type(ty), singleExpAst(singleExp){}
        
        string getType(){
            return type;
        }

        bool validate(){
            return true; // because this class is created only if its valid
        }

        string getExpStr(){
            return "(TO_"+type+" "+singleExpAst->getExpStr()+")";
        }

        void print(int level){
            cout<<string(level, ' ')<<"(TO_"<<type<<"_"<<label<<" ";
            singleExpAst->print(0);
            cout<<")";
        }

        int labelcalc(bool left){
            label = singleExpAst->labelcalc(true);
            
            return label;
        }

        void genCode(){
            singleExpAst->genCode();
            if (type == "INT"){
                gencode("\tfloatToint(" + reghandler->topstack() + ");");
            }
            if (type == "FLOAT"){
               gencode("\tintTofloat(" + reghandler->topstack() + ");");
            }
        }
};

class op2 : public ExpAst{
    protected:
        ExpAst *leftExpAst;
        ExpAst *rightExpAst;
        string op;
        string type="?";

    public:
        int label = -1;

        op2(ExpAst *left, string ope, ExpAst *right): leftExpAst(left), op(ope), rightExpAst(right){}

        string getType(){
            return type;
        }

        bool validate(){
            string ltype = leftExpAst->getType();
            string rtype = rightExpAst->getType();
            if(ltype=="INT" && rtype=="INT") type="INT";
            else if(ltype=="FLOAT" && rtype=="FLOAT") type="FLOAT";
            else if(ltype=="INT" && rtype=="FLOAT" && op!="ASSIGN"){
                if(op=="AND") {
                    // no casting required
                    type="INT";
                    return true;
                }
                //type cast left expast to float
                Cast *cast = new Cast("FLOAT",leftExpAst);
                leftExpAst = cast;
                type = "FLOAT";
            }else if(ltype=="INT" && rtype=="FLOAT" && op=="ASSIGN"){
                //type cast right expast to int
                Cast *cast = new Cast("INT",rightExpAst);
                rightExpAst = cast;
                type = "INT";
            }else if(ltype=="FLOAT" && rtype=="INT"){
                if(op=="AND") {
                    // no casting required
                    type="INT";
                    return true;
                }

                //type cast right expast
                Cast *cast = new Cast("FLOAT",rightExpAst);
                rightExpAst = cast;
                type = "FLOAT";
            }else{
                type="NULL";
                cerr<<"Error! Invalid operation ("+leftExpAst->getExpStr()+" of type "+ltype+") "+op+
                                            " ("+rightExpAst->getExpStr()+" of type "+rtype+")"<<endl;
                return false;
            }
                
            if(op=="ASSIGN") type = "VOID";
            return true;
        }

        string getExpStr(){
             return "("+op+"_"+type+" "+leftExpAst->getExpStr()+" "+rightExpAst->getExpStr()+")";
        }

        void print (int level){
            string ptype="";
            if(op!="ASSIGN") ptype= "_"+type;
            else ptype= "_"+leftExpAst->getType();
            cout<<string(level, ' ')<<"("<<op<<ptype<<"_"<<label<<" ";
            leftExpAst->print(0);
            cout<<" ";
            rightExpAst->print(0);
            cout<<")";
        }

        int labelcalc(bool left){
            label = leftExpAst->labelcalc(true);
            label = computelabel(label, rightExpAst->labelcalc(false));
            
            return label;
        }

        void genCode(){
            int l1 = leftExpAst->label;
            int l2 = rightExpAst->label;
            int maxregs = reghandler->max_regs;

            string topreg, secondreg;
            if (l1 >= l2 && l1 < maxregs){
                leftExpAst->genCode();
                topreg = reghandler->pop();
                rightExpAst->genCode();
                secondreg = reghandler->topstack();
                reghandler->push(topreg);
            }
            else if (l1 < l2 && l2 < maxregs){
                reghandler->swap();
                rightExpAst->genCode();
                secondreg = reghandler->pop();
                leftExpAst->genCode();
                topreg = reghandler->topstack();
                reghandler->push(secondreg);
                reghandler->swap();
            }

            else{
                rightExpAst->genCode();
                if (rightExpAst->getType() == "INT")
                    gencode("\tpushi(" + reghandler->topstack()  + ");");
                else
                    gencode("\tpushf(" + reghandler->topstack()  + ");");
                leftExpAst->genCode();
                topreg = reghandler->pop();
                secondreg = reghandler->topstack();
                reghandler->push(topreg);

                if (rightExpAst->getType() == "INT"){
                    gencode("\tloadi(ind(esp)," + secondreg  + ");");
                    gencode("\tpopi(1);");
                }
                else{
                    gencode("\tloadf(ind(esp)," + secondreg  + ");");
                    gencode("\tpopf(1);");
                }
            }



            if (op == "OR"){

            }
            else if (op == "AND"){

            }
            else if (op == "EQ_OP" || op == "NE_OP" || op == "LT" || op == "GT" || op == "LE_OP" || op == "GE_OP"){
                string relFunc;
                if (op == "EQ_OP")
                    relFunc = "je";
                else if (op == "NE_OP"){
                    relFunc = "jne";
                }
                else if (op == "LT"){
                    relFunc = "jl";
                }
                else if (op == "GT"){
                    relFunc = "jg";
                }
                else if (op == "LE_OP"){
                    relFunc = "jle";
                }
                else if (op == "GE_OP"){
                    relFunc = "jge";
                }

                int currentLabel = globalLabel;
                globalLabel++;

                if (rightExpAst->isConstant()){
                    if (leftExpAst->getType() == "INT")
                        gencode("\tcmpi(" + to_string(((INTCONST*)rightExpAst)->evaluate()) + "," + topreg + ");"); // or addf ??
                    else
                        gencode("\tcmpf(" +to_string(((FLOATCONST*) rightExpAst)->evaluate()) + "," + topreg + ");"); // or addf ??
                }
                else{
                    if (leftExpAst->getType() == "INT")
                        gencode("\tcmpi(" + secondreg + "," + topreg + ");"); // or addf ??
                    else
                        gencode("\tcmpf(" + secondreg + "," + topreg + ");"); // or addf ??   
                }
                
                gencode("\t" + relFunc + "(l" + to_string(currentLabel) + ");");
                if (leftExpAst->getType() == "INT")
                    gencode("\tmove(0," + topreg + ");");
                else
                    gencode("\tmove(0.000000," + topreg + ");");
                gencode("\tj(e" + to_string(currentLabel) + ");");
                gencode("\tl" + to_string(currentLabel) + ":");
                if (leftExpAst->getType() == "INT")
                    gencode("\tmove(1," + topreg + ");");
                else
                    gencode("\tmove(1.000000," + topreg + ");");
                gencode("\te" + to_string(currentLabel) + ":");

            }

            else if (op == "PLUS" || op == "MULT" || op == "DIV"){
                string aluop;
                if (op == "PLUS"){
                    aluop = "add";
                }
                else if (op == "MULT"){
                    aluop = "mul";
                }
                else if (op == "DIV"){
                    aluop = "div";
                }

                if (rightExpAst->isConstant()){
                    if (leftExpAst->getType() == "INT")
                        gencode("\t" + aluop + "i(" +to_string(((INTCONST*)rightExpAst)->evaluate()) + "," + topreg + ");"); // or addf ??
                    else
                        gencode("\t" + aluop + "f(" +to_string(((FLOATCONST*) rightExpAst)->evaluate()) + "," + topreg + ");"); // or addf ??
                }
                else{
                    if (leftExpAst->getType() == "INT")
                        gencode("\t" + aluop + "i(" + secondreg + "," + topreg + ");"); // or addf ??
                    else
                        gencode("\t" + aluop + "f(" + secondreg + "," + topreg + ");"); // or addf ??   
                }
            }

            else if (op == "MINUS"){
                if (rightExpAst->isConstant()){
                    if (leftExpAst->getType() == "INT")
                        gencode("\taddi(-" +to_string(((INTCONST*)rightExpAst)->evaluate()) + "," + topreg + ");"); // or addf ??
                    else
                        gencode("\taddf(-" +to_string(((FLOATCONST*) rightExpAst)->evaluate()) + "," + topreg + ");"); // or addf ??
                }
                else{
                    if (leftExpAst->getType() == "INT"){
                        gencode("\tmuli(-1," + secondreg + ");"); // or addf ??
                        gencode("\taddi(" + secondreg + "," + topreg + ");"); // or addf ??
                    }
                    else{
                        gencode("\tmulf(-1.0," + secondreg + ");"); // or addf ??
                        gencode("\taddf(" + secondreg + "," + topreg + ");"); // or addf ??   
                    }
                }
            }

            else if (op == "ASSIGN"){

            }

        }

};

class op1 : public ExpAst{
    protected:
        ExpAst *singleExpAst;
        string op;
        string type="?";

    public:
        int label = -1;

        op1(string ope, ExpAst *singleExp): op(ope), singleExpAst(singleExp){}
	    
        string getType(){
            return type;
        }

        bool validate(){
            string exptype = singleExpAst->getType();
            if(exptype=="INT") type="INT";
            else if(exptype=="FLOAT") type="FLOAT";
            else {
                type="NULL";
                cerr<<"Error! Cannot apply unary operator to type "+singleExpAst->getType()+" of "+singleExpAst->getExpStr()<<endl;
                return false;
            }
            return true;
        }

        string getExpStr(){
             return "("+op+"_"+type+" "+singleExpAst->getExpStr()+")";
        }

	    void print(int level){
	        cout<<string(level, ' ')<<"("<<op<<"_"<<type<<"_"<<label<<" ";
	        singleExpAst->print(0);
            cout<<")";
	    }

        int labelcalc(bool left){
            label = singleExpAst->labelcalc(true);
            return label;
        }

        void genCode(){

            singleExpAst->genCode();
            if (op == "NOT"){
                int currentLabel = globalLabel;
                globalLabel++;
                gencode("\tcmpi(0," + reghandler->topstack() + ");");
                gencode("\tjne(l" + to_string(currentLabel) + ");");
                gencode("\tmove(0," + reghandler->topstack() + ");");
                gencode("\tj(e" + to_string(currentLabel) + ");");
                gencode("\tl" + to_string(currentLabel) + ":");
                gencode("\tmove(1," + reghandler->topstack() + ");");
                gencode("\te" + to_string(currentLabel) + ":");
            }
            else if (op == "UMINUS"){
                if (type == "INT"){
                    gencode("\tmuli(-1," + reghandler->topstack() + ");");
                }
                else{
                    gencode("\tmulf(-1," + reghandler->topstack() + ");");
                }
            }
        }
};

class FUNCALL : public ExpAst{
	protected:
		IDENTIFIERAST *funcName;
		list<ExpAst*> *expSequence;
        string type;
	
	public:
		FUNCALL(IDENTIFIERAST *iden){
            funcName=iden;
            expSequence = new list<ExpAst*>();
        }

		void addExpAstList(list<ExpAst*> *expastlist){
			expSequence=expastlist;
		}

        string getType(){
            return type;
        }

        bool validate(){
            string varName = funcName->getId();

            entity* ent = localtable->findFunctionInScope(varName); 
            entity *entVar = localtable->findInScope(varName,"var");
            
            if (entVar != NULL){
                cerr<<"Error! Cannot be used as a function: "+ varName<<endl;
                return false;
            }
            else if(ent == NULL){
                cerr<<"Error! No matching function with the given no of parameters: "+varName<<endl;
                return false;
            }
            else{
                symbTable *func = ent->funcPtr;
                type = func->returntype;

                list<ExpAst*>::iterator it = expSequence->begin();
                int i;
                for(i=0; i<func->numofparams && it != expSequence->end(); i++){
                    string ltype = func->symtable[i]->type;
                    string rtype = (*it)->getType();
                    if(ltype=="INT" && rtype=="INT");
                    else if(ltype=="FLOAT" && rtype=="FLOAT");
                    else if(ltype=="INT" && rtype=="FLOAT"){
                        //type cast right expast to int
                        Cast *cast = new Cast("INT",(*it));
                        (*it) = cast;
                    }else if(ltype=="FLOAT" && rtype=="INT"){
                        //type cast right expast
                        Cast *cast = new Cast("FLOAT",*it);
                        *it = cast;
                    }else{
                        cerr<<"Error! Type mismatch for parameter "<<(i+1)<<" of the function "+funcName->getExpStr()<<endl;
                        return false;
                    }

                    it++;
                }

                if (i != func->numofparams or it != expSequence->end()){
                    cerr << "Incorrect no. of parameters: " + varName << endl;
                    return false;
                }

                
                return true;
            }
        }

        string getExpStr(){
            string expstr="(FunCall "+funcName->getExpStr()+"{";
            for (list<ExpAst*>::iterator it = expSequence->begin(); it != expSequence->end();){
                expstr+=(*it)->getExpStr();
                it++;
                if(it != expSequence->end()) expstr+=",";
            }
            expstr+="}";
            return expstr;
        }

		void print(int level){
            cout<<string(level, ' ')<<"(FunCall ";
			funcName->print(0);
            cout<<"{";
			for (list<ExpAst*>::iterator it = expSequence->begin(); it != expSequence->end();){
				(*it)->print(0);
                it++;
                if(it != expSequence->end()) cout<<",";
			}
            cout<<"})";
		}

        void genCode(){

        }

};

class BlockStmt : public StmtAst{
    protected:
        list<StmtAst*> *stmtSequence;
    public:
        BlockStmt(list<StmtAst*> *stmtSeq){
            stmtSequence = stmtSeq;
        }

        void print(int level){
            cout<<string(level, ' ')<<"(Block ["<<endl;
            for (list<StmtAst*>::iterator it = stmtSequence->begin(); it != stmtSequence->end();){
                (*it)->print(level+8);
                it++;
                cout<<endl;
            }
            cout<<string(level+7, ' ')<<"])";
        }

        void genCode(){
            for (list<StmtAst*>::iterator it = stmtSequence->begin(); it != stmtSequence->end();){
                (*it)->genCode();
                gencode("\n");
                it++;
            }
        }
};

class ReturnStmt : public StmtAst{
    protected:
        ExpAst *returnExp;
    public:
        ReturnStmt(ExpAst *expast){
            returnExp = expast;
        }

        bool validate(){
            if(localtable->returntype=="VOID"){
                cerr<<"Error! Function return type is VOID, return statement is not allowed for function "<<localtable->tablename<<endl;
                return false;
            }

            string ltype = returnExp->getType();
            string rtype = localtable->returntype;
            if(ltype == "INT" and rtype == "INT") return true;
            else if(ltype == "FLOAT" and rtype == "FLOAT") return true;
            else if(ltype == "FLOAT" and rtype == "INT") {
                Cast *cast = new Cast("INT",returnExp);
                returnExp = cast;
                return true;
            }
            else if(rtype == "FLOAT" and ltype == "INT") {
                Cast *cast = new Cast("FLOAT",returnExp);
                returnExp = cast;
                return true;
            }
            else{
                cerr<<"Error! Incorrect return type: "+returnExp->getType()+" of "+returnExp->getExpStr()+
                " when "+localtable->returntype+" is expected"<<endl;
                return false;
            }
        }

        void print(int level){
            cout<<string(level, ' ')<<"(Return ";
            returnExp->print(0);
            cout<<")";
        }

        void genCode(){
            returnExp->labelcalc(false);
        }

};

class AssStmt : public StmtAst{
    protected:
        ExpAst *leftExpAst;
        ExpAst *rightExpAst;
    public:
        AssStmt(ExpAst *left, ExpAst *right): leftExpAst(left), rightExpAst(right){}
        
        bool validate(){
            string ltype = leftExpAst->getType();
            string rtype = rightExpAst->getType();
            if(ltype=="INT" && rtype=="INT") return true;
            else if(ltype=="FLOAT" && rtype=="FLOAT") return true;
            else if(ltype=="INT" && rtype=="FLOAT"){
                //type cast right expast to int
                Cast *cast = new Cast("INT",rightExpAst);
                rightExpAst = cast;
            }else if(ltype=="FLOAT" && rtype=="INT"){
                //type cast right expast
                Cast *cast = new Cast("FLOAT",rightExpAst);
                rightExpAst = cast;
            }else{
                cerr<<"Error! Invalid assignment ("+leftExpAst->getExpStr()+" of type "+ltype+") "+"="+
                                            " ("+rightExpAst->getExpStr()+" of type "+rtype+")"<<endl;
                return false;
            }
                
            return true;
        }

        void print (int level){
            cout<<string(level, ' ')<<"(Ass_"+leftExpAst->getType()+" ";
            leftExpAst->print(0);
            cout<<" ";
            rightExpAst->print(0);
            cout<<")";
        }

        void genCode(){
            rightExpAst->labelcalc(false);
            leftExpAst->labelcalc(false);

            rightExpAst->genCode();
            leftExpAst->genCode();
        }
};

class IfStmt : public StmtAst{
    protected:
        ExpAst *ifExpAst;
        StmtAst *thenStmtAst;
        StmtAst *elseStmtAst;

    public:
        IfStmt(ExpAst *ifexp, StmtAst *thenstmt, StmtAst *elsestmt): ifExpAst(ifexp), thenStmtAst(thenstmt), elseStmtAst(elsestmt){}
        
        void print (int level){
            cout<<string(level, ' ')<<"(If ";
            ifExpAst->print(0);
            cout<<endl;
            thenStmtAst->print(level+4);
            cout<<endl;
            elseStmtAst->print(level+4);
            cout<<")";
        }

        void genCode(){
            ifExpAst->labelcalc(false);
        }
};

class emptyStmt : public StmtAst{
    protected:

    public:
        void print (int level){
            cout<<string(level, ' ')<<"(Empty)";
        }

        void genCode(){
            
        }
};

class WhileStmt : public StmtAst{
    protected:
        ExpAst *whileExpAst;
        StmtAst *thenStmtAst;

    public:
        WhileStmt(ExpAst *whileexp, StmtAst *thenstmt): whileExpAst(whileexp), thenStmtAst(thenstmt){}
        
        void print (int level){
            cout<<string(level, ' ')<<"(While ";
            whileExpAst->print(0);
            cout<<endl;
            thenStmtAst->print(level+7);
            cout<<")";
        }

        void genCode(){
            whileExpAst->labelcalc(false);
        }
};

class ForStmt : public StmtAst{
    protected:
        ExpAst *for1ExpAst;
        ExpAst *for2ExpAst;
        ExpAst *for3ExpAst;
        StmtAst *thenStmtAst;   

    public:
        ForStmt(ExpAst* for1, ExpAst *for2, ExpAst *for3, StmtAst *thenstmt): for1ExpAst(for1), for2ExpAst(for2), for3ExpAst(for3), thenStmtAst(thenstmt){}

        void print (int level){
            cout<<string(level, ' ')<<"(For ";
            for1ExpAst->print(0);
            cout<<endl;
            for2ExpAst->print(level+5);
            cout<<endl;
            for3ExpAst->print(level+5);
            cout<<endl;
            thenStmtAst->print(level+5);
            cout<<")";
        }

        void genCode(){
            for1ExpAst->labelcalc(false);
            for2ExpAst->labelcalc(false);
            for3ExpAst->labelcalc(false);
        }
};

class FuncallStmt : public StmtAst{
    protected:
        IDENTIFIERAST *funcName;
        list<ExpAst*> *expSequence;
        string type;
    
    public:
        FuncallStmt(IDENTIFIERAST *iden){
            funcName=iden;
            expSequence = new list<ExpAst*>();
        }

        void addExpAstList(list<ExpAst*> *expastlist){
            expSequence=expastlist;
        }

        string getType(){
            return type;
        }

        bool validate(){
            string varName = funcName->getId();

            entity* ent = localtable->findFunctionInScope(varName); 
            entity *entVar = localtable->findInScope(varName,"var");
            
            if (entVar != NULL){
                cerr<<"Error! Cannot be used as a function: "+ varName<<endl;
                return false;
            }
            else if(ent == NULL){
                if (varName == "printf")
                    return true;
                cerr<<"Error! No matching function with the given no of parameters: "+varName<<endl;
                return false;
            }
            else{
                symbTable *func = ent->funcPtr;
                type = func->returntype;

                list<ExpAst*>::iterator it = expSequence->begin();
                int i;
                for(i=0; i<func->numofparams && it != expSequence->end(); i++){
                    string ltype = func->symtable[i]->type;
                    string rtype = (*it)->getType();
                    if(ltype=="INT" && rtype=="INT");
                    else if(ltype=="FLOAT" && rtype=="FLOAT");
                    else if(ltype=="INT" && rtype=="FLOAT"){
                        //type cast right expast to int
                        Cast *cast = new Cast("INT",(*it));
                        (*it) = cast;
                    }else if(ltype=="FLOAT" && rtype=="INT"){
                        //type cast right expast
                        Cast *cast = new Cast("FLOAT",*it);
                        *it = cast;
                    }else{
                        cerr<<"Error! Type mismatch for parameter "<<(i+1)<<" of the function "+funcName->getExpStr()<<endl;
                        return false;
                    }

                    it++;
                }

                if (i != func->numofparams or it != expSequence->end()){
                    cerr << "Incorrect no. of parameters: " + varName << endl;
                    return false;
                }

                
                return true;
            }
        }

        string getExpStr(){
            string expstr="(FuncallStmt "+funcName->getExpStr()+"{";
            for (list<ExpAst*>::iterator it = expSequence->begin(); it != expSequence->end();){
                expstr+=(*it)->getExpStr();
                it++;
                if(it != expSequence->end()) expstr+=",";
            }
            expstr+="}";
            return expstr;
        }

        void print(int level){
            cout<<string(level, ' ')<<"(FuncallStmt ";
            funcName->print(0);
            cout<<"{";
            for (list<ExpAst*>::iterator it = expSequence->begin(); it != expSequence->end();){
                (*it)->print(0);
                it++;
                if(it != expSequence->end()) cout<<",";
            }
            cout<<"})";
        }

        void genCode(){
            string varName = funcName->getId();
            if (varName == "printf"){

                for (list<ExpAst*>::iterator it = expSequence->begin(); it != expSequence->end(); it++){
                    if ((*it)->getType() == "STRING"){
                        gencode("\tprint_string(" + ((STRINGCONST*) (*it))->evaluate() + ");");
                    }
                    else if ((*it)->isConstant()){
                        if ((*it)->getType() == "INT"){
                            gencode("\tprint_int(" + to_string(((INTCONST*) (*it))->evaluate()) + ");");
                        }                        
                    

                        else if ((*it)->getType() == "FLOAT"){
                            gencode("\tprint_float(" + to_string(((FLOATCONST*) (*it))->evaluate()) + ");");
                        }
                    }
                    else{
                        (*it)->genCode();
                        if ((*it)->getType() == "INT"){
                            gencode("\tprint_int(" + reghandler->topstack() + ");");
                        }                        

                        else if ((*it)->getType() == "FLOAT"){
                            gencode("\tprint_float(" + reghandler->topstack() + ");");
                        }
                    }
                }
                gencode("\tprint_char('\\n');");           
            }
        }
};


#endif