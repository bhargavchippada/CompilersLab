INT_CONST_ ((0|([1-9][0-9]*))|(0[bB][01]+)|(0[0-7]+)|(0[xX][0-9a-fA-F]+))
FLOAT_CONST_ ((([0-9]*)\.([0-9]+))|(([0-9]+)\.([0-9]*)))([eE][+-]?[0-9]*)?
STRING_LITERAL_ \"(\\.|[^"])*\"

IDENTIFIER_	[a-zA-Z_\$][a-zA-Z0-9_\$]*

WHITESPACES_	[ \t]+
NEWLINE_		\n
COMMENT_	((\/\*(.|\n)*?(\*\/))|(\/\/(.)*))

VOID_			void
INT_ 			int
FLOAT_ 			float
RETURN_			return
WHILE_			while
FOR_			for
IF_ 			if
ELSE_			else

OR_OP_			\|\|
AND_OP_			\&\&
LE_OP_ 			\<\=
GE_OP_			\>\=
NE_OP_			\!\=
EQ_OP_			\=\=
INC_OP_			\+\+
DEC_OP_			\-\-


%%
{WHITESPACES_}		//return Parser::WHITESPACES;
{COMMENT_}			//return Parser::COMMENT;
{NEWLINE_}			{Parser::lineno = Parser::lineno + 1;}
\,                	return ',';
\[                  return '[';
\]                  return ']';
\{                  return '{';
\}                  return '}';
\(                  return '(';
\)                  return ')';
\;                  return ';';

\+                  return '+';
\-                  return '-';
\*                  return '*';
\/                  return '/';
\%                  return '%';

\<					return '<';
\>					return '>';
\!					return '!';
\=					return '=';
\&					return '&';

{VOID_}				return Parser::VOID;
{INT_}				return Parser::INT;
{FLOAT_}			return Parser::FLOAT;
{RETURN_}			return Parser::RETURN;
{WHILE_}			return Parser::WHILE;
{FOR_}				return Parser::FOR;
{IF_}				return Parser::IF;
{ELSE_}				return Parser::ELSE;


{INT_CONST_}		{std::string::size_type sz;
						Parser::d_val__ = std::stoi(matched(),&sz);
						return Parser::INT_CONSTANT;}
{FLOAT_CONST_}		{std::string::size_type sz;
						Parser::d_val__ = std::stof(matched(),&sz);
						return Parser::FLOAT_CONSTANT;}
{STRING_LITERAL_}	{Parser::d_val__ = std::string(matched());
						return Parser::STRING_LITERAL;}

{IDENTIFIER_}		{Parser::d_val__ = std::string(matched());
						return Parser::IDENTIFIER;}

{OR_OP_}			return Parser::OR_OP;
{AND_OP_}			return Parser::AND_OP;
{LE_OP_}			return Parser::LE_OP;
{GE_OP_}			return Parser::GE_OP;
{NE_OP_}			return Parser::NE_OP;
{EQ_OP_}			return Parser::EQ_OP;
{INC_OP_}			return Parser::INC_OP;
{DEC_OP_}			return Parser::DEC_OP;
.                   //return matched()[0];



