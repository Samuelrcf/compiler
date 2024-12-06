%{
#include <iostream>
#include <string>
using std::cout;
using std::string;


int reserved = 0, operators = 0, classes = 0, literals = 0, properties = 0, symbols = 0, individuals = 0, typeOfData = 0, cardinals = 0, comments = 0;

// Contadores específicos para palavras reservadas
int andCount = 0, orCount = 0, notCount = 0, someCount = 0, allCount = 0, valueCount = 0, minCount = 0, maxCount = 0, exactlyCount = 0, thatCount = 0, onlyCount = 0, classCount = 0, equivalentToCount = 0, individualsCount = 0, subClassOfCount = 0, disjointClasses = 0;
%}

%option noyywrap

%x COMMENT

%%

\/\*                  { BEGIN(COMMENT); /* Entrar no estado de comentário */ }
<COMMENT>(.|\n)*?\*\/ { BEGIN(INITIAL); comments++; /* Sair do estado de comentário */ }

([aA][nN][dD])             { operators++; andCount++; cout << "AND token\n"; } 
([oO][rR])                 { operators++; orCount++; cout << "OR token\n"; }
([nN][oO][tT])             { operators++; notCount++; cout << "NOT token\n"; }
([sS][oO][mM][eE])         { reserved++; someCount++; cout << "SOME token\n"; }
([aA][lL][lL])             { reserved++; allCount++; cout << "ALL token\n"; }
([vV][aA][lL][uU][eE])     { reserved++; valueCount++; cout << "VALUE token\n"; }
([mM][iI][nN])             { reserved++; minCount++; cout << "MIN token\n"; }
([mM][aA][xX])             { reserved++; maxCount++; cout << "MAX token\n"; }
([eE][xX][aA][cC][tT][lL][yY]) { reserved++; exactlyCount++; cout << "EXACTLY token\n"; }
([tT][hH][aA][tT])         { reserved++; thatCount++; cout << "THAT token\n"; }
([oO][nN][lL][yY])         { reserved++; onlyCount++; cout << "ONLY token\n"; }
"Class:"                  { reserved++; classCount++; cout << "Class token\n"; }
"EquivalentTo:"           { reserved++; equivalentToCount++; cout << "EquivalentTo token\n"; }
"Individuals:"            { reserved++; individualsCount++; cout << "Individuals token\n"; }
"SubClassOf:"             { reserved++; subClassOfCount++; cout << "SubClassOf token\n"; }
"DisjointClasses:"        { reserved++; disjointClasses++; cout << "DisjointClasses token\n"; }

[A-Z][a-z]*[0-9]+  { individuals++; cout << yytext << ": Individual token\n"; } // Identificadores de indivíduos

[A-Z][a-zA-Z0-9]*(_[A-Z][a-zA-Z0-9]*)* { classes++; cout << yytext << ": Class token\n"; } // Identificadores de classes

[a-z][A-Za-z]*                          { properties++; cout << yytext << ": Property token\n"; } // Identificadores de propriedades

[\[\]{}()<>\,]                          { symbols++; cout << yytext << ": Special Symbol token\n"; } // Identificadores de símbolos especiais

[A-Za-z]+:[A-Za-z]+                     { typeOfData++; cout << yytext << ": Type of data\n"; } // Identificadores de tipos de dados [ALTERAR] dizer que são namespaces (owl, rdf, xsa e rdfs) e o da frente como "string" é o tipo, ou deixar tudo como dataType

(min|max|exactly)\s+[0-9]+              { cardinals++; cout << yytext << ": Cardinal token\n"; } // Identificadores de números cardinais

[ \t\n]+                                { /* Ignorar espaços, tabs e novas linhas */ }
.                                       { cout << "Unknown token: " << yytext << "\n"; } // Ignora outros caracteres

%%

int main() {
    yyFlexLexer lexer;
	lexer.yylex();
    cout << "Reserved: " << reserved << "\n";
    cout << "Operators: " << operators << "\n";
    cout << "Classes: " << classes << "\n";
    cout << "Literals: " << literals << "\n";
    cout << "Properties: " << properties << "\n";
    cout << "Special Symbols: " << symbols << "\n";
    cout << "Individuals: " << individuals << "\n";
    cout << "Type of Data: " << typeOfData << "\n";
    cout << "Cardinals: " << cardinals << "\n";
    cout << "Comments: " << comments << "\n";
}
