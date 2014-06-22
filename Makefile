CC=gcc
CFLAGS=-c
LDFLAGS=-lfl
LEX=lex
LEXFLAGS=
YACC=bison
YACCFLAGS=

all: obj/main.o obj/aux.o obj/yyerror.o obj/structure.o obj/json.lex.yy.o obj/json.tab.o yacc lex
	mkdir -p bin
	$(CC) obj/main.o obj/aux.o obj/yyerror.o obj/structure.o obj/json.lex.yy.o obj/json.tab.o -o bin/json $(LDFLAGS)
	chmod u+x bin/json

obj:
	mkdir -p obj	

obj/main.o: obj src/main.c
	$(CC) $(CFLAGS) src/main.c -o obj/main.o

obj/aux.o: obj src/aux.c
	$(CC) $(CFLAGS) src/aux.c -o obj/aux.o

obj/yyerror.o: obj src/yyerror.c
	$(CC) $(CFLAGS) src/yyerror.c -o obj/yyerror.o

obj/structure.o: obj src/structure.c
	$(CC) $(CFLAGS) src/structure.c -o obj/structure.o

obj/json.lex.yy.o: obj lex yacc
	$(CC) $(CFLAGS) lex/json.lex.yy.c -o obj/json.lex.yy.o

obj/json.tab.o: obj yacc
	$(CC) $(CFLAGS) yacc/json.tab.c -o obj/json.tab.o

lex: src/json.lex
	mkdir -p lex
	$(LEX) $(LEXFLAGS) -o lex/json.lex.yy.c src/json.lex

yacc: src/json.y
	mkdir -p yacc
	$(YACC) $(YACCFLAGS) -o yacc/json.tab.c --defines=yacc/json.tab.h src/json.y
	
clean:
	rm -rf obj
	rm -rf lex
	rm -rf yacc
	rm -rf bin

