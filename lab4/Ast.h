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
    string varType;
    symbTable *gobltable = new symbTable("gobl", NULL);
    symbTable *localtable = new symbTable("temp", gobltable);
    bool exitcode = false;
}

class ExpAst : public abstract_astnode {
    protected:
    string type;

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
};

class StmtAst : public abstract_astnode {
    public:

    virtual void print (int level){
        cout<<string(level, ' ')<<"This is an abstract StmtAst class"<<endl;
    }
};

class INTCONST : public ExpAst {
  protected:
    int Num;
    string type = "int";

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
    string type = "float";

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
    string type = "string";

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

    void print(int level){
        cout<<string(level, ' ')<<"(StringConst "<<strlit<<")";
    }
};

class IDENTIFIERAST : public ExpAst {
  protected:
    string identifier;
    string type;

  public:
    IDENTIFIERAST(string s){
        identifier = s;
        type = localtable->giveType(s);
        if(type=="NULL") {
            cerr<<"Variable is used without declaration: "+s<<endl;
            exitcode=true;
        }
    }

    void setValue(string s){
        identifier = s;
    }

    string getType(){
        return type;
    }

    string evaluate(){
        return identifier;
    }

    void print(int level){
        cout<<string(level, ' ')<<"(Id \""<<identifier<<"\")";
    }
};

class ArrayRef : public ExpAst {
  protected:
    IDENTIFIERAST *identifier;
    list<ExpAst*> *expAstList;

  public:
    
    ArrayRef(IDENTIFIERAST *id){
        identifier = id;
        expAstList = new list<ExpAst*>();
    }

    void addExpAst(ExpAst *expast){
        if(expast->getType()!="int"){
            cerr<<"Invalid array parameter: "+expast->getExpStr()<<endl;
            exitcode=true;
        }
    	(*expAstList).push_back(expast);
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

class op2 : public ExpAst{
    protected:
        ExpAst *leftExpAst;
        ExpAst *rightExpAst;
        string op;
    public:
        op2(ExpAst *left, string ope, ExpAst *right): leftExpAst(left), op(ope), rightExpAst(right){}
    void print (int level){
        cout<<string(level, ' ')<<"("<<op<<" ";
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
    public:
        op1(string ope, ExpAst *singleExp): op(ope), singleExpAst(singleExp){}
	    
	    void print(int level){
	        cout<<string(level, ' ')<<"("<<op<<" ";
	        singleExpAst->print(0);
            cout<<")";
	    }
};

class FUNCALL : public ExpAst{
	protected:
		IDENTIFIERAST *funcName;
		list<ExpAst*> *expSequence;
	
	public:
		FUNCALL(IDENTIFIERAST *iden){
            funcName=iden;
            expSequence = new list<ExpAst*>();
        }

		void addExpAstList(list<ExpAst*> *expastlist){
			expSequence=expastlist;
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