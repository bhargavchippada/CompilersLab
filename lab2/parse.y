//%debug
%scanner Scanner.h
%scanner-token-function d_scanner.lex()

%token IDENTIFIER INT_CONST FLOAT_CONST STRING_LITERAL VOID INT FLOAT 
%token RETURN WHILE FOR IF ELSE OR_OP AND_OP LE_OP GE_OP NE_OP EQ_OP INC_OP DEC_OP


%%
translation_unit
  : function_definition
  {
    $$ = count++;
    DotGraphMapping("function_definition",$1,"translation_unit",$$);
  }
  | translation_unit function_definition
  {
    $$ = count++;
    DotGraphMapping("translation_unit",$1,"translation_unit",$$);
    DotGraphMapping("function_definition",$2,"translation_unit",$$);
  }
  ;

function_definition
  : type_specifier fun_declarator compound_statement
  {
    $$ = count++;
    DotGraphMapping("type_specifier",$1,"function_definition",$$);
    DotGraphMapping("fun_declarator",$2,"function_definition",$$);
    DotGraphMapping("compound_statement",$3,"function_definition",$$);
  }
  ;

type_specifier
  : VOID
  {
    $$ = count++;
    DotGraphMapping("VOID",count++,"type_specifier",$$);
  }
  | INT
  {
    $$ = count++;
    DotGraphMapping("INT",count++,"type_specifier",$$);
  }
  | FLOAT
  {
    $$ = count++;
    DotGraphMapping("FLOAT",count++,"type_specifier",$$);
  }
  ;

fun_declarator
  : IDENTIFIER '(' parameter_list ')'
  {
    $$ = count++;
    DotGraphMapping("IDENTIFIER",count++,"fun_declarator",$$);
    DotGraphMapping("(",count++,"fun_declarator",$$);
    DotGraphMapping("parameter_list",$3,"fun_declarator",$$);
    DotGraphMapping(")",count++,"fun_declarator",$$);
  }
  | IDENTIFIER '(' ')'
  {
    $$ = count++;
    DotGraphMapping("IDENTIFIER",count++,"fun_declarator",$$);
    DotGraphMapping("(",count++,"fun_declarator",$$);
    DotGraphMapping(")",count++,"fun_declarator",$$);
  }
  ;

parameter_list
  : parameter_declaration
  {
    $$ = count++;
    DotGraphMapping("parameter_declaration",$1,"parameter_list",$$);
  }
  | parameter_list ',' parameter_declaration
  {
    $$ = count++;
    DotGraphMapping("parameter_list",$1,"parameter_list",$$);
    DotGraphMapping(",",count++,"parameter_list",$$);
    DotGraphMapping("parameter_declaration",$3,"parameter_list",$$);
  }
  ;

parameter_declaration
  : type_specifier declarator
  {
    $$ = count++;
    DotGraphMapping("type_specifier",$1,"parameter_declaration",$$);
    DotGraphMapping("declarator",$2,"parameter_declaration",$$);
  }
  ;

declarator
  : IDENTIFIER
  {
    $$ = count++;
    DotGraphMapping("IDENTIFIER",count++,"declarator",$$);
  }
  | declarator '[' constant_expression ']'
  {
    $$ = count++;
    DotGraphMapping("declarator",$1,"declarator",$$);
    DotGraphMapping("[",count++,"declarator",$$);
    DotGraphMapping("constant_expression",$3,"declarator",$$);
    DotGraphMapping("]",count++,"declarator",$$);
  }
  ;

constant_expression
        : INT_CONST
        {
          $$ = count++;
          DotGraphMapping("INT_CONST",count++,"constant_expression",$$);
        }
        | FLOAT_CONST
        {
          $$ = count++;
          DotGraphMapping("FLOAT_CONST",count++,"constant_expression",$$);
        }
        ;

compound_statement
  : '{' '}'
  {
    $$ = count++;
    DotGraphMapping("{",count++,"compound_statement",$$);
    DotGraphMapping("}",count++,"compound_statement",$$);
  }
  | '{' statement_list '}'
  {
    $$ = count++;
    DotGraphMapping("{",count++,"compound_statement",$$);
    DotGraphMapping("statement_list",$2,"compound_statement",$$);
    DotGraphMapping("}",count++,"compound_statement",$$);
  }
  | '{' declaration_list statement_list '}'
  {
    $$ = count++;
    DotGraphMapping("{",count++,"compound_statement",$$);
    DotGraphMapping("declaration_list",$2,"compound_statement",$$);
    DotGraphMapping("statement_list",$3,"compound_statement",$$);
    DotGraphMapping("}",count++,"compound_statement",$$);
  }
  ;

declaration_list
  : declaration
  {
    $$ = count++;
    DotGraphMapping("declaration",$1,"declaration_list",$$);
  }
  | declaration_list declaration
  {
    $$ = count++;
    DotGraphMapping("declaration_list",$1,"declaration_list",$$);
    DotGraphMapping("declaration",$2,"declaration_list",$$);
  }
  ;

declaration
  : type_specifier declarator_list ';'
  {
    $$ = count++;
    DotGraphMapping("type_specifier",$1,"declaration",$$);
    DotGraphMapping("declarator_list",$2,"declaration",$$);
    DotGraphMapping(";",count++,"declaration",$$);
  }
  ;

declarator_list
  : declarator
  {
    $$ = count++;
    DotGraphMapping("declarator",$1,"declarator_list",$$);
  }
  | declarator_list ',' declarator
  {
    $$ = count++;
    DotGraphMapping("declarator_list",$1,"declarator_list",$$);
    DotGraphMapping(",",count++,"declarator_list",$$);
    DotGraphMapping("declarator",$3,"declarator_list",$$);
  }
  ;

statement_list
  : statement
  {
    $$ = count++;
    DotGraphMapping("statement",$1,"statement_list",$$);
  }
  | statement_list statement
  {
    $$ = count++;
    DotGraphMapping("statement_list",$1,"statement_list",$$);
    DotGraphMapping("statement",$2,"statement_list",$$);
  }
  ;

statement
  : compound_statement
  {
    $$ = count++;
    DotGraphMapping("compound_statement",$1,"statement",$$);
  }
  | selection_statement
  {
    $$ = count++;
    DotGraphMapping("selection_statement",$1,"statement",$$);
  }
  | iteration_statement
  {
    $$ = count++;
    DotGraphMapping("iteration_statement",$1,"statement",$$);
  }
  | assignment_statement
  {
    $$ = count++;
    DotGraphMapping("assignment_statement",$1,"statement",$$);
  }
  | RETURN expression ';'
  {
    $$ = count++;
    DotGraphMapping("RETURN",count++,"statement",$$);
    DotGraphMapping("expression",$2,"statement",$$);
    DotGraphMapping(";",count++,"statement",$$);
  }
  ;

assignment_statement
  : ';'
  {
    $$ = count++;
    DotGraphMapping(";",count++,"assignment_statement",$$);
  }
  |  l_expression '=' expression ';'
  {
    $$ = count++;
    DotGraphMapping("l_expression",$1,"assignment_statement",$$);
    DotGraphMapping("=",count++,"assignment_statement",$$);
    DotGraphMapping("expression",$3,"assignment_statement",$$);
    DotGraphMapping(";",count++,"assignment_statement",$$);
  }
  ;

expression
  : logical_and_expression
  {
    $$ = count++;
    DotGraphMapping("logical_and_expression",$1,"expression",$$);
  }
  | expression OR_OP logical_and_expression
  {
    $$ = count++;
    DotGraphMapping("expression",$1,"expression",$$);
    DotGraphMapping("OR_OP",count++,"expression",$$);
    DotGraphMapping("logical_and_expression",$3,"expression",$$);
  }
  ;

logical_and_expression
  : equality_expression
  {
    $$ = count++;
    DotGraphMapping("equality_expression",$1,"logical_and_expression",$$);
  }
  | logical_and_expression AND_OP equality_expression
  {
    $$ = count++;
    DotGraphMapping("logical_and_expression",$1,"logical_and_expression",$$);
    DotGraphMapping("AND_OP",count++,"logical_and_expression",$$);
    DotGraphMapping("equality_expression",$3,"logical_and_expression",$$);
  }
  ;

equality_expression
  : relational_expression
  {
    $$ = count++;
    DotGraphMapping("relational_expression",$1,"equality_expression",$$);
  }
  | equality_expression EQ_OP relational_expression
  {
    $$ = count++;
    DotGraphMapping("equality_expression",$1,"equality_expression",$$);
    DotGraphMapping("EQ_OP",count++,"equality_expression",$$);
    DotGraphMapping("relational_expression",$3,"equality_expression",$$);
  }
  | equality_expression NE_OP relational_expression
  {
    $$ = count++;
    DotGraphMapping("equality_expression",$1,"equality_expression",$$);
    DotGraphMapping("NE_OP",count++,"equality_expression",$$);
    DotGraphMapping("relational_expression",$3,"equality_expression",$$);
  }
  ;

relational_expression
  : additive_expression
  {
    $$ = count++;
    DotGraphMapping("additive_expression",$1,"relational_expression",$$);
  }
  | relational_expression '<' additive_expression
  {
    $$ = count++;
    DotGraphMapping("relational_expression",$1,"relational_expression",$$);
    DotGraphMapping("<",count++,"relational_expression",$$);
    DotGraphMapping("additive_expression",$3,"relational_expression",$$);
  }
  | relational_expression '>' additive_expression
  {
    $$ = count++;
    DotGraphMapping("relational_expression",$1,"relational_expression",$$);
    DotGraphMapping(">",count++,"relational_expression",$$);
    DotGraphMapping("additive_expression",$3,"relational_expression",$$);
  }
  | relational_expression LE_OP additive_expression
  {
    $$ = count++;
    DotGraphMapping("relational_expression",$1,"relational_expression",$$);
    DotGraphMapping("LE_OP",count++,"relational_expression",$$);
    DotGraphMapping("additive_expression",$3,"relational_expression",$$);
  }
  | relational_expression GE_OP additive_expression
  {
    $$ = count++;
    DotGraphMapping("relational_expression",$1,"relational_expression",$$);
    DotGraphMapping("GE_OP",count++,"relational_expression",$$);
    DotGraphMapping("additive_expression",$3,"relational_expression",$$);
  }
  ;

additive_expression
  : multiplicative_expression
  {
    $$ = count++;
    DotGraphMapping("multiplicative_expression",$1,"additive_expression",$$);
  }
  | additive_expression '+' multiplicative_expression
  {
    $$ = count++;
    DotGraphMapping("additive_expression",$1,"additive_expression",$$);
    DotGraphMapping("+",count++,"additive_expression",$$);
    DotGraphMapping("multiplicative_expression",$3,"additive_expression",$$);
  }
  | additive_expression '-' multiplicative_expression
  {
    $$ = count++;
    DotGraphMapping("additive_expression",$1,"additive_expression",$$);
    DotGraphMapping("-",count++,"additive_expression",$$);
    DotGraphMapping("multiplicative_expression",$3,"additive_expression",$$);
  }
  ;

multiplicative_expression
  : unary_expression
  {
    $$ = count++;
    DotGraphMapping("unary_expression",$1,"multiplicative_expression",$$);
  }
  | multiplicative_expression '*' unary_expression
  {
    $$ = count++;
    DotGraphMapping("multiplicative_expression",$1,"multiplicative_expression",$$);
    DotGraphMapping("*",count++,"multiplicative_expression",$$);
    DotGraphMapping("unary_expression",$3,"multiplicative_expression",$$);
  }
  | multiplicative_expression '/' unary_expression
  {
    $$ = count++;
    DotGraphMapping("multiplicative_expression",$1,"multiplicative_expression",$$);
    DotGraphMapping("/",count++,"multiplicative_expression",$$);
    DotGraphMapping("unary_expression",$3,"multiplicative_expression",$$);
  }
  ;

unary_expression
  : postfix_expression
  {
    $$ = count++;
    DotGraphMapping("postfix_expression",$1,"unary_expression",$$);
  }
  | unary_operator postfix_expression
  {
    $$ = count++;
    DotGraphMapping("unary_operator",$1,"unary_expression",$$);
    DotGraphMapping("postfix_expression",$2,"unary_expression",$$);
  }
  ;

postfix_expression
  : primary_expression
  {
    $$ = count++;
    DotGraphMapping("primary_expression",$1,"postfix_expression",$$);
  }
  | IDENTIFIER '(' ')'
  {
    $$ = count++;
    DotGraphMapping("IDENTIFIER",count++,"postfix_expression",$$);
    DotGraphMapping("(",count++,"postfix_expression",$$);
    DotGraphMapping(")",count++,"postfix_expression",$$);
  }
  | IDENTIFIER '(' expression_list ')'
  {
    $$ = count++;
    DotGraphMapping("IDENTIFIER",count++,"postfix_expression",$$);
    DotGraphMapping("(",count++,"postfix_expression",$$);
    DotGraphMapping("expression_list",$3,"postfix_expression",$$);
    DotGraphMapping(")",count++,"postfix_expression",$$);
  }
  | l_expression INC_OP
  {
    $$ = count++;
    DotGraphMapping("l_expression",$1,"postfix_expression",$$);
    DotGraphMapping("INC_OP",count++,"postfix_expression",$$);
  }
  | l_expression DEC_OP
  {
    $$ = count++;
    DotGraphMapping("l_expression",$1,"postfix_expression",$$);
    DotGraphMapping("DEC_OP",count++,"postfix_expression",$$);
  }
  ;

primary_expression
  : l_expression
  {
    $$ = count++;
    DotGraphMapping("l_expression",$1,"primary_expression",$$);
  }
  | INT_CONST
  {
    $$ = count++;
    DotGraphMapping("INT_CONST",count++,"primary_expression",$$);
  }
  | FLOAT_CONST
  {
    $$ = count++;
    DotGraphMapping("FLOAT_CONST",count++,"primary_expression",$$);
  }
  | STRING_LITERAL
  {
    $$ = count++;
    DotGraphMapping("STRING_LITERAL",count++,"primary_expression",$$);
  }
  | '(' expression ')'
  {
    $$ = count++;
    DotGraphMapping("(",count++,"primary_expression",$$);
    DotGraphMapping("expression",$2,"primary_expression",$$);
    DotGraphMapping(")",count++,"primary_expression",$$);
  }
  ;

l_expression
        : IDENTIFIER
        {
          $$ = count++;
          DotGraphMapping("IDENTIFIER",count++,"l_expression",$$);
        }
        | l_expression '[' expression ']' 
        {
          $$ = count++;
          DotGraphMapping("l_expression",$1,"l_expression",$$);
          DotGraphMapping("[",count++,"l_expression",$$);
          DotGraphMapping("expression",$3,"l_expression",$$);
          DotGraphMapping("]",count++,"l_expression",$$);
        }
        ;

expression_list
        : expression
        {
          $$ = count++;
          DotGraphMapping("expression",$1,"expression_list",$$);
        }
        | expression_list ',' expression
        {
          $$ = count++;
          DotGraphMapping("expression_list",$1,"expression_list",$$);
          DotGraphMapping(",",count++,"expression_list",$$);
          DotGraphMapping("expression",$3,"expression_list",$$);
        }
        ;

unary_operator
        : '-'
        {
          $$ = count++;
          DotGraphMapping("-",count++,"unary_operator",$$);
        }
        | '!'
        {
          $$ = count++;
          DotGraphMapping("!",count++,"unary_operator",$$);
        }
        ;

selection_statement
        : IF '(' expression ')' statement ELSE statement
        {
          $$ = count++;
          DotGraphMapping("IF",count++,"selection_statement",$$);
          DotGraphMapping("(",count++,"selection_statement",$$);
          DotGraphMapping("expression", $3,"selection_statement",$$);
          DotGraphMapping(")",count++,"selection_statement",$$);
          DotGraphMapping("statement",$5,"selection_statement",$$);
          DotGraphMapping("ELSE",count++,"selection_statement",$$);
          DotGraphMapping("statement",$7,"selection_statement",$$);
        }
        ;

iteration_statement
  : WHILE '(' expression ')' statement
  {
    $$ = count++;
    DotGraphMapping("WHILE",count++,"iteration_statement",$$);
    DotGraphMapping("(",count++,"iteration_statement",$$);
    DotGraphMapping("expression", $3,"iteration_statement",$$);
    DotGraphMapping(")",count++,"iteration_statement",$$);
    DotGraphMapping("statement",$5,"iteration_statement",$$);
  }
  | FOR '(' assignment_statement expression ';' assignment_statement ')' statement
  {
    $$ = count++;
    DotGraphMapping("FOR",count++,"iteration_statement",$$);
    DotGraphMapping("(",count++,"iteration_statement",$$);
    DotGraphMapping("assignment_statement",$3,"iteration_statement",$$);
    DotGraphMapping("expression", $4,"iteration_statement",$$);
    DotGraphMapping(";",count++,"iteration_statement",$$);
    DotGraphMapping("assignment_statement",$6,"iteration_statement",$$);
    DotGraphMapping(")",count++,"iteration_statement",$$);
    DotGraphMapping("statement",$8,"iteration_statement",$$);
  }
  ;