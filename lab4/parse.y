/* ---------------------------------------------------- */
%scanner Scanner.h
%scanner-token-function d_scanner.lex()


%token VOID INT FLOAT FLOAT_CONSTANT INT_CONSTANT AND_OP OR_OP EQ_OP NE_OP LE_OP GE_OP STRING_LITERAL IF ELSE WHILE FOR RETURN IDENTIFIER INC_OP DEC_OP


%polymorphic STRING : std::string;  EXPAST : ExpAst*; STMTAST : StmtAst*; STMTLIST : list<StmtAst*>*; EXPLIST : list<ExpAst*>*; INTCONST : INTCONST*; FLOATCONST : FLOATCONST*; STRINGCONST : STRINGCONST*; IDENTIFIERAST : IDENTIFIERAST*; ArrayRef : ArrayRef*; op2 : op2*; op1 : op1*; FUNCALL : FUNCALL*; BlockStmt : BlockStmt*; ReturnStmt : ReturnStmt*; AssStmt : AssStmt*; IfStmt : IfStmt*; emptyStmt : emptyStmt*; WhileStmt : WhileStmt*; ForStmt : ForStmt*; INT : int; FLOAT : float;

%type<STRING> unary_operator IDENTIFIER STRING_LITERAL type_specifier declarator
%type<INT> INT_CONSTANT constant_expression
%type<FLOAT> FLOAT_CONSTANT

%type<EXPAST> expression logical_and_expression equality_expression relational_expression additive_expression multiplicative_expression unary_expression postfix_expression primary_expression

%type<STMTAST> compound_statement statement assignment_statement selection_statement iteration_statement      

%type<EXPLIST> expression_list

%type<STMTLIST> statement_list

%type<ArrayRef> l_expression

%%

translation_unit
	: function_definition 
  {
    // gobltable->printTable();
  }
	| translation_unit function_definition
  {
    // gobltable->printTable();
  }
  ;

function_definition
	: type_specifier fun_declarator compound_statement 
  {
    localtable->returntype = $1;
    localtable->printTable();
    symbTable *localtableTemp = new symbTable("temp", gobltable);
    *localtableTemp = *localtable;
    localtable = new symbTable("temp", gobltable);
    isParam = true;
    int exitcode = gobltable->addEntity(localtableTemp->tablename ,"fun", $1,false,   localtableTemp);
    if (exitcode < 0) ABORT();
  }
	;

type_specifier
	: VOID
  {
    $$ = "void";
    varType = "void";
  } 	
  | INT
  {
    $$ = "int";
    varType = "int";
  }
	| FLOAT
  {
    $$ = "float";
    varType = "float";
  }
  ;

fun_declarator
	: IDENTIFIER '(' parameter_list ')' 
  {
    localtable->tablename = $1;
    isParam = false;
  }
  | IDENTIFIER '(' ')' 
  {
    localtable->tablename = $1;
    isParam = false;
  }
	;

parameter_list
	: parameter_declaration
  {
    localtable->numofparams++;
  }
	| parameter_list ',' parameter_declaration
  {
    localtable->numofparams++;
  }
	;

parameter_declaration
	: type_specifier declarator 
  ;

declarator
	: IDENTIFIER 
  {
    $$ = $1;
    int exitcode = localtable->addEntity($1, "var", varType, isParam, NULL);
    if (exitcode < 0) ABORT();
  }
	| declarator '[' constant_expression ']' 
  {
    int exitcode = localtable->addArray($1, $3, isParam);
    if (exitcode < 0) ABORT();
  }
  ;

constant_expression 
    : INT_CONSTANT
    {
      $$ = $1;
    }
    | FLOAT_CONSTANT
    {
      cerr<<"Invalid parameter "<<$1<<" for array"<<endl;
      ABORT();
    }
    ;

compound_statement
	: '{' '}'
  {
    $$ = new BlockStmt(new list<StmtAst*>());
    ($$)->print(0);std::cout<<std::endl<<std::endl;
  }
	| '{' statement_list '}'
  {
    $$ = new BlockStmt($2);
    ($$)->print(0);std::cout<<std::endl<<std::endl;
  }
  | '{' declaration_list statement_list '}'
  {
    $$ = new BlockStmt($3);
    ($$)->print(0);std::cout<<std::endl<<std::endl;
  }
	;

statement_list
	: statement
  {
    $$ = new list<StmtAst*>();
    ($$)->push_back($1);
  }	
  | statement_list statement
  {
    ((list<StmtAst*>*)$1)->push_back($2);
    $$ = $1;
  }
	;

statement
  : '{' statement_list '}'  //a solution to the local decl problem
  {
    $$ = new BlockStmt($2);
    //($$)->print(0);std::cout<<std::endl;
  }
  | selection_statement
  {
    $$ = $1;
  }
  | iteration_statement
  {
    $$ = $1;
  }	
  | assignment_statement
  {
    $$ = $1;
  }	
  | RETURN expression ';'
  {
    $$ = new ReturnStmt($2);
    //($$)->print(0);std::cout<<std::endl;
  }
  ;

assignment_statement
	: ';'
  {
    $$ = new emptyStmt();
    //($$)->print(0);std::cout<<std::endl;
  }							
	|  l_expression '=' expression ';'
  {
    if(!($1)->validate()) {cerr<<"line number: "<<lineno<<endl; ABORT();}
    $$ = new AssStmt($1,$3);
    //($$)->print(0);std::cout<<std::endl;
  }	
	;

expression
  : logical_and_expression
  {
    $$ = $1;
  }
  | expression OR_OP logical_and_expression
  {
    $$ = new op2($1,"OR",$3);
    //($$)->print(0);std::cout<<std::endl;
  }
  ;

logical_and_expression
  : equality_expression
  {
    $$ = $1;
  }
  | logical_and_expression AND_OP equality_expression
  {
    $$ = new op2($1,"AND",$3);
    //($$)->print(0);std::cout<<std::endl;
  }
  ;

equality_expression
	: relational_expression
  {
    $$ = $1;
  }
  | equality_expression EQ_OP relational_expression
  {
    $$ = new op2($1,"EQ_OP",$3);
    //($$)->print(0);std::cout<<std::endl;
  }	
	| equality_expression NE_OP relational_expression
  {
    $$ = new op2($1,"NE_OP",$3);
    //($$)->print(0);std::cout<<std::endl;
  }
	;

relational_expression
	: additive_expression
  {
    $$ = $1;
  }
  | relational_expression '<' additive_expression
  {
    $$ = new op2($1,"LT",$3);
    //($$)->print(0);std::cout<<std::endl;
  }
	| relational_expression '>' additive_expression
  {
    $$ = new op2($1,"GT",$3);
    //($$)->print(0);std::cout<<std::endl;
  }
	| relational_expression LE_OP additive_expression
  {
    $$ = new op2($1,"LE_OP",$3);
    //($$)->print(0);std::cout<<std::endl;
  }
  | relational_expression GE_OP additive_expression
  {
    $$ = new op2($1,"GE_OP",$3);
    //($$)->print(0);std::cout<<std::endl;
  }
	;

additive_expression 
	: multiplicative_expression
  {
    $$ = $1;
  }
	| additive_expression '+' multiplicative_expression
  {
    $$ = new op2($1,"PLUS",$3);
    //($$)->print(0);std::cout<<std::endl;
  }
	| additive_expression '-' multiplicative_expression
  {
    $$ = new op2($1,"MINUS",$3);
    //($$)->print(0);std::cout<<std::endl;
  }
	;

multiplicative_expression
	: unary_expression
  {
    $$ = $1;
  }
	| multiplicative_expression '*' unary_expression
  {
    $$ = new op2($1,"MULT",$3);
    //($$)->print(0);std::cout<<std::endl;
  }
	| multiplicative_expression '/' unary_expression
  {
    $$ = new op2($1,"DIV",$3);
    //($$)->print(0);std::cout<<std::endl;
  }
	;

unary_expression
	: postfix_expression
  {
    $$ = $1;
  } 				
	| unary_operator postfix_expression
  {
    $$ = new op1($1,$2);
    //($$)->print(0);std::cout<<std::endl;
  }
	;

postfix_expression
  : primary_expression
  {
    $$ = $1;
  }
  | IDENTIFIER '(' ')'
  {
    $$ = new FUNCALL(new IDENTIFIERAST($1));
    if(!(((FUNCALL*) $$)->validate())) ABORT();
    //($$)->print(0);std::cout<<std::endl;
  }
  | IDENTIFIER '(' expression_list ')'
  {
    $$ = new FUNCALL(new IDENTIFIERAST($1));
    ((FUNCALL*) $$)->addExpAstList($3);
    if(!(((FUNCALL*) $$)->validate())) ABORT();
    //($$)->print(0);std::cout<<std::endl;
  }
  | l_expression INC_OP
  {
    if(!($1)->validate()) {cerr<<"line number: "<<lineno<<endl; ABORT();}
    $$ = new op1("PP",$1);
    //($$)->print(0);std::cout<<std::endl;
  }
  ;

primary_expression
	: l_expression
  {
    if(!($1)->validate()) {cerr<<"line number: "<<lineno<<endl; ABORT();}
    $$ = $1;
  }
  | l_expression '=' expression // added this production
  {
    if(!($1)->validate()) {cerr<<"line number: "<<lineno<<endl; ABORT();}
    $$ = new op2($1,"ASSIGN",$3);
    //($$)->print(0);std::cout<<std::endl;
    
  }
	| INT_CONSTANT
  {
    $$ = new INTCONST($1);
    //($$)->print(0);std::cout<<std::endl;
  }
	| FLOAT_CONSTANT
  {
    $$ = new FLOATCONST($1);
    //($$)->print(0);std::cout<<std::endl;
  }
  | STRING_LITERAL
  {
    $$ = new STRINGCONST($1);
    //($$)->print(0);std::cout<<std::endl;
  }
	| '(' expression ')'
  {
    $$ = $2;
  }
	;

l_expression
  : IDENTIFIER
  {
    $$ = new ArrayRef(new IDENTIFIERAST($1));
    //($$)->print(0);std::cout<<std::endl;
  }

  | l_expression '[' expression ']'
  {
    ((ArrayRef*)$1)->addExpAst($3);
    $$ = $1;
    //($$)->print(0);std::cout<<std::endl;
  }
  ;

expression_list
  : expression
  {
    $$ = new list<ExpAst*>();
    ($$)->push_back($1);
  }
  | expression_list ',' expression
  {
    ((list<ExpAst*>*)$1)->push_back($3);
    $$ = $1;
  }
  ;

unary_operator
  : '-'
  {
    $$ = "UMINUS";
  }
	| '!'
  {
    $$ = "NOT";
  }
	;

selection_statement
  : IF '(' expression ')' statement ELSE statement
  {
    $$ = new IfStmt($3,$5,$7);
    //($$)->print(0);std::cout<<std::endl;
  }
  ;

iteration_statement
	: WHILE '(' expression ')' statement
  {
    $$ = new WhileStmt($3,$5);
    //($$)->print(0);std::cout<<std::endl;
  }
  | FOR '(' expression ';' expression ';' expression ')' statement  //modified this production
  {
    $$ = new ForStmt($3,$5,$7,$9);
    //($$)->print(0);std::cout<<std::endl;
  }
  ;

declaration_list
  : declaration  					
  | declaration_list declaration
  ;

declaration
	: type_specifier declarator_list ';'
	;

declarator_list
	: declarator
	| declarator_list ',' declarator 
	;
