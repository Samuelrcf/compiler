%{
#include <iostream>
#include <string>
#include "symbol_table.h" // Inclua o cabeçalho da tabela de símbolos

using std::cout;
using std::string;

int types = 0, rational = 0, real = 0, langString = 0, plainLiteral = 0, xmlLiteral = 0, literal = 0, anyURI = 0, base64Binary = 0, boolean_ = 0, byte_ = 0, dateTime = 0, dateTimeStamp = 0, decimal = 0, doubleType = 0, floatType = 0, hexBinary = 0, intType = 0, integer = 0, language = 0, longType = 0, nameType = 0, ncName = 0, negativeInteger = 0, nmToken = 0, nonNegativeInteger = 0, nonPositiveInteger = 0, normalizedString = 0, positiveInteger = 0, shortType = 0, stringType = 0, tokenType = 0, unsignedByte = 0, unsignedInt = 0, unsignedLong = 0, unsignedShort = 0;

int quantifiers = 0, relOp = 0, keyWord = 0, operators = 0, classes = 0, literals = 0, properties = 0, symbols = 0, individuals = 0, nameSpaces = 0, cardinals = 0;

int andCount = 0, orCount = 0, notCount = 0, someCount = 0, allCount = 0, valueCount = 0, minCount = 0, maxCount = 0, exactlyCount = 0, thatCount = 0, onlyCount = 0, classCount = 0, equivalentToCount = 0, individualsCount = 0, subClassOfCount = 0, disjointClasses = 0, disjointWith = 0;

SymbolTable symbolTable; // Instância da tabela de símbolos
%}

%option noyywrap
%option yylineno

%%

[aA][nN][dD] {
    relOp++;
    andCount++;
    symbolTable.addSymbol("AND", "Relational Operator", yylineno);
}

[oO][rR] {
    relOp++;
    orCount++;
    symbolTable.addSymbol("OR", "Relational Operator", yylineno);
}

[nN][oO][tT] {
    relOp++;
    notCount++;
    symbolTable.addSymbol("NOT", "Relational Operator", yylineno);
}

[sS][oO][mM][eE] {
    quantifiers++;
    someCount++;
    symbolTable.addSymbol("SOME", "Quantifier", yylineno);
}

[aA][lL][lL] {
    quantifiers++;
    allCount++;
    symbolTable.addSymbol("ALL", "Quantifier", yylineno);
}

[vV][aA][lL][uU][eE] {
    quantifiers++;
    valueCount++;
    symbolTable.addSymbol("VALUE", "Quantifier", yylineno);
}

[mM][iI][nN] {
    quantifiers++;
    minCount++;
    symbolTable.addSymbol("MIN", "Quantifier", yylineno);
}

[mM][aA][xX] {
    quantifiers++;
    maxCount++;
    symbolTable.addSymbol("MAX", "Quantifier", yylineno);
}

[eE][xX][aA][cC][tT][lL][yY] {
    quantifiers++;
    exactlyCount++;
    symbolTable.addSymbol("EXACTLY", "Quantifier", yylineno);
}

[tT][hH][aA][tT] {
    quantifiers++;
    thatCount++;
    symbolTable.addSymbol("THAT", "Quantifier", yylineno);
}

[oO][nN][lL][yY] {
    quantifiers++;
    onlyCount++;
    symbolTable.addSymbol("ONLY", "Quantifier", yylineno);
}

"Class:" {
    symbolTable.addSymbol("Class", "Keyword", yylineno);
    classCount++;
}

"EquivalentTo:" {
    symbolTable.addSymbol("EquivalentTo", "Keyword", yylineno);
    equivalentToCount++;
}

"Individuals:" {
    symbolTable.addSymbol("Individuals", "Keyword", yylineno);
    individualsCount++;
}

"SubClassOf:" {
    symbolTable.addSymbol("SubClassOf", "Keyword", yylineno);
    subClassOfCount++;
}

"DisjointClasses:" {
    symbolTable.addSymbol("DisjointClasses", "Keyword", yylineno);
    disjointClasses++;
}

"DisjointWith:" {
    symbolTable.addSymbol("DisjointWith", "Keyword", yylineno);
    disjointWith++;
}

"rational" {
    symbolTable.addSymbol("rational", "Type", yylineno);
    rational++;
}

"real" {
    symbolTable.addSymbol("real", "Type", yylineno);
    real++;
}

"langString" {
    symbolTable.addSymbol("langString", "Type", yylineno);
    langString++;
}

"PlainLiteral" {
    symbolTable.addSymbol("PlainLiteral", "Type", yylineno);
    plainLiteral++;
}

"XMLLiteral" {
    symbolTable.addSymbol("XMLLiteral", "Type", yylineno);
    xmlLiteral++;
}

"Literal" {
    symbolTable.addSymbol("Literal", "Type", yylineno);
    literal++;
}

"anyURI" {
    symbolTable.addSymbol("anyURI", "Type", yylineno);
    anyURI++;
}

"base64Binary" {
    symbolTable.addSymbol("base64Binary", "Type", yylineno);
    base64Binary++;
}

"boolean" {
    symbolTable.addSymbol("boolean", "Type", yylineno);
    boolean_++;
}

"byte" {
    symbolTable.addSymbol("byte", "Type", yylineno);
    byte_++;
}

"dateTime" {
    symbolTable.addSymbol("dateTime", "Type", yylineno);
    dateTime++;
}

"dateTimeStamp" {
    symbolTable.addSymbol("dateTimeStamp", "Type", yylineno);
    dateTimeStamp++;
}

"decimal" {
    symbolTable.addSymbol("decimal", "Type", yylineno);
    decimal++;
}

"double" {
    symbolTable.addSymbol("double", "Type", yylineno);
    doubleType++;
}

"float" {
    symbolTable.addSymbol("float", "Type", yylineno);
    floatType++;
}

"hexBinary" {
    symbolTable.addSymbol("hexBinary", "Type", yylineno);
    hexBinary++;
}

"int" {
    symbolTable.addSymbol("int", "Type", yylineno);
    intType++;
}

"integer" {
    symbolTable.addSymbol("integer", "Type", yylineno);
    integer++;
}

"language" {
    symbolTable.addSymbol("language", "Type", yylineno);
    language++;
}

"long" {
    symbolTable.addSymbol("long", "Type", yylineno);
    longType++;
}

"Name" {
    symbolTable.addSymbol("Name", "Type", yylineno);
    nameType++;
}

"NCName" {
    symbolTable.addSymbol("NCName", "Type", yylineno);
    ncName++;
}

"negativeInteger" {
    symbolTable.addSymbol("negativeInteger", "Type", yylineno);
    negativeInteger++;
}

"NMTOKEN" {
    symbolTable.addSymbol("NMTOKEN", "Type", yylineno);
    nmToken++;
}

"nonNegativeInteger" {
    symbolTable.addSymbol("nonNegativeInteger", "Type", yylineno);
    nonNegativeInteger++;
}

"nonPositiveInteger" {
    symbolTable.addSymbol("nonPositiveInteger", "Type", yylineno);
    nonPositiveInteger++;
}

"normalizedString" {
    symbolTable.addSymbol("normalizedString", "Type", yylineno);
    normalizedString++;
}

"positiveInteger" {
    symbolTable.addSymbol("positiveInteger", "Type", yylineno);
    positiveInteger++;
}

"short" {
    symbolTable.addSymbol("short", "Type", yylineno);
    shortType++;
}

"string" {
    symbolTable.addSymbol("string", "Type", yylineno);
    stringType++;
}

"token" {
    symbolTable.addSymbol("token", "Type", yylineno);
    tokenType++;
}

"unsignedByte" {
    symbolTable.addSymbol("unsignedByte", "Type", yylineno);
    unsignedByte++;
}

"unsignedInt" {
    symbolTable.addSymbol("unsignedInt", "Type", yylineno);
    unsignedInt++;
}

"unsignedLong" {
    symbolTable.addSymbol("unsignedLong", "Type", yylineno);
    unsignedLong++;
}

"unsignedShort" {
    symbolTable.addSymbol("unsignedShort", "Type", yylineno);
    unsignedShort++;
}

[A-Z][a-zA-Z]*[0-9]+ {
    individuals++;
    symbolTable.addSymbol(yytext, "Individual", yylineno);
}

[A-Z][a-zA-Z]*(_[A-Z][a-zA-Z]*)* {
    classes++;
    symbolTable.addSymbol(yytext, "Class", yylineno);
}

[a-z][A-Za-z]* {
    properties++;
    symbolTable.addSymbol(yytext, "Property", yylineno);
}

[\[\]{}()<>\,\"\=] {
    symbols++;
    symbolTable.addSymbol(yytext, "Special Symbol", yylineno);
}

[a-z]{3,4}: {
    nameSpaces++;
    symbolTable.addSymbol(yytext, "Namespace", yylineno);
}

[0-9]+[a-zA-Z!@#$%^&*()_+={}\[:;,.<>?/\\|~`-]+ {
    cout << "[ERROR] Invalid Token: \"" << yytext << "\". Cardinal must not be followed by letters or invalid symbols. Line: " << yylineno << "\n";
}

[0-9]+ {
    cardinals++;
    symbolTable.addSymbol(yytext, "Cardinal", yylineno);
}

[ \n\t\r]+                                { /* Ignorar espaços, tabs e novas linhas */ }
.                                       { cout << "[ERROR] Unknown token: " << yytext << " Line: " << yylineno << "\n"; } 

%%

int main() {
    yyFlexLexer lexer;
    lexer.yylex();

    // Exibir contadores no final da execução
    std::cout << "\n--- Summary of Counts ---\n";
    std::cout << "  Rational: " << rational << "\n";
    std::cout << "  Real: " << real << "\n";
    std::cout << "  LangString: " << langString << "\n";
    std::cout << "  PlainLiteral: " << plainLiteral << "\n";
    std::cout << "  XMLLiteral: " << xmlLiteral << "\n";
    std::cout << "  Literal: " << literal << "\n";
    std::cout << "  AnyURI: " << anyURI << "\n";
    std::cout << "  Base64Binary: " << base64Binary << "\n";
    std::cout << "  Boolean: " << boolean_ << "\n";
    std::cout << "  Byte: " << byte_ << "\n";
    std::cout << "  DateTime: " << dateTime << "\n";
    std::cout << "  DateTimeStamp: " << dateTimeStamp << "\n";
    std::cout << "  Decimal: " << decimal << "\n";
    std::cout << "  Double: " << doubleType << "\n";
    std::cout << "  Float: " << floatType << "\n";
    std::cout << "  HexBinary: " << hexBinary << "\n";
    std::cout << "  Int: " << intType << "\n";
    std::cout << "  Integer: " << integer << "\n";
    std::cout << "  Language: " << language << "\n";
    std::cout << "  Long: " << longType << "\n";
    std::cout << "  Name: " << nameType << "\n";
    std::cout << "  NCName: " << ncName << "\n";
    std::cout << "  NegativeInteger: " << negativeInteger << "\n";
    std::cout << "  NMToken: " << nmToken << "\n";
    std::cout << "  NonNegativeInteger: " << nonNegativeInteger << "\n";
    std::cout << "  NonPositiveInteger: " << nonPositiveInteger << "\n";
    std::cout << "  NormalizedString: " << normalizedString << "\n";
    std::cout << "  PositiveInteger: " << positiveInteger << "\n";
    std::cout << "  Short: " << shortType << "\n";
    std::cout << "  String: " << stringType << "\n";
    std::cout << "  Token: " << tokenType << "\n";
    std::cout << "  UnsignedByte: " << unsignedByte << "\n";
    std::cout << "  UnsignedInt: " << unsignedInt << "\n";
    std::cout << "  UnsignedLong: " << unsignedLong << "\n";
    std::cout << "  UnsignedShort: " << unsignedShort << "\n";
    std::cout << "  Quantifiers: " << quantifiers << "\n";
    std::cout << "  RelOp: " << relOp << "\n";
    std::cout << "  KeyWord: " << keyWord << "\n";
    std::cout << "  Operators: " << operators << "\n";
    std::cout << "  Classes: " << classes << "\n";
    std::cout << "  Literals: " << literals << "\n";
    std::cout << "  Properties: " << properties << "\n";
    std::cout << "  Symbols: " << symbols << "\n";
    std::cout << "  Individuals: " << individuals << "\n";
    std::cout << "  NameSpaces: " << nameSpaces << "\n";
    std::cout << "  Cardinals: " << cardinals << "\n";
    std::cout << "  And: " << andCount << "\n";
    std::cout << "  Or: " << orCount << "\n";
    std::cout << "  Not: " << notCount << "\n";
    std::cout << "  Some: " << someCount << "\n";
    std::cout << "  All: " << allCount << "\n";
    std::cout << "  Value: " << valueCount << "\n";
    std::cout << "  Min: " << minCount << "\n";
    std::cout << "  Max: " << maxCount << "\n";
    std::cout << "  Exactly: " << exactlyCount << "\n";
    std::cout << "  That: " << thatCount << "\n";
    std::cout << "  Only: " << onlyCount << "\n";
    std::cout << "  Class: " << classCount << "\n";
    std::cout << "  EquivalentTo: " << equivalentToCount << "\n";
    std::cout << "  Individuals: " << individualsCount << "\n";
    std::cout << "  SubClassOf: " << subClassOfCount << "\n";
    std::cout << "  DisjointClasses: " << disjointClasses << "\n";
    std::cout << "--------------------------\n";


    symbolTable.printTable();

    return 0;
}
