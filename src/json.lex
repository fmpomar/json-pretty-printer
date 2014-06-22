/* Mini Calculator */
/* calc.lex */

%{
#include "../yacc/json.tab.h"
int yyerror(char *s);
extern int yylineno;
%}

digits		[0-9]+
int		(-?)([1-9]({digits}?)|[0])
frac		\.{digits}
exp_char	("e"|"e+"|"e-"|"E"|"E+"|"E-")
exp		{exp_char}{digits}
number		{int}({frac}|{exp}|{frac}{exp})?
char		[^\"\\]
hex_digit	[0-9a-fA-F]
escaped_char	("\\\\"|"\\\/"|"\\b"|"\\f"|"\\n"|"\\r"|"\\t"|(\\u{hex_digit}{hex_digit}{hex_digit}{hex_digit}))
string_comp	({char}|{escaped_char})
string		"\""{string_comp}*"\""
true		"true"
false		"false"
null		"null"

%%

{number} { yylval.string = strdup(yytext); return NUMBER_VALUE; }
{string} { yylval.string = strdup(yytext); return STRING_VALUE; }
{true} { yylval.string = "true"; return TRUE_VALUE; }
{false} { yylval.string = "false"; return FALSE_VALUE; }
{null}  { yylval.string = "null"; return NULL_VALUE; }

[,:\{\}\[\]] { return *yytext; }

[ \n\r\t] { if ((*yytext) == '\n') yylineno++; }

. { printf("Lexical error at: '%s'\n", yytext); exit(0); }

