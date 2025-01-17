%{
#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>
#include <cstring>
using namespace std;

int yylex(void);
int yyparse(void);
void yyerror(const char *);

void print_rule(const char* rule_name) {
    printf("Regra aplicada: %s\n", rule_name);
}

extern int yylineno;

%}

%token CLASS EQUIVALENTTO INDIVIDUALS SUBCLASSOF DISJOINTCLASSES DISJOINTWITH LEFT_PARENTHESIS RIGHT_PARENTHESIS LEFT_BRACKET RIGHT_BRACKET SPECIAL_SYMBOL 
%token RATIONAL REAL LANGSTRING PLAINLITERAL XMLLITERAL LITERAL ANYURI BASE64BINARY BOOLEAN BYTE GREATER_THAN_SIGN LESS_THAN_SIGN
%token DATETIME DATETIMESTAMP DECIMAL DOUBLE FLOAT HEXBINARY INT INTEGER LANGUAGE LONG NAME NCNAME EQUALS RIGHT_BRACE LEFT_BRACE
%token NEGATIVEINTEGER NMTOKEN NONNEGATIVEINTEGER NONPOSITIVEINTEGER NORMALIZEDSTRING POSITIVEINTEGER
%token SHORT STRING TOKEN UNSIGNEDBYTE UNSIGNEDINT UNSIGNEDLONG UNSIGNEDSHORT INDIVIDUAL CLASSNAME
%token PROPERTY NAMESPACE CARDINAL SOME ONLY THAT EXACTLY MAX MIN VALUE ALL NOT OR AND COMMA


%%

classes
        : class
        | class classes
        | error {
            printf("Erro na criação da classe. O analisador esperava a declaração 'Class:'.\n");
            exit(EXIT_FAILURE); 
        }
        ;

class
        : CLASS CLASSNAME subclass_disjoint_individuals 
        | CLASS CLASSNAME equivalent_to {print_rule("Classe definida\n");}
        | CLASS CLASSNAME error {
            printf("Erro na criação da classe. O analisador esperava a declaração 'SubClassOf:' ou 'EquivalentTo:'.\n");
            exit(EXIT_FAILURE); 
        }
        | CLASS error {
            printf("Erro na criação da classe. O analisador esperava o nome de uma classe.\n");
            exit(EXIT_FAILURE); 
        }
        ;

subclass_disjoint_individuals 
        :   SUBCLASSOF descriptions optional_disjoint_with optional_equivalent_to optional_disjoint_individuals 
        |   SUBCLASSOF CLASSNAME
        |   SUBCLASSOF error {
            printf("Erro na criação da classe primitiva. O analisador esperava a declaração 'SubClassOf:' seguido de descrições.\n");
            exit(EXIT_FAILURE); 
            }
        ;

optional_disjoint_with
    : DISJOINTWITH CLASSNAME
    |
    ;

optional_disjoint_individuals
        :   DISJOINTCLASSES class_list_comma optional_individuals
        |   optional_individuals
        |   DISJOINTCLASSES error {
            printf("Erro na definição das classes disjuntas. O analisador esperava uma classe ou uma lista de classes.\n");
            exit(EXIT_FAILURE); 
        }
        ;

equivalent_to
        :   EQUIVALENTTO descriptions optional_subclass_of optional_disjoint_individuals 
        |   EQUIVALENTTO enumerated_individuals {print_rule("Classe enumerada");}
        |   EQUIVALENTTO class_list_or optional_subclass_of optional_disjoint_individuals {print_rule("Classe coberta");}
        |   EQUIVALENTTO error {
            printf("Erro na criação da classe definida. O analisador esperava a declaração 'EquivalentTo:' seguido de descrições, lista de classes ou de uma enumeração de indivíduos.\n");
            exit(EXIT_FAILURE); 
            }
        ;

optional_subclass_of
        :   SUBCLASSOF descriptions
        |   SUBCLASSOF CLASSNAME
        |   SUBCLASSOF error {
            printf("Erro na criação da classe definida. O analisador esperava a declaração 'SubClassOf:' seguido de descrições.\n");
            exit(EXIT_FAILURE); 
            }
        |
        ;

optional_equivalent_to
        :   EQUIVALENTTO descriptions
        |   EQUIVALENTTO error {
            printf("Erro na criação da classe primitiva. O analisador esperava a declaração 'EquivalentTo:' seguido de descrições.\n");
            exit(EXIT_FAILURE); 
            }
        |   {print_rule("Classe primitiva\n");}
        ;

enumerated_individuals
        : LEFT_BRACE individual RIGHT_BRACE
        | LEFT_BRACE error {
            printf("Erro na criação da classe enumerada. O analisador esperava um indivíduo ou uma lista de indivíduos.\n");
            exit(EXIT_FAILURE); 
            }
        | LEFT_BRACE individual error {
            printf("Erro na criação da classe enumerada. O analisador esperava um colchete para fechar a lista de indivíduos.\n");
            exit(EXIT_FAILURE); 
            }
        ;

optional_individuals
        :   INDIVIDUALS individuals
        |   INDIVIDUALS error {
            printf("Erro na criação das instâncias. O analisador esperava um indivíduo ou uma lista de indivíduos.\n");
            exit(EXIT_FAILURE); 
            }
        |   
        ;

descriptions
        :   description
        |   CLASSNAME AND description
        |   CLASSNAME COMMA description
        |   CLASSNAME AND error {
            printf("Erro na criação das descrições. O analisador esperava uma descrição após o 'and'.\n");
            exit(EXIT_FAILURE); 
            }  
        |   CLASSNAME COMMA error {
            printf("Erro na criação das instâncias. O analisador esperava uma descrição após a vírgula.\n");
            exit(EXIT_FAILURE); 
            }             
        ;

description
        :   property_some_classname 
        |   property_some_namespace
        |   nested 
        ;

property_some_classname
        : PROPERTY ONLY CLASSNAME COMMA property_some_classname
        | PROPERTY ONLY CLASSNAME AND property_some_classname
        | PROPERTY ONLY CLASSNAME 
        | PROPERTY quantifier CARDINAL CLASSNAME
        | PROPERTY quantifier CARDINAL CLASSNAME COMMA property_some_classname
        | PROPERTY quantifier CARDINAL CLASSNAME AND property_some_classname
        | PROPERTY SOME subc_namespace_type
        | PROPERTY SOME CLASSNAME
        | PROPERTY SOME CLASSNAME COMMA property_some_classname
        | PROPERTY SOME CLASSNAME AND property_some_classname
        | PROPERTY SOME subc_namespace_type property_some_classname
        | PROPERTY PROPERTY only_or_some_or_quantifier CLASSNAME COMMA property_some_classname
        | PROPERTY PROPERTY only_or_some_or_quantifier CLASSNAME
        | property_only_description property_some_classname {print_rule("Classe com axioma de fechamento");}
        | property_only_description {print_rule("Classe com axioma de fechamento");}
        | PROPERTY SOME CLASSNAME AND error {
            printf("Erro na criação das descrições. O analisador esperava uma descrição após o 'and'.\n");
            exit(EXIT_FAILURE); 
            }
        | PROPERTY SOME CLASSNAME COMMA error {
            printf("Erro na criação das descrições. O analisador esperava uma descrição após a vírgula.\n");
            exit(EXIT_FAILURE); 
            }
        | PROPERTY quantifier CARDINAL error {
            printf("Erro na criação das descrições. O analisador esperava um nome de classe após a declaração do cardinal.\n");
            exit(EXIT_FAILURE); 
            }
        | PROPERTY ONLY error {
            printf("Erro na criação das descrições. O analisador esperava um nome de classe após a declaração do 'only'.\n");
            exit(EXIT_FAILURE); 
            }
        | PROPERTY SOME error {
            printf("Erro na criação das descrições. O analisador esperava um nome de classe ou um namespace (ex: xsd:) após a declaração do 'some'.\n");
            exit(EXIT_FAILURE); 
            }
        | PROPERTY quantifier error {
            printf("Erro na criação das descrições. O analisador esperava um cardinal após a declaração do quantificador.\n");
            exit(EXIT_FAILURE); 
            }
        | PROPERTY error {
            printf("Erro na criação das descrições. O analisador esperava a declaração de uma propriedade seguida de descrições.\n");
            exit(EXIT_FAILURE); 
            }
        ;

property_only_description
        : PROPERTY ONLY LEFT_PARENTHESIS class_list_or RIGHT_PARENTHESIS 
        | PROPERTY ONLY LEFT_PARENTHESIS class_list_or RIGHT_PARENTHESIS COMMA 
        | PROPERTY ONLY LEFT_PARENTHESIS class_list_or RIGHT_PARENTHESIS AND 
        | PROPERTY ONLY LEFT_PARENTHESIS class_list_or error {
            printf("Erro. O analisador esperava o fechamento de parêntese após a classe.\n");
            exit(EXIT_FAILURE); 
            }
        | PROPERTY ONLY LEFT_PARENTHESIS error {
            printf("Erro. O analisador esperava uma classe ou lista de classes após a abertura de parêntese.\n");
            exit(EXIT_FAILURE); 
            }
        ;

property_some_description
        : PROPERTY SOME LEFT_PARENTHESIS class_list_or RIGHT_PARENTHESIS
        | PROPERTY SOME LEFT_PARENTHESIS class_list_or error {
            printf("Erro. O analisador esperava o fechamento de parêntese após a classe.\n");
            exit(EXIT_FAILURE); 
            }
        | PROPERTY SOME LEFT_PARENTHESIS error {
            printf("Erro. O analisador esperava uma classe ou lista de classes após a abertura de parêntese.\n");
            exit(EXIT_FAILURE); 
            }
        | PROPERTY SOME error {
            printf("Erro. O analisador esperava a abertura de parêntese após o 'some'.\n");
            exit(EXIT_FAILURE); 
            }
        ;

property_only_or_some_classname_or_description
        : LEFT_PARENTHESIS PROPERTY only_or_some_or_quantifier CLASSNAME RIGHT_PARENTHESIS
        | LEFT_PARENTHESIS PROPERTY SOME subc_namespace_type RIGHT_PARENTHESIS
        | LEFT_PARENTHESIS PROPERTY quantifier CARDINAL subc_namespace_type RIGHT_PARENTHESIS
        | LEFT_PARENTHESIS PROPERTY SOME LEFT_PARENTHESIS PROPERTY VALUE INDIVIDUAL RIGHT_PARENTHESIS RIGHT_PARENTHESIS {print_rule("Classe com descrições aninhadas");}
        | LEFT_PARENTHESIS PROPERTY SOME LEFT_PARENTHESIS PROPERTY VALUE INDIVIDUAL RIGHT_PARENTHESIS error {
            printf("Erro. O analisador esperava o fechamento de parêntese.\n");
            exit(EXIT_FAILURE); 
            }
        | LEFT_PARENTHESIS PROPERTY SOME LEFT_PARENTHESIS PROPERTY VALUE INDIVIDUAL error {
            printf("Erro. O analisador esperava o fechamento de parêntese.\n");
            exit(EXIT_FAILURE); 
            }
        | LEFT_PARENTHESIS PROPERTY SOME LEFT_PARENTHESIS PROPERTY VALUE error {
            printf("Erro. O analisador esperava o nome de um indivíduo após o 'value'.\n");
            exit(EXIT_FAILURE); 
            }
        | LEFT_PARENTHESIS PROPERTY SOME LEFT_PARENTHESIS PROPERTY error {
            printf("Erro. O analisador esperava um 'value' após a propriedade.\n");
            exit(EXIT_FAILURE); 
            }
        | LEFT_PARENTHESIS PROPERTY SOME only_or_some_or_quantifier error {
            printf("Erro. O analisador esperava o nome de uma classe.\n");
            exit(EXIT_FAILURE); 
            }
        | LEFT_PARENTHESIS PROPERTY error {
            printf("Erro. O analisador esperava um 'only', 'some' ou um quantificador após a declaração da propriedade.\n");
            exit(EXIT_FAILURE); 
            }
        ;

nested
    : LEFT_PARENTHESIS nested_builds RIGHT_PARENTHESIS AND nested 
    | LEFT_PARENTHESIS nested_builds RIGHT_PARENTHESIS OR nested
    | LEFT_PARENTHESIS nested_builds RIGHT_PARENTHESIS {print_rule("Classe com descrições aninhadas");}
    | property_only_or_some_classname_or_description AND nested 
    | property_only_or_some_classname_or_description OR nested
    | property_only_or_some_classname_or_description COMMA property_some_classname
    | property_only_or_some_classname_or_description
    | LEFT_PARENTHESIS property_only_description RIGHT_PARENTHESIS AND nested
    | LEFT_PARENTHESIS property_some_description RIGHT_PARENTHESIS AND nested
    | LEFT_PARENTHESIS property_only_description RIGHT_PARENTHESIS OR nested
    | LEFT_PARENTHESIS property_some_description RIGHT_PARENTHESIS OR nested
    | LEFT_PARENTHESIS property_only_description RIGHT_PARENTHESIS {print_rule("Classe com descrições aninhadas");}
    | LEFT_PARENTHESIS property_some_description RIGHT_PARENTHESIS {print_rule("Classe com descrições aninhadas");}
    | LEFT_PARENTHESIS throw_error_nested error {
        printf("Erro na criação das descrições aninhadas. O analisador esperava fechamento do parêntese após as descrições.\n");
        exit(EXIT_FAILURE); 
        }
    | LEFT_PARENTHESIS error {
        printf("Erro na criação das descrições aninhadas. O analisador esperava descrições após a abertura do parêntese.\n");
        exit(EXIT_FAILURE); 
        }
    ;

throw_error_nested
        : property_some_description
        | property_only_description
        | nested_builds
        ;

nested_builds
    : LEFT_PARENTHESIS PROPERTY only_or_some_or_quantifier nested_builds RIGHT_PARENTHESIS
    | LEFT_PARENTHESIS PROPERTY only_or_some_or_quantifier nested_builds RIGHT_PARENTHESIS OR nested_builds
    | LEFT_PARENTHESIS PROPERTY only_or_some_or_quantifier nested_builds RIGHT_PARENTHESIS AND nested_builds
    | LEFT_PARENTHESIS class_list_or RIGHT_PARENTHESIS
    | LEFT_PARENTHESIS PROPERTY only_or_some_or_quantifier CLASSNAME RIGHT_PARENTHESIS
    | LEFT_PARENTHESIS PROPERTY only_or_some_or_quantifier CLASSNAME RIGHT_PARENTHESIS OR nested_builds
    | LEFT_PARENTHESIS PROPERTY only_or_some_or_quantifier CLASSNAME RIGHT_PARENTHESIS AND nested_builds
    | LEFT_PARENTHESIS PROPERTY only_or_some_or_quantifier throw_error_nested_builds2 error {
        printf("Erro na criação das descrições aninhadas. O analisador esperava um fechamento de parêntese.\n");
        exit(EXIT_FAILURE); 
        }
    | LEFT_PARENTHESIS PROPERTY only_or_some_or_quantifier error {
        printf("Erro na criação das descrições aninhadas. O analisador esperava o nome de uma classe ou outra descrição aninhada.\n");
        exit(EXIT_FAILURE); 
        }
    | LEFT_PARENTHESIS throw_error_nested_builds error {
        printf("Erro na criação das descrições aninhadas. O analisador esperava um 'only', 'some', um quantificador ou um fechamento de parêntese.\n");
        exit(EXIT_FAILURE); 
        }
    | LEFT_PARENTHESIS error {
        printf("Erro na criação das descrições aninhadas. O analisador esperava uma propriedade ou classe(s) após a abertura do parêntese.\n");
        exit(EXIT_FAILURE); 
        }
    ;

throw_error_nested_builds
        : PROPERTY
        | class_list_or
        ;

throw_error_nested_builds2
        : CLASSNAME
        | nested_builds
        ;

property_some_namespace
        : LEFT_PARENTHESIS PROPERTY SOME subc_namespace_type LEFT_BRACKET sign CARDINAL RIGHT_BRACKET RIGHT_PARENTHESIS
        | LEFT_PARENTHESIS PROPERTY SOME subc_namespace_type LEFT_BRACKET sign CARDINAL RIGHT_BRACKET error {
          printf("Erro. O analisador esperava um fechamento de parêntese após o colchete.\n");
          exit(EXIT_FAILURE); 
        }
        | LEFT_PARENTHESIS PROPERTY SOME subc_namespace_type LEFT_BRACKET sign CARDINAL error {
          printf("Erro. O analisador esperava um fechamento de colchete após a declaração do cardinal.\n");
          exit(EXIT_FAILURE); 
        }
        | LEFT_PARENTHESIS PROPERTY SOME subc_namespace_type LEFT_BRACKET sign error {
          printf("Erro. O analisador esperava um cardinal após a declaração do operador relacional.\n");
          exit(EXIT_FAILURE); 
        }
        | LEFT_PARENTHESIS PROPERTY SOME subc_namespace_type LEFT_BRACKET error {
          printf("Erro. O analisador esperava um operador relacional após a declaração do namespace.\n");
          exit(EXIT_FAILURE); 
        }
        | LEFT_PARENTHESIS PROPERTY SOME subc_namespace_type error {
          printf("Erro. O analisador esperava um colchete após a declaração do namespace.\n");
          exit(EXIT_FAILURE); 
        }
        ;

only_or_some_or_quantifier
        : SOME 
        | quantifier CARDINAL
        | ONLY
        ;

sign
        : GREATER_THAN_SIGN EQUALS
        | GREATER_THAN_SIGN
        | LESS_THAN_SIGN EQUALS
        | LESS_THAN_SIGN
        | EQUALS
        | EQUALS EQUALS
        ;

subc_namespace_type
        : NAMESPACE INTEGER
        | NAMESPACE STRING
        | NAMESPACE FLOAT
        | NAMESPACE error {
            printf("Erro na criação de um namespace. O analisador esperava uma declaração como integer, string ou float.\n");
            exit(EXIT_FAILURE); 
            }
        ;

class_list_or
        :   CLASSNAME 
        |   CLASSNAME OR class_list_or
        ;

class_list_comma
        :   CLASSNAME 
        |   CLASSNAME COMMA class_list_comma
        ;

individuals
        :   individual
        ;

individual
        :   INDIVIDUAL
        |   INDIVIDUAL COMMA individual
        ;

quantifier
        : MIN
        | MAX
        | EXACTLY
        ;

%%

int main() {
    yyparse(); 
    return 0;
}

void yyerror(const char* msg) {

        extern int yylineno;
        extern char * yytext;

        cout << "Erro sintático: TOKEN \"" << yytext << "\" (Linha " << yylineno << ")\n";
}

