%{
#include <iostream>
#include <string>
using std::cout;
using std::string;

int types = 0, rational = 0, real = 0, langString = 0, plainLiteral = 0, xmlLiteral = 0, literal = 0, anyURI = 0, base64Binary = 0, boolean_ = 0, byte_ = 0, dateTime = 0, dateTimeStamp = 0, decimal = 0, doubleType = 0, floatType = 0, hexBinary = 0, intType = 0, integer = 0, language = 0, longType = 0, nameType = 0, ncName = 0, negativeInteger = 0, nmToken = 0, nonNegativeInteger = 0, nonPositiveInteger = 0, normalizedString = 0, positiveInteger = 0, shortType = 0, stringType = 0, tokenType = 0, unsignedByte = 0, unsignedInt = 0, unsignedLong = 0, unsignedShort = 0;

int reserved = 0, operators = 0, classes = 0, literals = 0, properties = 0, symbols = 0, individuals = 0, nameSpace = 0, cardinals = 0, comments = 0;

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

([sS][oO][mM][eE])         { reserved++; someCount++; cout << "SOME token\n"; } //QUANTIFIERS
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

"rational"             { types++; rational++; cout << "RATIONAL token\n"; }
"real"                 { types++; real++; cout << "REAL token\n"; }
"langString"           { types++; langString++; cout << "LANGSTRING token\n"; }
"PlainLiteral"         { types++; plainLiteral++; cout << "PLAINLITERAL token\n"; }
"XMLLiteral"           { types++; xmlLiteral++; cout << "XMLLITERAL token\n"; }
"Literal"              { types++; literal++; cout << "LITERAL token\n"; }
"anyURI"               { types++; anyURI++; cout << "ANYURI token\n"; }
"base64Binary"         { types++; base64Binary++; cout << "BASE64BINARY token\n"; }
"boolean"              { types++; boolean_++; cout << "BOOLEAN token\n"; }
"byte"                 { types++; byte_++; cout << "BYTE token\n"; }
"dateTime"             { types++; dateTime++; cout << "DATETIME token\n"; }
"dateTimeStamp"        { types++; dateTimeStamp++; cout << "DATETIMESTAMP token\n"; }
"decimal"              { types++; decimal++; cout << "DECIMAL token\n"; }
"double"               { types++; doubleType++; cout << "DOUBLE token\n"; }
"float"                { types++; floatType++; cout << "FLOAT token\n"; }
"hexBinary"            { types++; hexBinary++; cout << "HEXBINARY token\n"; }
"int"                  { types++; intType++; cout << "INT token\n"; }
"integer"              { types++; integer++; cout << "INTEGER token\n"; }
"language"             { types++; language++; cout << "LANGUAGE token\n"; }
"long"                 { types++; longType++; cout << "LONG token\n"; }
"Name"                 { types++; nameType++; cout << "NAME token\n"; }
"NCName"               { types++; ncName++; cout << "NCNAME token\n"; }
"negativeInteger"      { types++; negativeInteger++; cout << "NEGATIVEINTEGER token\n"; }
"NMTOKEN"              { types++; nmToken++; cout << "NMTOKEN token\n"; }
"nonNegativeInteger"   { types++; nonNegativeInteger++; cout << "NONNEGATIVEINTEGER token\n"; }
"nonPositiveInteger"   { types++; nonPositiveInteger++; cout << "NONPOSITIVEINTEGER token\n"; }
"normalizedString"     { types++; normalizedString++; cout << "NORMALIZEDSTRING token\n"; }
"positiveInteger"      { types++; positiveInteger++; cout << "POSITIVEINTEGER token\n"; }
"short"                { types++; shortType++; cout << "SHORT token\n"; }
"string"               { types++; stringType++; cout << "STRING token\n"; }
"token"                { types++; tokenType++; cout << "TOKEN token\n"; }
"unsignedByte"         { types++; unsignedByte++; cout << "UNSIGNEDBYTE token\n"; }
"unsignedInt"          { types++; unsignedInt++; cout << "UNSIGNEDINT token\n"; }
"unsignedLong"         { types++; unsignedLong++; cout << "UNSIGNEDLONG token\n"; }
"unsignedShort"        { types++; unsignedShort++; cout << "UNSIGNEDSHORT token\n"; }

[A-Z][a-zA-Z]*[0-9]+  { individuals++; cout << yytext << " Individual token\n"; } // Identificadores de indivíduos

[A-Z][a-zA-Z]*(_[A-Z][a-zA-Z]*)* { classes++; cout << yytext << " Class token\n"; } // Identificadores de classes

[a-z][A-Za-z]*                          { properties++; cout << yytext << " Property token\n"; } // Identificadores de propriedades

[\[\]{}()<>\,\"\=]                        { symbols++; cout << yytext << " Special Symbol token\n"; } // Identificadores de símbolos especiais

[a-z]{3,4}:                             { nameSpace++; cout << yytext << " Namespace token\n"; } // Identificadores de namespace

[0-9]+                        { cardinals++; cout << yytext << " Cardinal token\n"; }

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
    cout << "NameSpaces: " << nameSpace << "\n";
    cout << "Cardinals: " << cardinals << "\n";
    cout << "Comments: " << comments << "\n";
}
