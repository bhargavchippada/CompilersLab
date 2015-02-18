#include <iostream>
#include <string>
#include "Scanner.h"

using namespace std;

#define str(x) #x;

int main(){
	Scanner scanner;   // define a Scanner object
  	while (int token = scanner.lex()) // get all tokens
    {
      string const &text = scanner.matched();
      switch (token)
		{
			case Scanner::IDENTIFIER:
			  cout << "IDENTIFIER: " << text << '\n';
			  break;
			case Scanner::INT_CONST:
			  cout << "INT_CONST: " << text << '\n';
			  break;
			case Scanner::FLOAT_CONST:
			  cout << "FLOAT_CONST: " << text << '\n';
			  break;
			case Scanner::STRING_LITERAL:
			  cout << "STRING_LITERAL: " << text << '\n';
			  break;
			case Scanner::COMMENT:
			  cout << "COMMENT: " << text << '\n';
			  break;
			case Scanner::TYPE_SPECIFIER:
			  cout << "TYPE_SPECIFIER: " << text << '\n';
			  break;
			case Scanner::RETURN:
			  cout << "RETURN: " << text << '\n';
			  break;
			case Scanner::WHILE:
			  cout << "WHILE: " << text << '\n';
			  break;
			case Scanner::FOR:
			  cout << "FOR: " << text << '\n';
			  break;
			case Scanner::IF:
			  cout << "IF: " << text << '\n';
			  break;
			case Scanner::ELSE:
			  cout << "ELSE: " << text << '\n';
			  break;

			case Scanner::OR_OP:
			  cout << "OR_OP: " << text << '\n';
			  break;
			case Scanner::AND_OP:
			  cout << "AND_OP: " << text << '\n';
			  break;
			case Scanner::LE_OP:
			  cout << "LE_OP: " << text << '\n';
			  break;
			case Scanner::GE_OP:
			  cout << "GE_OP: " << text << '\n';
			  break;
			case Scanner::LT_OP:
			  cout << "LT_OP: " << text << '\n';
			  break;
			case Scanner::GT_OP:
			  cout << "GT_OP: " << text << '\n';
			  break;
			case Scanner::NE_OP:
			  cout << "NE_OP: " << text << '\n';
			  break;
			case Scanner::EQ_OP:
			  cout << "EQ_OP: " << text << '\n';
			  break;
			case Scanner::INC_OP:
			  cout << "INC_OP: " << text << '\n';
			  break;
			case Scanner::DEC_OP:
			  cout << "DEC_OP: " << text << '\n';
			  break;
			case Scanner::NOT_OP:
			  cout << "NOT_OP: " << text << '\n';
			  break;
			case Scanner::ANP_OP:
			  cout << "ANP_OP: " << text << '\n';
			  break;
			case Scanner::ASGN_OP:
			  cout << "ASGN_OP: " << text << '\n';
			  break;
			case ',':
			case '[':
			case ']':
			case '{':
			case '}':
			case '(':
			case ')':
			case ';':
			  	cout << "Single Character Token: " << text << '\n';
				break;
			case '+':
			case '-':
			case '*':
			case '/': 
				cout << "Single ALU Character Token: " << text << '\n';
				break;
			default:
			  cout << "char. token: `" << text << "'\n";
		}
    }
}
