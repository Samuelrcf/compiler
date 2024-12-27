%{
#include <iostream>
#include <string>
#include "symbol_table.h" 
#include "parser.tab.h"

using std::cout;
using std::string;

int types = 0, rational = 0, real = 0, langString = 0, plainLiteral = 0, xmlLiteral = 0, literal = 0, anyURI = 0, base64Binary = 0, boolean_ = 0, byte_ = 0, dateTime = 0, dateTimeStamp = 0, decimal = 0, doubleType = 0, floatType = 0, hexBinary = 0, intType = 0, integer = 0, language = 0, longType = 0, nameType = 0, ncName = 0, negativeInteger = 0, nmToken = 0, nonNegativeInteger = 0, nonPositiveInteger = 0, normalizedString = 0, positiveInteger = 0, shortType = 0, stringType = 0, tokenType = 0, unsignedByte = 0, unsignedInt = 0, unsignedLong = 0, unsignedShort = 0;

int quantifiers = 0, relOp = 0, keyWord = 0, operators = 0, classes = 0, literals = 0, properties = 0, symbols = 0, individuals = 0, nameSpaces = 0, cardinals = 0;

int andCount = 0, orCount = 0, notCount = 0, someCount = 0, allCount = 0, valueCount = 0, minCount = 0, maxCount = 0, exactlyCount = 0, thatCount = 0, onlyCount = 0, classCount = 0, equivalentToCount = 0, individualsCount = 0, subClassOfCount = 0, disjointClasses = 0, disjointWith = 0;

SymbolTable symbolTable; 
%}

%option noyywrap
%option yylineno

%%

[aA][nN][dD] {
    relOp++;
    andCount++;
    symbolTable.addSymbol("AND", "Relational Operator", yylineno);
    return AND; // Retorna um identificador para o token "AND"
}

[oO][rR] {
    relOp++;
    orCount++;
    symbolTable.addSymbol("OR", "Relational Operator", yylineno);
    return OR; // Retorna um identificador para o token "OR"
}

[nN][oO][tT] {
    relOp++;
    notCount++;
    symbolTable.addSymbol("NOT", "Relational Operator", yylineno);
    return NOT; // Retorna um identificador para o token "NOT"
}

[sS][oO][mM][eE] {
    quantifiers++;
    someCount++;
    symbolTable.addSymbol("SOME", "Quantifier", yylineno);
    return SOME; // Retorna um identificador para o token "SOME"
}

[aA][lL][lL] {
    quantifiers++;
    allCount++;
    symbolTable.addSymbol("ALL", "Quantifier", yylineno);
    return ALL; // Retorna um identificador para o token "ALL"
}

[vV][aA][lL][uU][eE] {
    quantifiers++;
    valueCount++;
    symbolTable.addSymbol("VALUE", "Quantifier", yylineno);
    return VALUE; // Retorna um identificador para o token "VALUE"
}

[mM][iI][nN] {
    quantifiers++;
    minCount++;
    symbolTable.addSymbol("MIN", "Quantifier", yylineno);
    return MIN; // Retorna um identificador para o token "MIN"
}

[mM][aA][xX] {
    quantifiers++;
    maxCount++;
    symbolTable.addSymbol("MAX", "Quantifier", yylineno);
    return MAX; // Retorna um identificador para o token "MAX"
}

[eE][xX][aA][cC][tT][lL][yY] {
    quantifiers++;
    exactlyCount++;
    symbolTable.addSymbol("EXACTLY", "Quantifier", yylineno);
    return EXACTLY; // Retorna um identificador para o token "EXACTLY"
}

[tT][hH][aA][tT] {
    quantifiers++;
    thatCount++;
    symbolTable.addSymbol("THAT", "Quantifier", yylineno);
    return THAT; // Retorna um identificador para o token "THAT"
}

[oO][nN][lL][yY] {
    quantifiers++;
    onlyCount++;
    symbolTable.addSymbol("ONLY", "Quantifier", yylineno);
    return ONLY; // Retorna um identificador para o token "ONLY"
}

"Class:" {
    symbolTable.addSymbol("Class", "Keyword", yylineno);
    classCount++;
    return CLASS; // Retorna identificador para "Class"
}

"EquivalentTo:" {
    symbolTable.addSymbol("EquivalentTo", "Keyword", yylineno);
    equivalentToCount++;
    return EQUIVALENTTO; // Retorna identificador para "EquivalentTo"
}

"Individuals:" {
    symbolTable.addSymbol("Individuals", "Keyword", yylineno);
    individualsCount++;
    return INDIVIDUALS; // Retorna identificador para "Individuals"
}

"SubClassOf:" {
    symbolTable.addSymbol("SubClassOf", "Keyword", yylineno);
    subClassOfCount++;
    return SUBCLASSOF; // Retorna identificador para "SubClassOf"
}

"DisjointClasses:" {
    symbolTable.addSymbol("DisjointClasses", "Keyword", yylineno);
    disjointClasses++;
    return DISJOINTCLASSES; // Retorna identificador para "DisjointClasses"
}

"DisjointWith:" {
    symbolTable.addSymbol("DisjointWith", "Keyword", yylineno);
    disjointWith++;
    return DISJOINTWITH; // Retorna identificador para "DisjointWith"
}

"rational" {
    symbolTable.addSymbol("rational", "Type", yylineno);
    rational++;
    return RATIONAL; // Retorna identificador para "rational"
}

"real" {
    symbolTable.addSymbol("real", "Type", yylineno);
    real++;
    return REAL; // Retorna identificador para "real"
}

"langString" {
    symbolTable.addSymbol("langString", "Type", yylineno);
    langString++;
    return LANGSTRING; // Retorna identificador para "langString"
}

"PlainLiteral" {
    symbolTable.addSymbol("PlainLiteral", "Type", yylineno);
    plainLiteral++;
    return PLAINLITERAL; // Retorna identificador para "PlainLiteral"
}

"XMLLiteral" {
    symbolTable.addSymbol("XMLLiteral", "Type", yylineno);
    xmlLiteral++;
    return XMLLITERAL; // Retorna identificador para "XMLLiteral"
}

"Literal" {
    symbolTable.addSymbol("Literal", "Type", yylineno);
    literal++;
    return LITERAL; // Retorna identificador para "Literal"
}

"anyURI" {
    symbolTable.addSymbol("anyURI", "Type", yylineno);
    anyURI++;
    return ANYURI; // Retorna identificador para "anyURI"
}

"base64Binary" {
    symbolTable.addSymbol("base64Binary", "Type", yylineno);
    base64Binary++;
    return BASE64BINARY; // Retorna identificador para "base64Binary"
}

"boolean" {
    symbolTable.addSymbol("boolean", "Type", yylineno);
    boolean_++;
    return BOOLEAN; // Retorna identificador para "boolean"
}

"byte" {
    symbolTable.addSymbol("byte", "Type", yylineno);
    byte_++;
    return BYTE; // Retorna identificador para "byte"
}

"dateTime" {
    symbolTable.addSymbol("dateTime", "Type", yylineno);
    dateTime++;
    return DATETIME; // Retorna identificador para "dateTime"
}

"dateTimeStamp" {
    symbolTable.addSymbol("dateTimeStamp", "Type", yylineno);
    dateTimeStamp++;
    return DATETIMESTAMP; // Retorna identificador para "dateTimeStamp"
}

"decimal" {
    symbolTable.addSymbol("decimal", "Type", yylineno);
    decimal++;
    return DECIMAL; // Retorna identificador para "decimal"
}

"double" {
    symbolTable.addSymbol("double", "Type", yylineno);
    doubleType++;
    return DOUBLE; // Retorna identificador para "double"
}

"float" {
    symbolTable.addSymbol("float", "Type", yylineno);
    floatType++;
    return FLOAT; // Retorna identificador para "float"
}

"hexBinary" {
    symbolTable.addSymbol("hexBinary", "Type", yylineno);
    hexBinary++;
    return HEXBINARY; // Retorna identificador para "hexBinary"
}

"int" {
    symbolTable.addSymbol("int", "Type", yylineno);
    intType++;
    return INT; // Retorna identificador para "int"
}

"integer" {
    symbolTable.addSymbol("integer", "Type", yylineno);
    integer++;
    return INTEGER; // Retorna identificador para "integer"
}

"language" {
    symbolTable.addSymbol("language", "Type", yylineno);
    language++;
    return LANGUAGE; // Retorna identificador para "language"
}

"long" {
    symbolTable.addSymbol("long", "Type", yylineno);
    longType++;
    return LONG; // Retorna identificador para "long"
}

"Name" {
    symbolTable.addSymbol("Name", "Type", yylineno);
    nameType++;
    return NAME; // Retorna identificador para "Name"
}

"NCName" {
    symbolTable.addSymbol("NCName", "Type", yylineno);
    ncName++;
    return NCNAME; // Retorna identificador para "NCName"
}

"negativeInteger" {
    symbolTable.addSymbol("negativeInteger", "Type", yylineno);
    negativeInteger++;
    return NEGATIVEINTEGER; // Retorna identificador para "negativeInteger"
}

"NMTOKEN" {
    symbolTable.addSymbol("NMTOKEN", "Type", yylineno);
    nmToken++;
    return NMTOKEN; // Retorna identificador para "NMTOKEN"
}

"nonNegativeInteger" {
    symbolTable.addSymbol("nonNegativeInteger", "Type", yylineno);
    nonNegativeInteger++;
    return NONNEGATIVEINTEGER; // Retorna identificador para "nonNegativeInteger"
}

"nonPositiveInteger" {
    symbolTable.addSymbol("nonPositiveInteger", "Type", yylineno);
    nonPositiveInteger++;
    return NONPOSITIVEINTEGER; // Retorna identificador para "nonPositiveInteger"
}

"normalizedString" {
    symbolTable.addSymbol("normalizedString", "Type", yylineno);
    normalizedString++;
    return NORMALIZEDSTRING; // Retorna identificador para "normalizedString"
}

"positiveInteger" {
    symbolTable.addSymbol("positiveInteger", "Type", yylineno);
    positiveInteger++;
    return POSITIVEINTEGER; // Retorna identificador para "positiveInteger"
}

"short" {
    symbolTable.addSymbol("short", "Type", yylineno);
    shortType++;
    return SHORT; // Retorna identificador para "short"
}

"string" {
    symbolTable.addSymbol("string", "Type", yylineno);
    stringType++;
    return STRING; // Retorna identificador para "string"
}

"token" {
    symbolTable.addSymbol("token", "Type", yylineno);
    tokenType++;
    return TOKEN; // Retorna identificador para "token"
}

"unsignedByte" {
    symbolTable.addSymbol("unsignedByte", "Type", yylineno);
    unsignedByte++;
    return UNSIGNEDBYTE; // Retorna identificador para "unsignedByte"
}

"unsignedInt" {
    symbolTable.addSymbol("unsignedInt", "Type", yylineno);
    unsignedInt++;
    return UNSIGNEDINT; // Retorna identificador para "unsignedInt"
}

"unsignedLong" {
    symbolTable.addSymbol("unsignedLong", "Type", yylineno);
    unsignedLong++;
    return UNSIGNEDLONG; // Retorna identificador para "unsignedLong"
}

"unsignedShort" {
    symbolTable.addSymbol("unsignedShort", "Type", yylineno);
    unsignedShort++;
    return UNSIGNEDSHORT; // Retorna identificador para "unsignedShort"
}

"," {
    symbols++;
    symbolTable.addSymbol("comma", "Special Symbol", yylineno);
    return COMMA; 
}

"(" {
    symbols++;
    symbolTable.addSymbol("leftParenthesis", "Special Symbol", yylineno);
    return LEFT_PARENTHESIS; 
}

")" {
    symbols++;
    symbolTable.addSymbol("rightParenthesis", "Special Symbol", yylineno);
    return RIGHT_PARENTHESIS; 
}

"[" {
    symbols++;
    symbolTable.addSymbol("leftBracket", "Special Symbol", yylineno);
    return LEFT_BRACKET; 
}

"]" {
    symbols++;
    symbolTable.addSymbol("rightBracket", "Special Symbol", yylineno);
    return RIGHT_BRACKET; 
}

"{" {
    symbols++;
    symbolTable.addSymbol("leftBrace", "Special Symbol", yylineno);
    return LEFT_BRACE; 
}

"}" {
    symbols++;
    symbolTable.addSymbol("rightBrace", "Special Symbol", yylineno);
    return RIGHT_BRACE; 
}

">" {
    symbols++;
    symbolTable.addSymbol("graterThan", "Special Symbol", yylineno);
    return GREATER_THAN_SIGN; 
}

"<" {
    symbols++;
    symbolTable.addSymbol("lessThan", "Special Symbol", yylineno);
    return LESS_THAN_SIGN; 
}

"=" {
    symbols++;
    symbolTable.addSymbol("equals", "Special Symbol", yylineno);
    return EQUALS; 
}

[A-Z][a-zA-Z]*[0-9]+ {
    individuals++;
    symbolTable.addSymbol(yytext, "Individual", yylineno);
    return INDIVIDUAL; // Retorna identificador para "Individual"
}

[A-Z][a-zA-Z]*(_[A-Z][a-zA-Z]*)* {
    classes++;
    symbolTable.addSymbol(yytext, "Class", yylineno);
    return CLASSNAME; // Retorna identificador para "Class Name"
}

[a-z][A-Za-z]* {
    properties++;
    symbolTable.addSymbol(yytext, "Property", yylineno);
    return PROPERTY; // Retorna identificador para "Property"
}

[\[\]{}()<>\,\"\=] {
    symbols++;
    symbolTable.addSymbol(yytext, "Special Symbol", yylineno);
    return SPECIAL_SYMBOL; // Retorna identificador para "Special Symbol"
}

[a-z]{3,4}: {
    nameSpaces++;
    symbolTable.addSymbol(yytext, "Namespace", yylineno);
    return NAMESPACE; // Retorna identificador para "Namespace"
}

[0-9]+[a-zA-Z!@#$%^&*()_+={}\[:;,.<>?/\\|~`-]+ {
    // Erro de token inválido
    cout << "[ERROR] Invalid Token: \"" << yytext << "\". Cardinal must not be followed by letters or invalid symbols. Line: " << yylineno << "\n";
    return INVALID_TOKEN; // Retorna identificador para "Invalid Token"
}

[0-9]+ {
    cardinals++;
    symbolTable.addSymbol(yytext, "Cardinal", yylineno);
    return CARDINAL; // Retorna identificador para "Cardinal"
}

[ \n\t\r]+                                { /* Ignorar espaços, tabs e novas linhas */ }
.                                       { cout << "[ERROR] Unknown token: " << yytext << " Line: " << yylineno << "\n"; } 

%%
