/* Infix notation calculator.  */
     
%{
  #include <math.h>
  #include <stdio.h>
  #include "../src/structure.h"
  void print_tabs(int depth);
  void print_value(int depth, Value* value);
  int yylex (void);
  void yyerror (char const *);
%}

/* Bison declarations.  */
%union {
	char * string;
	int depth;
	struct Value* value;
	struct Pair* pair;
	struct Member* member;
	struct ArrayElement* array_element;
}

%token <string> STRING_VALUE
%token <string> NUMBER_VALUE
%token <string> TRUE_VALUE
%token <string> FALSE_VALUE
%token <string> NULL_VALUE

%type <value> object;
%type <member> members;
%type <pair> pair;
%type <value> array;
%type <array_element> elements;
%type <value> value;


%% /* The grammar follows.  */
input:
	%empty
	| object { print_value(0, $1); printf("\n"); exit(0); }
	| array { print_value(0, $1); printf("\n"); exit(0); }
;

object:
  	'{' '}' { $$ = newValue(TYPE_OBJECT, NULL); }
	| '{' members '}'  { $$ = newValue(TYPE_OBJECT, $2);  }
;

members:
	pair {$$ = newMember($1, NULL); } 
	| pair ',' members { $$ = newMember($1, $3); }
;

pair:
	STRING_VALUE ':' value { $$ = newPair($1, $3); } 
;

array:
	'[' ']' { $$ = newValue(TYPE_ARRAY, NULL); }
	| '[' elements ']' { $$ = newValue(TYPE_ARRAY, $2); }

elements:
	value { $$ = newArrayElement($1, NULL); }
	| value ',' elements { $$ = newArrayElement($1, $3); }
;

value:
	STRING_VALUE { $$ = newValue(TYPE_STRING, $1); }
	| NUMBER_VALUE { $$ = newValue(TYPE_NUMBER, $1); }
	| TRUE_VALUE { $$ = newValue(TYPE_BOOLEAN, $1); }
	| FALSE_VALUE { $$ = newValue(TYPE_BOOLEAN, $1); }
	| NULL_VALUE {$$ = newValue(TYPE_NULL, $1); }
	| object { $$ = $1; }
	| array  { $$ = $1; }
;
%%
