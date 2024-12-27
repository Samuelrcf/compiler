all: lexer

# Compiladores
CPP=g++
FLEX=flex
BISON=bison

# Dependências
all: lexer

lexer: lex.yy.c parser.tab.c
	$(CPP) lex.yy.c parser.tab.c -std=c++17 -o analyzer

lex.yy.c: lexer.l 
	$(FLEX) lexer.l   # Usando flex ao invés de flex++

parser.tab.c: parser.y
	$(BISON) -d parser.y 

clean:
	rm analyzer lex.yy.c parser.tab.c parser.tab.h
