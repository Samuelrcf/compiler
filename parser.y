%{
#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>
using namespace std;

int yylex(void);
int yyparse(void);
void yyerror(const char *);

void print_rule(const char* rule_name) {
    printf("Regra aplicada: %s\n", rule_name);
}

%}

%token CLASS EQUIVALENTTO INDIVIDUALS SUBCLASSOF DISJOINTCLASSES DISJOINTWITH LEFT_PARENTHESIS RIGHT_PARENTHESIS LEFT_BRACKET RIGHT_BRACKET
%token RATIONAL REAL LANGSTRING PLAINLITERAL XMLLITERAL LITERAL ANYURI BASE64BINARY BOOLEAN BYTE GREATER_THAN_SIGN LESS_THAN_SIGN
%token DATETIME DATETIMESTAMP DECIMAL DOUBLE FLOAT HEXBINARY INT INTEGER LANGUAGE LONG NAME NCNAME EQUALS RIGHT_BRACE LEFT_BRACE
%token NEGATIVEINTEGER NMTOKEN NONNEGATIVEINTEGER NONPOSITIVEINTEGER NORMALIZEDSTRING POSITIVEINTEGER
%token SHORT STRING TOKEN UNSIGNEDBYTE UNSIGNEDINT UNSIGNEDLONG UNSIGNEDSHORT INDIVIDUAL CLASSNAME
%token PROPERTY SPECIAL_SYMBOL NAMESPACE INVALID_TOKEN CARDINAL SOME ONLY THAT EXACTLY MAX MIN VALUE ALL NOT OR AND COMMA

%%

classes
        : class
        | class classes
        ;

class
        : CLASS CLASSNAME subclass_disjoint_individuals
        | CLASS CLASSNAME equivalent_to {print_rule("Classe definida");}
        | CLASS CLASSNAME class_closure_axiom {print_rule("Classe com axioma de fechamento");}
        ;

subclass_disjoint_individuals 
        :   SUBCLASSOF subc_properties optional_disjoint_individuals {print_rule("Classe primitiva");}
        ;

class_closure_axiom
        :   SUBCLASSOF descriptions 
        ;

optional_disjoint_individuals
        :   DISJOINTCLASSES disjoint_classes optional_individuals
        |   optional_individuals
        ;

equivalent_to
        :   EQUIVALENTTO descriptions optional_individuals 
        |   EQUIVALENTTO enumerated_class {print_rule("Classe enumerada");}
        |   EQUIVALENTTO class_list  {print_rule("Classe coberta");}
        ;

enumerated_class
        : LEFT_BRACE class_list RIGHT_BRACE

optional_individuals
        :   INDIVIDUALS individuals
        |   
        ;

descriptions
        :   description
        |   CLASSNAME AND descriptions
        ;

description
        :   LEFT_PARENTHESIS PROPERTY SOME CLASSNAME RIGHT_PARENTHESIS
        |   LEFT_PARENTHESIS PROPERTY SOME LEFT_PARENTHESIS PROPERTY VALUE CLASSNAME RIGHT_PARENTHESIS RIGHT_PARENTHESIS {print_rule("Classe com descrições aninhadas");}
        |   LEFT_PARENTHESIS PROPERTY SOME NAMESPACE INTEGER LEFT_BRACKET GREATER_THAN_SIGN EQUALS CARDINAL RIGHT_BRACKET RIGHT_PARENTHESIS
        |   CLASSNAME COMMA subc_properties
        ;

subc_properties
        : subc_property
        | subc_properties COMMA subc_property
        ;

subc_property
        : PROPERTY SOME CLASSNAME
        | PROPERTY SOME subc_namespace_type
        | PROPERTY ONLY subc_logical_expression
        ;

subc_namespace_type
        : NAMESPACE INTEGER
        | NAMESPACE STRING
        | NAMESPACE FLOAT
        ;

subc_logical_expression
        : subc_atomic
        | subc_atomic OR subc_logical_expression
        ;

subc_atomic
        : CLASSNAME
        | LEFT_PARENTHESIS subc_logical_expression RIGHT_PARENTHESIS
        ;

disjoint_classes
        :   class_list
        ;

class_list
        :   CLASSNAME 
        |   CLASSNAME COMMA class_list
        |   CLASSNAME OR class_list 
        ;

individuals
        :   individual
        ;

individual
        :   INDIVIDUAL COMMA individual
        |   INDIVIDUAL
        ;

/*quantifier
        : SOME
        | VALUE
        | THAT
        | MIN
        | MAX
        | ALL
        | EXACTLY
        | ONLY

relop
        : OR
        | NOT
        | AND*/

%%

int main() {
    cout << "Digite a definição da classe:\n";
    yyparse();  // Chama o parser gerado pelo Bison
    return 0;
}

void yyerror(const char* msg) {

        extern int yylineno;
        extern char * yytext;

        cout << "Erro sintático: TOKEN \"" << yytext << "\" (Linha " << yylineno << ")\n";
}

