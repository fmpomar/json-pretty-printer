#include <stdio.h>

extern int yylineno;

int yyerror(char *error) {
	printf("ERROR: %s at line %d\n", error, yylineno);
}
