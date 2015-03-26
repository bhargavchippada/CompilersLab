#ifndef Ast_h_included
#define Ast_h_included

#include "abstract_astnode.h"
#include "symbol_table.h"
#include <iostream>
#include <stdio.h>
#include <string>
#include <list>

using namespace std;

namespace // anonymous
{
    bool isParam = true;
    bool funType = true;
    string varType;
    symbTable *gobltable = new symbTable("gobl", NULL);
    symbTable *localtable = new symbTable("temp", gobltable);
    bool exitcode = false;
}

class ExpAst : public abstract_astnode {
    protected:
    string type="default";

	public:

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
        cerr<<"default validation"<<endl;
    }
};

class StmtAst : public abstract_astnode {
    public:

    virtual void print (int level){
        cout<<string(level, ' ')<<"This is an abstract StmtAst class"<<endl;
    }

    virtual bool validate(){
        cerr<<"stmtast default validation"<<endl;
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
};

class FLOATCONST : public ExpAst {
  protected:
    float Num;
    string type = "FLOAT";

  public:
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

    string getExpStr(){
        return "(FloatConst "+to_string(Num)+")";
    }

    void print(int level){
        cout<<string(level, ' ')<<"(FloatConst "<<Num<<")";
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
            cerr<<"Variable is used without declaration: "+s<<endl;
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
            cerr<<"Variable is used without declaration: "+identifier<<endl;
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
};

class ArrayRef : public ExpAst {
  protected:
    IDENTIFIERAST *identifier;
    list<ExpAst*> *expAstList;
    string type;

  public:
    
    ArrayRef(IDENTIFIERAST *id){
        identifier = id;
        expAstList = new list<ExpAst*>();
    }

    void addExpAst(ExpAst *expast){
        if(expast->getType()!="INT"){
            cerr<<"Invalid array parameter: "+expast->getExpStr()<<endl;
            exitcode=true;
        }
    	(*expAstList).push_back(expast);
    }

    string getType(){
        return type;
    }

    bool validate(){
        string varName = identifier->getId();
        entity *ent = localtable->findInScope(varName,"var");
        if(ent==NULL){
            cerr<<"Variable is used without declaration: "+varName<<endl;
            exitcode=true;
            return false;
        }else{
            if(ent->dimensions.size() == expAstList->size()){
                type = ent->type;
                return true;
            }else{
                cerr<<"Wrong number of indices: "+varName<<endl;
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
                //type cast right expast
                Cast *cast = new Cast("FLOAT",rightExpAst);
                rightExpAst = cast;
                type = "FLOAT";
            }else{
                type="NULL";
                cerr<<"Invalid operation ("+leftExpAst->getExpStr()+" of type "+ltype+") "+op+
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
            cout<<string(level, ' ')<<"("<<op<<ptype<<" ";
            leftExpAst->print(0);
            cout<<" ";
            rightExpAst->print(0);
            cout<<")";
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
                cerr<<"Cannot apply unary operator to type "+singleExpAst->getType()+" of "+singleExpAst->getExpStr()<<endl;
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
            entity *ent = localtable->findInScope(varName,"fun");
            if(ent==NULL){
                cerr<<"Function is used without declaration: "+varName<<endl;
                exitcode=true;
                return false;
            }else{
                symbTable *func = ent->funcPtr;
                if(func->numofparams == expSequence->size()){
                    type = func->returntype;
                    return true;
                }else{
                    cerr<<"Wrong number of parameters: "+varName<<endl;
                    exitcode=true;
                    return false;
                }
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
};

class ReturnStmt : public StmtAst{
    protected:
        ExpAst *returnExp;
    public:
        ReturnStmt(ExpAst *expast){
            returnExp = expast;
        }

        bool validate(){
            if(returnExp->getType()==localtable->returntype){
                return true;
            }else{
                cerr<<"Incorrect return type: "+returnExp->getType()+" of "+returnExp->getExpStr()+
                " when "+localtable->returntype+" is expected"<<endl;
                return false;
            }
        }

        void print(int level){
            cout<<string(level, ' ')<<"(Return ";
            returnExp->print(0);
            cout<<")";
        }
};

class AssStmt : public StmtAst{
    protected:
        ExpAst *leftExpAst;
        ExpAst *rightExpAst;
    public:
        AssStmt(ExpAst *left, ExpAst *right): leftExpAst(left), rightExpAst(right){}
        
        void print (int level){
            cout<<string(level, ' ')<<"(Ass ";
            leftExpAst->print(0);
            cout<<" ";
            rightExpAst->print(0);
            cout<<")";
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
};

class emptyStmt : public StmtAst{
    protected:

    public:
        void print (int level){
            cout<<string(level, ' ')<<"(Empty)";
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
        
};

#endif