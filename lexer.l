%{
#include <iostream>
#include <string>
#include "symbol_table.h" // Inclua o cabeçalho da tabela de símbolos

using std::cout;
using std::string;

int types = 0, rational = 0, real = 0, langString = 0, plainLiteral = 0, xmlLiteral = 0, literal = 0, anyURI = 0, base64Binary = 0, boolean_ = 0, byte_ = 0, dateTime = 0, dateTimeStamp = 0, decimal = 0, doubleType = 0, floatType = 0, hexBinary = 0, intType = 0, integer = 0, language = 0, longType = 0, nameType = 0, ncName = 0, negativeInteger = 0, nmToken = 0, nonNegativeInteger = 0, nonPositiveInteger = 0, normalizedString = 0, positiveInteger = 0, shortType = 0, stringType = 0, tokenType = 0, unsignedByte = 0, unsignedInt = 0, unsignedLong = 0, unsignedShort = 0;

int quantifiers = 0, relOp = 0, keyWord = 0, operators = 0, classes = 0, literals = 0, properties = 0, symbols = 0, individuals = 0, nameSpace = 0, cardinals = 0, comments = 0;

int andCount = 0, orCount = 0, notCount = 0, someCount = 0, allCount = 0, valueCount = 0, minCount = 0, maxCount = 0, exactlyCount = 0, thatCount = 0, onlyCount = 0, classCount = 0, equivalentToCount = 0, individualsCount = 0, subClassOfCount = 0, disjointClasses = 0;

SymbolTable symbolTable; // Instância da tabela de símbolos
%}

%option noyywrap
%option yylineno

%%

[aA][nN][dD] {
    relOp++;
    andCount++;
    symbolTable.addSymbol("AND", "Relational Operator", yylineno);
    cout << "AND token\n";
}

[oO][rR] {
    relOp++;
    orCount++;
    symbolTable.addSymbol("OR", "Relational Operator", yylineno);
    cout << "OR token\n";
}

[nN][oO][tT] {
    relOp++;
    notCount++;
    symbolTable.addSymbol("NOT", "Relational Operator", yylineno);
    cout << "NOT token\n";
}

[sS][oO][mM][eE] {
    quantifiers++;
    someCount++;
    symbolTable.addSymbol("SOME", "Quantifier", yylineno);
    cout << "SOME token\n";
}

[aA][lL][lL] {
    quantifiers++;
    allCount++;
    symbolTable.addSymbol("ALL", "Quantifier", yylineno);
    cout << "ALL token\n";
}

[vV][aA][lL][uU][eE] {
    quantifiers++;
    valueCount++;
    symbolTable.addSymbol("VALUE", "Quantifier", yylineno);
    cout << "VALUE token\n";
}

[mM][iI][nN] {
    quantifiers++;
    minCount++;
    symbolTable.addSymbol("MIN", "Quantifier", yylineno);
    cout << "MIN token\n";
}

[mM][aA][xX] {
    quantifiers++;
    maxCount++;
    symbolTable.addSymbol("MAX", "Quantifier", yylineno);
    cout << "MAX token\n";
}

[eE][xX][aA][cC][tT][lL][yY] {
    quantifiers++;
    exactlyCount++;
    symbolTable.addSymbol("EXACTLY", "Quantifier", yylineno);
    cout << "EXACTLY token\n";
}

[tT][hH][aA][tT] {
    quantifiers++;
    thatCount++;
    symbolTable.addSymbol("THAT", "Quantifier", yylineno);
    cout << "THAT token\n";
}

[oO][nN][lL][yY] {
    quantifiers++;
    onlyCount++;
    symbolTable.addSymbol("ONLY", "Quantifier", yylineno);
    cout << "ONLY token\n";
}

"Class:" {
    symbolTable.addSymbol("Class", "Keyword", yylineno);
    cout << "Class token\n";
}

"EquivalentTo:" {
    symbolTable.addSymbol("EquivalentTo", "Keyword", yylineno);
    cout << "EquivalentTo token\n";
}

"Individuals:" {
    symbolTable.addSymbol("Individuals", "Keyword", yylineno);
    cout << "Individuals token\n";
}

"SubClassOf:" {
    symbolTable.addSymbol("SubClassOf", "Keyword", yylineno);
    cout << "SubClassOf token\n";
}

"DisjointClasses:" {
    symbolTable.addSymbol("DisjointClasses", "Keyword", yylineno);
    cout << "DisjointClasses token\n";
}

"rational" {
    symbolTable.addSymbol("rational", "Type", yylineno);
    cout << "RATIONAL token\n";
}

"real" {
    symbolTable.addSymbol("real", "Type", yylineno);
    cout << "REAL token\n";
}

"langString" {
    symbolTable.addSymbol("langString", "Type", yylineno);
    cout << "LANGSTRING token\n";
}

"PlainLiteral" {
    symbolTable.addSymbol("PlainLiteral", "Type", yylineno);
    cout << "PLAINLITERAL token\n";
}

"XMLLiteral" {
    symbolTable.addSymbol("XMLLiteral", "Type", yylineno);
    cout << "XMLLITERAL token\n";
}

"Literal" {
    symbolTable.addSymbol("Literal", "Type", yylineno);
    cout << "LITERAL token\n";
}

"anyURI" {
    symbolTable.addSymbol("anyURI", "Type", yylineno);
    cout << "ANYURI token\n";
}

"base64Binary" {
    symbolTable.addSymbol("base64Binary", "Type", yylineno);
    cout << "BASE64BINARY token\n";
}

"boolean" {
    symbolTable.addSymbol("boolean", "Type", yylineno);
    cout << "BOOLEAN token\n";
}

"byte" {
    symbolTable.addSymbol("byte", "Type", yylineno);
    cout << "BYTE token\n";
}

"dateTime" {
    symbolTable.addSymbol("dateTime", "Type", yylineno);
    cout << "DATETIME token\n";
}

"dateTimeStamp" {
    symbolTable.addSymbol("dateTimeStamp", "Type", yylineno);
    cout << "DATETIMESTAMP token\n";
}

"decimal" {
    symbolTable.addSymbol("decimal", "Type", yylineno);
    cout << "DECIMAL token\n";
}

"double" {
    symbolTable.addSymbol("double", "Type", yylineno);
    cout << "DOUBLE token\n";
}

"float" {
    symbolTable.addSymbol("float", "Type", yylineno);
    cout << "FLOAT token\n";
}

"hexBinary" {
    symbolTable.addSymbol("hexBinary", "Type", yylineno);
    cout << "HEXBINARY token\n";
}

"int" {
    symbolTable.addSymbol("int", "Type", yylineno);
    cout << "INT token\n";
}

"integer" {
    symbolTable.addSymbol("integer", "Type", yylineno);
    cout << "INTEGER token\n";
}

"language" {
    symbolTable.addSymbol("language", "Type", yylineno);
    cout << "LANGUAGE token\n";
}

"long" {
    symbolTable.addSymbol("long", "Type", yylineno);
    cout << "LONG token\n";
}

"Name" {
    symbolTable.addSymbol("Name", "Type", yylineno);
    cout << "NAME token\n";
}

"NCName" {
    symbolTable.addSymbol("NCName", "Type", yylineno);
    cout << "NCNAME token\n";
}

"negativeInteger" {
    symbolTable.addSymbol("negativeInteger", "Type", yylineno);
    cout << "NEGATIVEINTEGER token\n";
}

"NMTOKEN" {
    symbolTable.addSymbol("NMTOKEN", "Type", yylineno);
    cout << "NMTOKEN token\n";
}

"nonNegativeInteger" {
    symbolTable.addSymbol("nonNegativeInteger", "Type", yylineno);
    cout << "NONNEGATIVEINTEGER token\n";
}

"nonPositiveInteger" {
    symbolTable.addSymbol("nonPositiveInteger", "Type", yylineno);
    cout << "NONPOSITIVEINTEGER token\n";
}

"normalizedString" {
    symbolTable.addSymbol("normalizedString", "Type", yylineno);
    cout << "NORMALIZEDSTRING token\n";
}

"positiveInteger" {
    symbolTable.addSymbol("positiveInteger", "Type", yylineno);
    cout << "POSITIVEINTEGER token\n";
}

"short" {
    symbolTable.addSymbol("short", "Type", yylineno);
    cout << "SHORT token\n";
}

"string" {
    symbolTable.addSymbol("string", "Type", yylineno);
    cout << "STRING token\n";
}

"token" {
    symbolTable.addSymbol("token", "Type", yylineno);
    cout << "TOKEN token\n";
}

"unsignedByte" {
    symbolTable.addSymbol("unsignedByte", "Type", yylineno);
    cout << "UNSIGNEDBYTE token\n";
}

"unsignedInt" {
    symbolTable.addSymbol("unsignedInt", "Type", yylineno);
    cout << "UNSIGNEDINT token\n";
}

"unsignedLong" {
    symbolTable.addSymbol("unsignedLong", "Type", yylineno);
    cout << "UNSIGNEDLONG token\n";
}

"unsignedShort" {
    symbolTable.addSymbol("unsignedShort", "Type", yylineno);
    cout << "UNSIGNEDSHORT token\n";
}

[A-Z][a-zA-Z]*[0-9]+ {
    individuals++;
    symbolTable.addSymbol(yytext, "Individual", yylineno);
    cout << yytext << " Individual ID\n";
}

[A-Z][a-zA-Z]*(_[A-Z][a-zA-Z]*)* {
    classes++;
    symbolTable.addSymbol(yytext, "Class", yylineno);
    cout << yytext << " Class ID\n";
}

[a-z][A-Za-z]* {
    properties++;
    symbolTable.addSymbol(yytext, "Property", yylineno);
    cout << yytext << " Property ID\n";
}

[\[\]{}()<>\,\"\=] {
    cout << yytext << " Special Symbol ID\n";
}

[a-z]{3,4}: {
    symbolTable.addSymbol(yytext, "Namespace", yylineno);
    cout << yytext << " Namespace ID\n";
}

[0-9]+[a-zA-Z] {
    cout << "[ERROR] Invalid Token: " << yytext << ". Cardinal must be not followed by letters\n";
}

[0-9]+ {
    cardinals++;
    symbolTable.addSymbol(yytext, "Cardinal", yylineno);
    cout << yytext << " Cardinal ID\n";
}

[ \t\n]+                                { /* Ignorar espaços, tabs e novas linhas */ }
.                                       { cout << "Unknown token: " << yytext << "\n"; } 

%%

int main() {
    yyFlexLexer lexer;
    lexer.yylex();

    symbolTable.printTable();

    return 0;
}
