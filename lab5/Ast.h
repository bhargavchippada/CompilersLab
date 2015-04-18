#ifndef Ast_h_included
#define Ast_h_included

#include "abstract_astnode.h"
#include "symbol_table.h"
#include <iostream>
#include <stdio.h>
#include <string>
#include <iomanip>
#include <list>
#include <vector>
#include <fstream>

using namespace std;

namespace // anonymous
{
    bool isParam = true;
    bool funType = true;
    string varType;
    int globalLabel = 1;
    symbTable *gobltable = new symbTable("gobl", NULL);
    symbTable *localtable = new symbTable("temp", gobltable);
    bool exitcode = false;
    ofstream outputFile("test.asm");
}

class ExpAst : public abstract_astnode {
    protected:
    string type="default";
    int label;              //  number of registers required

	public:

    virtual bool isConstant(){
        return false;
    }

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

    virtual void genCode(){
        outputFile << "\t// ExpAst lolwut\n";
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
        outputFile << "\t// stmtAst\n";
    }
};

class INTCONST : public ExpAst {
  protected:
    int Num;
    string type = "INT";

  public:
    INTCONST(int n){
    	Num = n;
    }

    bool isConstant(){
        return true;
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

    string getExpStr(){
        return "(IntConst "+to_string(Num)+")";
    }

    void print(int level){
    	cout<<string(level, ' ')<<"(IntConst "<<Num<<")";
    }

    void genCode(){
        outputFile << "\t// INTCONST\n";
        outputFile << "\tmove(" << Num <<", eax);\n";
    }

};

class FLOATCONST : public ExpAst {
  protected:
    float Num;
    string type = "FLOAT";

  public:
    FLOATCONST(float f){
        Num = f;
    }

    bool isConstant(){
        return true;
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

    string getExpStr(){
        return "(FloatConst "+to_string(Num)+")";
    }

    void print(int level){
        cout<<string(level, ' ')<<"(FloatConst "<<Num<<")";
    }

    void genCode(){
        outputFile << "\t// FLOATCONST\n";
        outputFile << "\tmove(" << fixed << setprecision(6) << Num <<", eax);\n";
    }
};

class STRINGCONST : public ExpAst {
  protected:
    string strlit;
    string type = "STRING";

  public:
    
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

    string getExpStr(){
        return "(StringConst "+strlit+")";
    }

    void print(int level){
        outputFile << "\t// STRINGCONST\n";
        cout<<string(level, ' ')<<"(StringConst "<<strlit<<")";
    }
};

class IDENTIFIERAST : public ExpAst {
  protected:
    string identifier;
    string type="NULL";

  public:
    IDENTIFIERAST(string s){
        identifier = s;
        /*
        if(!localtable->inScope(s)) {
            cerr<<"Error! Variable is used without declaration: "+s<<endl;
            exitcode=true;
        }
        */
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
        cout<<string(level, ' ')<<"(Id \""<<identifier<<"\")";
    }
    void genCode(){
        outputFile << "\t// identifierAST\n";

        // entity *ent = localtable->findInScope(identifier,"var");
        // int offset = ent->offset;
        // cerr << "here" << type << endl; //y  ? why is this NULL
        // if (type == "INT"){
        //     cerr << "here int\n";
        //     outputFile << "\tloadi((ind(ebp, " << -offset << "), eax); // load to eax\n";
        // }
        // else if (type == "FLOAT"){
        //     cerr << "here float\n";
        //     outputFile << "\tloadf((ind(ebp, " << -offset << "), eax); // load to eax\n";
        // }
    }
};

class ArrayRef : public ExpAst {
  protected:
    IDENTIFIERAST *identifier;
    list<ExpAst*> *expAstList;
    string type;
    int offset;

  public:
    
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
            cerr<<"Error! Variable is used without declaration lol : "+varName<<endl;
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
            // cerr << "hagga\n";
        } else{
            cout<<string(level, ' ')<<"(ArrayRef ";
            identifier->print(0);
            for (list<ExpAst*>::iterator it = expAstList->begin(); it != expAstList->end(); it++){
                cout<<"[";
                (*it)->print(0);
                cout<<"]";
            }
            cout<<")";
        }
        
    }




    int getOffset(){    // returns offset

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

        int i = 0;
        for (list<ExpAst*>::iterator it = expAstList->begin(); it != expAstList->end(); it++)
        {
            prod /= (ent->dimensions[i]);

            // if (!(*it)->isConstant())
            // {
                
                (*it)->genCode();   // assuming the value is in eax


                if (i == 0){
                    outputFile << "\tmuli(" << -prod << ", eax);\n";
                    outputFile << "\tmove(eax, ebx);\n";
                } 
                else {
                    outputFile << "\tmuli(" << -prod << ", eax);\n";
                    outputFile << "\taddi(eax, ebx);\n"; // ebx += eax
                }
            

            i++;
        }

        outputFile << "\taddi(" << offset << ",ebx);\n";

        return 1;  // means it's not a constant offset i.e. present in ebx
    }

    void genCode(){
        outputFile << "\t// arrayref\n";
        int x = getOffset();
        if (x == 1){
            if (type == "INT")
                outputFile << "\tloadi(ind(ebp, ebx), eax);\n"; //     
            else
                outputFile << "\tloadf(ind(ebp, ebx), eax);\n"; //     
        }
        else{
            if (type == "INT")
                outputFile << "\tloadi(ind(ebp, " << x << "), eax);\n"; // change eax to another register which you want to load on
            else 
                outputFile << "\tloadf(ind(ebp, " << x << "), eax);\n"; // change eax to another register which you want to load on
        }
        
    }

};

class Cast : public ExpAst{
    protected:
        ExpAst *singleExpAst;
        string type;
    public:
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
            cout<<string(level, ' ')<<"(TO_"<<type<<" ";
            singleExpAst->print(0);
            cout<<")";
        }

        void genCode(){
            outputFile << "\t// cast\n";

            if (type == "INT" and singleExpAst->getType() == "FLOAT"){
                if (singleExpAst->isConstant()){
                    outputFile << "\tmove(" << fixed << setprecision(6) << ((FLOATCONST*) singleExpAst)->evaluate()  << ", eax);\n";
                }
                else 
                    singleExpAst->genCode();
                
                outputFile << "\tfloatToint(eax);   //casting to int\n";
            }
            if (type == "FLOAT" and singleExpAst->getType() == "INT"){
                if (singleExpAst->isConstant()){
                    outputFile << "\tmove(" << ((INTCONST*) singleExpAst)->evaluate()  << ", eax);" << endl;
                }
                else 
                    singleExpAst->genCode();
                
                outputFile << "\tintTofloat(eax);   //casting to float \n";
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
            cout<<string(level, ' ')<<"("<<op<<ptype<<" ";
            leftExpAst->print(0);
            cout<<" ";
            rightExpAst->print(0);
            cout<<")";
        }

        void genCode(){

            // int cas;

            outputFile << "\t// op2\n";

            if (op == "OR"){

            }
            else if (op == "AND"){

            }
            else if (op == "EQ_OP"){

            }
            else if (op == "NE_OP"){

            }
            else if (op == "LT"){

            }
            else if (op == "GT"){

            }
            else if (op == "LE_OP"){

            }
            else if (op == "GE_OP"){

            }
            else if (op == "PLUS"){
                if (rightExpAst->isConstant()){
                    leftExpAst->genCode();
                    if (leftExpAst->getType() == "INT")
                        outputFile << "\taddi(" << ((INTCONST*)rightExpAst)->evaluate() << ", eax);\n"; // or addf ??
                    else
                        outputFile << "\taddf(" << fixed << setprecision(6) << ((FLOATCONST*) rightExpAst)->evaluate() << ", eax);\n"; // or addf ??
                }

            }
            else if (op == "MINUS"){

            }
            else if (op == "MULT"){

            }
            else if (op == "DIV"){

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
	        cout<<string(level, ' ')<<"("<<op<<"_"<<type<<" ";
	        singleExpAst->print(0);
            cout<<")";
	    }

        void genCode(){
           outputFile << "\t// op1\n";
            if (op == "PP"){
                if (type == "INT")
                    outputFile << "\taddi(1,eax);\n";
                else
                    outputFile << "\taddf(1.0,eax);\n";
            }
            else if (op == "UMINUS"){
                if (type == "INT")
                    outputFile << "\tmuli(-1,eax);\n";
                else
                    outputFile << "\tmulf(-1.0,eax);\n";
            }
            else if (op == "NOT"){

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
            // cerr << "Here\n\n";

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
            // cerr << "Here\n\n";
            outputFile << "\t// funcallAST\n";

            // Push the return value
            outputFile << "\n\t// parameter loading :: " << funcName->getId() << endl;
            if (type == "INT"){
                outputFile << "\tpushi(0); //To make space in stack for return val" << endl;
            } 
            else if (type == "FLOAT"){
                outputFile << "\tpushf(0.0); //To make space in stack for return val" << endl;
            }

            int floatParams = 0, intParams = 0;

            string varName = funcName->getId();
            entity* ent = localtable->findFunctionInScope(varName); 
            symbTable *func = ent->funcPtr;

            list<ExpAst*>::iterator it = expSequence->begin();
            int i = 0;
            while(it != expSequence->end()){
                string ltype = func->symtable[i]->type;
                string rtype = (*it)->getType();

                if ((*it)->isConstant() and (ltype == rtype)){
                    // outputFile << "\t" << (*it)->getExpStr() << endl;
                
                    if (ltype == "INT"){
                        intParams++;
                        outputFile << "\tpushi(" << ((INTCONST*) (*it))->evaluate()  << "); // argument to fact" << endl;
                    }
                    if (ltype == "FLOAT"){
                        floatParams++;
                        outputFile << "\tpushf(" << fixed << setprecision(6) << ((FLOATCONST*) (*it))->evaluate()  << "); // argument to fact" << endl;
                    }
                }
                else{
                    (*it)->genCode();
                    // assuming the value to be in eax

                    if (rtype == ltype){
                        if (ltype == "INT"){
                            intParams++;
                            outputFile << "\tpushi(eax); // argument to fact" << endl;
                        }
                        if (ltype == "FLOAT"){
                            floatParams++;
                            outputFile << "\tpushf(eax); // argument to fact" << endl;
                        }
                    }
                }

                it++;
                i++;
            }

            // Function call ::
            outputFile << "\t" << varName << "();\n";

            if (intParams > 0){
                outputFile << "\tpopi(" << intParams << ");\n";
            }
            
            if (floatParams > 0){
                outputFile << "\tpopf(" << floatParams << ");\n";
            }

            // move return value into eax
            // Pop retrun value
            if (type == "INT"){
                outputFile << "\tloadi(ind(esp), eax); // receives the return value\n";
                outputFile << "\tpopi(1); // Clean up return value\n" << endl;
            } 
            else if (type == "FLOAT"){
                outputFile << "\tloadf(ind(esp), eax); // receives the return value\n";
                outputFile << "\tpopf(1); // pop the return value\n" << endl;
            }
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
            outputFile << "\t// blockstmt\n";

            for (list<StmtAst*>::iterator it = stmtSequence->begin(); it != stmtSequence->end();){
                outputFile << "\n\t//   New statement\n";
                (*it)->genCode();
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
            outputFile << "\t// returnast\n";

            if (returnExp->isConstant()){
                if (returnExp->getType() == "INT")
                    outputFile <<  "\tstorei("<< ((INTCONST*) returnExp)->evaluate() <<", ind(ebp,  " << localtable->totalParameterOffset() + I /* +I because ebp*/ << " )); // Save the return value in stack" << endl;
                else
                    outputFile <<  "\tstoref("<< fixed << setprecision(6) << ((FLOATCONST*) returnExp)->evaluate() <<", ind(ebp,  " << localtable->totalParameterOffset() + I << " )); // Save the return value in stack" << endl;
            }
            else{
                returnExp->genCode();
                if (returnExp->getType() == "INT")
                    outputFile <<  "\tstoref(eax, ind(ebp," << localtable->totalParameterOffset() + I << ")); // Save the return value in stack" << endl;
                else
                    outputFile <<  "\tstoref(eax, ind(ebp, " << localtable->totalParameterOffset() + I << ")); // Save the return value in stack" << endl;
            }
            
            outputFile << "\tj(e); // Unconditional jump" << endl;
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
            // cerr << "In ass stmt\n";
            // cerr << "In ass stmt\n";
            outputFile << "\t// assignment\n";

            string ltype = leftExpAst->getType();   // anyway both expressions are of same type

            if (ltype == "INT")
            {
                if (rightExpAst->isConstant())
                {
                    outputFile << "\t//     leftpart\n";

                    int x = ((ArrayRef *)leftExpAst)->getOffset();
                    if (x == 1) {    // means it is an array and the value is in ebx
                        outputFile << "\tstorei(" << ((INTCONST*)rightExpAst)->evaluate() << ", ind(ebp, ebx));\n";
                    }
                    else{
                        outputFile << "\tstorei(" << ((INTCONST*)rightExpAst)->evaluate() << ", ind(ebp, "<< x <<"));\n";
                    }
                }
                else
                {
                    rightExpAst->genCode(); // assume value in eax

                    outputFile << "\tmove(eax, ecx); // ecx = eax\n";

                    outputFile << "\t// leftpart\n";
                    
                    int x = ((ArrayRef *)leftExpAst)->getOffset();
                    if (x == 1) {    // means it is an array and the offset value is in ebx
                        outputFile << "\tstorei(ecx, ind(ebp, ebx));\n";
                    }
                    else{
                        outputFile << "\tstorei(ecx, ind(ebp, "<< x <<"));\n";
                    }
                }
            } 

            else if (ltype == "FLOAT")
            {
                if (rightExpAst->isConstant())
                {
                    outputFile << "\t// leftpart\n";

                    int x = ((ArrayRef *)leftExpAst)->getOffset();
                    if (x == 1) {    // means it is an array and the value is in ebx
                        outputFile << "\tstoref(" << fixed << setprecision(6) << ((FLOATCONST*)rightExpAst)->evaluate() << ", ind(ebp, ebx));\n";
                    }
                    else{
                        outputFile << "\tstoref(" << fixed << setprecision(6) << ((FLOATCONST*)rightExpAst)->evaluate() << ", ind(ebp, "<< x <<"));\n";
                    }
                }
                else
                {
                    rightExpAst->genCode(); // assume value in eax
                    outputFile << "\tmove(eax, ecx); // ecx = eax\n";

                    outputFile << "\t// leftpart\n";

                    int x = ((ArrayRef *)leftExpAst)->getOffset();
                    if (x == 1) {    // means it is an array and the offset value is in ebx
                        outputFile << "\tstoref(ecx, ind(ebp, ebx));\n";
                    }
                    else{
                        outputFile << "\tstoref(ecx, ind(ebp, "<< x <<"));\n";
                    }

                }
            }

            /*
            generated code to put rightExpAst value in right ast location
            */
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

            /*
            Have to generate truelist , falselist and functions for backpatching, merging
            */
            outputFile << "\t// IfAst\n";

            int currentLabel = globalLabel;
            globalLabel++;
            outputFile << "\n//If starts:\n";

            ifExpAst->genCode();
            outputFile << "\tcmpi(0, eax);" << endl;
            outputFile << "\tjne(l" << currentLabel << "); // Jump if not equal" << endl;
            
            thenStmtAst->genCode();
            outputFile << "\tj(e" << currentLabel << ");\n";


            outputFile << "l" << currentLabel << ":\n";
            elseStmtAst->genCode();

            outputFile << "\ne" << currentLabel << ":\n";
            outputFile << "\n//If ends\n";

        }
};

class emptyStmt : public StmtAst{
    protected:

    public:
        void print (int level){
            cout<<string(level, ' ')<<"(Empty)";
        }

        void genCode(){
            outputFile << "\t//Empty statement\n";
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
            
            /*
            Have to generate truelist , falselist and functions for backpatching, merging
            */
            outputFile << "\t// whileAst\n";

            int currentLabel = globalLabel;
            globalLabel++;
            outputFile << "\n//While loop starts:\n";

            outputFile << "\nl" << currentLabel << ":\n";
            whileExpAst->genCode();

            outputFile << "\tcmpi(0, eax);" << endl;
            outputFile << "\tjne(e" << currentLabel << "); // Jump if not equal" << endl;
            
            thenStmtAst->genCode();
            
            outputFile << "\tj(l" << currentLabel << ");\n";


            outputFile << "\ne" << currentLabel << ":\n";
            outputFile << "\n//While loop ends\n";

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
            
            /*
            Have to generate truelist , falselist and functions for backpatching, merging
            */
            outputFile << "\t// forAst\n";

            int currentLabel = globalLabel;
            globalLabel++;
            
            outputFile << "\n//For loop starts:\n";

            for1ExpAst->genCode();

            outputFile << "\nl" << currentLabel << ":\n";
            for2ExpAst->genCode();

            outputFile << "\tcmpi(0, eax);" << endl;
            outputFile << "\tjne(e" << currentLabel << "); // Jump if not equal" << endl;
            
            thenStmtAst->genCode();
            for3ExpAst->genCode();

            outputFile << "\tj(l" << currentLabel << ");\n";
            outputFile << "\ne" << currentLabel << ":\n";
            outputFile << "\n//For loop ends\n";

        }
};

#endif