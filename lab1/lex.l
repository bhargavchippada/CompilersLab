INT_CONST_ ((0|([1-9][0-9]*))|(0[bB][01]+)|(0[0-7]+)|(0[xX][0-9a-fA-F]+))
FLOAT_CONST_ ((([0-9]*)\.([0-9]+))|(([0-9]+)\.([0-9]*)))([eE][+-]?[0-9]*)?
STRING_LITERAL_ \"(\\.|[^"])*\"

IDENTIFIER_	[a-zA-Z_\$][a-zA-Z0-9_\$]*

WHITESPACES_	[ \t\n]+
COMMENT_	((\/\*(.|\n)*?(\*\/))|(\/\/(.)*))

TYPE_SPECIFIER_	void|int|float
RETURN_			return
WHILE_			while
FOR_			for
IF_ 			if
ELSE_			else

OR_OP_			\|\|
AND_OP_			\&\&
LE_OP_ 			\<\=
GE_OP_			\>\=
LT_OP_			\<
GT_OP_			\>
NE_OP_			\!\=
EQ_OP_			\=\=
INC_OP_			\+\+
DEC_OP_			\-\-
NOT_OP_			\!
ANP_OP_			\&
ASGN_OP_		\=


%%
{WHITESPACES_}		//return WHITESPACES;
{COMMENT_}			return COMMENT;

\,					return ',';
\[					return '[';
\]					return ']';
\{					return '{';
\}					return '}';
\(					return '(';
\)					return ')';
\;					return ';';
\+					return '+';
\-					return '-';
\*					return '*';
\/					return '/';

{TYPE_SPECIFIER_}	return TYPE_SPECIFIER;
{RETURN_}			return RETURN;
{WHILE_}			return WHILE;
{FOR_}				return FOR;
{IF_}				return IF;
{ELSE_}				return ELSE;

{INT_CONST_}		return INT_CONST;
{FLOAT_CONST_}		return FLOAT_CONST;
{STRING_LITERAL_}	return STRING_LITERAL;

{IDENTIFIER_}		return IDENTIFIER;

{OR_OP_}			return OR_OP;
{AND_OP_}			return AND_OP;
{LE_OP_}			return LE_OP;
{GE_OP_}			return GE_OP;
{LT_OP_}			return LT_OP;
{GT_OP_}			return GT_OP;
{NE_OP_}			return NE_OP;
{EQ_OP_}			return EQ_OP;
{INC_OP_}			return INC_OP;
{DEC_OP_}			return DEC_OP;
{NOT_OP_}			return NOT_OP;
{ANP_OP_}			return ANP_OP;
{ASGN_OP_}			return ASGN_OP;
.                   		return matched()[0];



