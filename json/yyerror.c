#include <stdio.h>

int yyerror(char *error) {
	printf("ERROR: %s", error);
}
