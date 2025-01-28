%{
#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>
#include <cstring>
#include <unordered_set>

using namespace std;

int yylex(void);
int yyparse(void);
void yyerror(const char *);

extern char* yytext;
extern int yylineno;

std::vector<std::string> classname_list;

std::vector<std::string> classname_list_for_only;

std::vector<std::string> property_list;

std::vector<std::pair<std::string, int>> possible_data_property_list;

std::vector<std::pair<std::string, int>> data_property_list;

std::vector<std::pair<std::string, int>> possible_object_property_list;

std::vector<std::pair<std::string, int>> object_property_list;

bool closure = false;
bool nested = false;
bool covered = false;
bool enumerated = false;

bool precedence_some = false;

bool precedence_only = false;

bool precedence_classname = false;
%}

%union {
    char* str;
}

%token <str> CLASSNAME
%token <str> PROPERTY

%token CLASS EQUIVALENTTO INDIVIDUALS SUBCLASSOF DISJOINTCLASSES DISJOINTWITH LEFT_PARENTHESIS RIGHT_PARENTHESIS LEFT_BRACKET RIGHT_BRACKET SPECIAL_SYMBOL 
%token RATIONAL REAL LANGSTRING PLAINLITERAL XMLLITERAL LITERAL ANYURI BASE64BINARY BOOLEAN BYTE GREATER_THAN_SIGN LESS_THAN_SIGN
%token DATETIME DATETIMESTAMP DECIMAL DOUBLE FLOAT HEXBINARY INT INTEGER LANGUAGE LONG NAME NCNAME EQUALS RIGHT_BRACE LEFT_BRACE
%token NEGATIVEINTEGER NMTOKEN NONNEGATIVEINTEGER NONPOSITIVEINTEGER NORMALIZEDSTRING POSITIVEINTEGER
%token SHORT STRING TOKEN UNSIGNEDBYTE UNSIGNEDINT UNSIGNEDLONG UNSIGNEDSHORT INDIVIDUAL 
%token NAMESPACE CARDINAL SOME ONLY THAT EXACTLY MAX MIN VALUE ALL NOT OR AND COMMA INVERSE DOT

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
        { 
            if (precedence_classname == true) {
                // mover itens de possible_data_property_list para data_property_list
                if (!possible_data_property_list.empty()) {
                    data_property_list.insert(data_property_list.end(),
                                            possible_data_property_list.begin(),
                                            possible_data_property_list.end());
                    possible_data_property_list.clear(); // limpar a lista
                }

                // mover itens de possible_object_property_list para object_property_list
                if (!possible_object_property_list.empty()) {
                    object_property_list.insert(object_property_list.end(),
                                                possible_object_property_list.begin(),
                                                possible_object_property_list.end());
                    possible_object_property_list.clear(); // limpar a lista 
                }
            }
            precedence_only = false;
            precedence_some = false;
            if (closure && !covered && !nested && !enumerated) {
                std::cout << $2 << ": Classe primitiva com axioma de fechamento" << std::endl << std::endl;
                closure = false;
            } else if (closure && !covered && nested && !enumerated) {
                std::cout << $2 << ": Classe primitiva com axioma de fechamento e descrições aninhadas" << std::endl << std::endl;
                closure = false;
                nested = false;
            } else if (!closure && covered && nested && !enumerated) {
                std::cout << $2 << ": Classe primitiva coberta com descrições aninhadas" << std::endl << std::endl;
                nested = false;
                covered = false;
            } else if (!closure && !covered && nested && !enumerated){
                std::cout << $2 << ": Classe primitiva com descrições aninhadas" << std::endl << std::endl;
                nested = false;
            } else if (!closure && covered && !nested && !enumerated){
                std::cout << $2 << ": Classe primitiva coberta" << std::endl << std::endl;
                nested = false;
                covered = false;
            } else if (closure && covered && !nested && !enumerated){
                std::cout << $2 << ": Classe primitiva coberta com axioma de fechamento" << std::endl << std::endl;
                nested = false;
                covered = false;
                closure = false;
            } else if (closure && !covered && !nested && enumerated){
                std::cout << $2 << ": Classe primitiva enumerada com axioma de fechamento" << std::endl << std::endl;
                nested = false;
                closure = false;
                enumerated = false;
            } else if (!closure && !covered && !nested && enumerated){
                std::cout << $2 << ": Classe primitiva enumerada" << std::endl << std::endl;
                enumerated = false;
            } else if (!closure && !covered && nested && enumerated){
                std::cout << $2 << ": Classe primitiva enumerada com descrições aninhadas" << std::endl << std::endl;
                enumerated = false;
                nested = false;
            } else {
                std::cout << $2 << ": Classe primitiva" << std::endl << std::endl;
            }
        }

        | CLASS CLASSNAME equivalent_to
        { 
            if (precedence_classname == true) {
                // mover itens de possible_data_property_list para data_property_list
                if (!possible_data_property_list.empty()) {
                    data_property_list.insert(data_property_list.end(),
                                            possible_data_property_list.begin(),
                                            possible_data_property_list.end());
                    possible_data_property_list.clear(); // limpar a lista
                }

                // mover itens de possible_object_property_list para object_property_list
                if (!possible_object_property_list.empty()) {
                    object_property_list.insert(object_property_list.end(),
                                                possible_object_property_list.begin(),
                                                possible_object_property_list.end());
                    possible_object_property_list.clear(); // limpar a lista 
                }
            }
            precedence_only = false;
            precedence_some = false;
            if (closure && !covered && !nested && !enumerated) {
                std::cout << $2 << ": Classe definida com axioma de fechamento" << std::endl << std::endl;
                closure = false;
            } else if (closure && !covered && nested && !enumerated) {
                std::cout << $2 << ": Classe definida com axioma de fechamento e descrições aninhadas" << std::endl << std::endl;
                closure = false;
                nested = false;
            } else if (!closure && covered && nested && !enumerated) {
                std::cout << $2 << ": Classe definida coberta com descrições aninhadas" << std::endl << std::endl;
                nested = false;
                covered = false;
            } else if (!closure && !covered && nested && !enumerated){
                std::cout << $2 << ": Classe definida com descrições aninhadas" << std::endl << std::endl;
                nested = false;
            } else if (!closure && covered && !nested && !enumerated){
                std::cout << $2 << ": Classe definida coberta" << std::endl << std::endl;
                covered = false;
            } else if (closure && covered && !nested && !enumerated){
                std::cout << $2 << ": Classe definida coberta com axioma de fechamento" << std::endl << std::endl;
                covered = false;
                closure = false;
            } else if (closure && !covered && !nested && enumerated){
                std::cout << $2 << ": Classe definida enumerada com axioma de fechamento" << std::endl << std::endl;
                enumerated = false;
                closure = false;
            } else if (!closure && !covered && !nested && enumerated){
                std::cout << $2 << ": Classe definida enumerada" << std::endl << std::endl;
                enumerated = false;
            } else if (!closure && !covered && nested && enumerated){
                std::cout << $2 << ": Classe definida enumerada com descrições aninhadas" << std::endl << std::endl;
                enumerated = false;
                nested = false;
            } else {
                std::cout << $2 << ": Classe definida" << std::endl << std::endl;
            }
        }

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
        :   SUBCLASSOF descriptions optional_disjoint_with optional_disjoint_individuals
        {
            if (!classname_list.empty() && precedence_only == true) {
                std::cerr << "Erro semântico: Axioma de fechamento declarado indevidamente. Linha " << yylineno << std::endl;
                exit(EXIT_FAILURE); 
            }
            classname_list.clear();
            property_list.clear();
        }
        |   SUBCLASSOF CLASSNAME
        |   SUBCLASSOF error {
            printf("Erro na criação da classe primitiva. O analisador esperava a declaração 'SubClassOf:' seguido de descrições ou do nome de uma classe.\n");
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
        {
            if (!classname_list.empty() && precedence_only == true) {
                std::cerr << "Erro semântico: Axioma de fechamento declarado indevidamente. Linha " << yylineno << std::endl;
                exit(EXIT_FAILURE); 
            }
            classname_list.clear();
            property_list.clear();
        }
        |   EQUIVALENTTO enumerated_individuals optional_subclass_of optional_disjoint_individuals 
        {
            if (!classname_list.empty() && precedence_only == true) {
                std::cerr << "Erro semântico: Axioma de fechamento declarado indevidamente. Linha " << yylineno << std::endl;
                exit(EXIT_FAILURE); 
            }
            enumerated = true;
            classname_list.clear();
            property_list.clear();
        }
        |   EQUIVALENTTO class_list_or optional_subclass_of optional_disjoint_individuals
        {
            if (!classname_list.empty() && precedence_only == true) {
                std::cerr << "Erro semântico: Axioma de fechamento declarado indevidamente. Linha " << yylineno << std::endl;
                exit(EXIT_FAILURE); 
            }
            covered = true;
            classname_list.clear();
            property_list.clear();
        }
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
        {
            precedence_classname = true;
        }
        |   CLASSNAME COMMA description
        {
            precedence_classname = true;
        }
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
        :   general_descriptions 
        |   nested 
        |   property_only_description 
        ;

general_descriptions
        : PROPERTY ONLY CLASSNAME COMMA general_descriptions
        {
            if(precedence_some == true){
                std::string last_element = property_list.back();
                if(last_element == $1){
                    std::cerr << "Erro semântico: Axioma de fechamento declarado indevidamente. Linha " << yylineno << std::endl;
                    exit(EXIT_FAILURE); 
                }
                std::string current_classname = std::string($3);
                if (!classname_list.empty()) {
                    bool found = false;

                    for (auto it = classname_list.begin(); it != classname_list.end(); ++it) {
                        if (*it == current_classname) {
                            classname_list.erase(it);
                            found = true; 
                            closure = true;
                            break;
                        }
                    }

                    if (!found) {
                        std::cerr << "Erro semântico: CLASSNAME '" << current_classname << "' não encontrado no axioma de fechamento. Linha " << yylineno << std::endl;
                        exit(EXIT_FAILURE); 
                    }
                }
            }
        }
        | PROPERTY ONLY CLASSNAME AND general_descriptions
        {
            if(precedence_some == true){
                std::string last_element = property_list.back();
                if(last_element == $1){ 
                    std::cerr << "Erro semântico: Axioma de fechamento declarado indevidamente. Linha " << yylineno << std::endl;
                    exit(EXIT_FAILURE); 
                }
                std::string current_classname = std::string($3);
                if (!classname_list.empty()) {
                    bool found = false;

                    for (auto it = classname_list.begin(); it != classname_list.end(); ++it) {
                        if (*it == current_classname) {
                            classname_list.erase(it);
                            found = true; 
                            closure = true;
                            break;
                        }
                    }

                    if (!found) {
                        std::cerr << "Erro semântico: CLASSNAME '" << current_classname << "' não encontrado no axioma de fechamento. Linha " << yylineno << std::endl;
                        exit(EXIT_FAILURE); 
                    }
                }
            }
        }
        | PROPERTY quantifier CARDINAL CLASSNAME
        | PROPERTY quantifier CARDINAL CLASSNAME COMMA general_descriptions
        | PROPERTY quantifier CARDINAL CLASSNAME AND general_descriptions
        | PROPERTY SOME subc_namespace_type
        {
            possible_data_property_list.emplace_back($1, yylineno);
        }
        | PROPERTY SOME CLASSNAME COMMA PROPERTY ONLY CLASSNAME 
        {
            possible_object_property_list.emplace_back($1, yylineno);
            precedence_only = true;
            std::string property1 = std::string($1);
            std::string property2 = std::string($5);
            std::string current_classname = std::string($3);
            if(property1 == property2){
                property_list.push_back($1);

                // comparando os dois CLASSNAME
                if (strcmp($3, $7) != 0) {
                    std::cerr << "Erro semântico: CLASSNAME '" << current_classname << "' não encontrado no axioma de fechamento. Linha " << yylineno << std::endl;
                    exit(EXIT_FAILURE); 
                }
                closure = true;

                free($3);
                free($7);
            }
        }

        | PROPERTY SOME CLASSNAME AND PROPERTY ONLY CLASSNAME
        {
            possible_object_property_list.emplace_back($1, yylineno);
            precedence_only = true;
            std::string property1 = std::string($1);
            std::string property2 = std::string($5);
            std::string current_classname = std::string($3);
            if(property1 == property2){
                property_list.push_back($1);

                if (strcmp($3, $7) != 0) {
                    std::cerr << "Erro semântico: CLASSNAME '" << current_classname << "' não encontrado no axioma de fechamento. Linha " << yylineno << std::endl;
                    exit(EXIT_FAILURE); 
                }
                closure = true;

                free($3);
                free($7);
            }
        }

        | PROPERTY SOME CLASSNAME
        {
            possible_object_property_list.emplace_back($1, yylineno);
            precedence_some = true;
            property_list.push_back($1);
            classname_list_for_only.push_back($3);
        }
        | PROPERTY SOME CLASSNAME COMMA general_descriptions 
        {
            possible_object_property_list.emplace_back($1, yylineno);
            precedence_some = true;
            property_list.push_back($1);
            if(precedence_only == true){
                std::string current_classname = std::string($3);
                if (!classname_list.empty()) {
                    bool found = false;

                    for (auto it = classname_list.begin(); it != classname_list.end(); ++it) {
                        if (*it == current_classname) {
                            classname_list.erase(it);
                            found = true; 
                            closure = true;
                            break;
                        }
                    }

                    if (!found) {
                        std::cerr << "Erro semântico: CLASSNAME '" << current_classname << "' não encontrado no axioma de fechamento. Linha " << yylineno << std::endl;
                        exit(EXIT_FAILURE); 
                    }
                }else{
                        std::cerr << "Erro semântico: CLASSNAME '" << current_classname << "' não encontrado no axioma de fechamento. Linha " << yylineno << std::endl;
                        exit(EXIT_FAILURE); 
                }
            } else{
                classname_list_for_only.push_back($3);
            }
            precedence_some = true;
            property_list.push_back($1);
        }
        | PROPERTY SOME CLASSNAME AND general_descriptions
        {
            possible_object_property_list.emplace_back($1, yylineno);
            precedence_some = true; // indica que apareceu um some
            property_list.push_back($1); // adicionar a propriedade da regra do some para verificar se é igual a da eventual regra do only
            if(precedence_only == true){ // se tiver aparecido um only, faço a verificação dos nomes de classes
                std::string current_classname = std::string($3);
                if (!classname_list.empty()) {
                    bool found = false;

                    for (auto it = classname_list.begin(); it != classname_list.end(); ++it) {
                        if (*it == current_classname) {
                            classname_list.erase(it);
                            found = true; 
                            closure = true;
                            break;
                        }
                    }

                    if (!found) { // se o only tiver aparecido antes e o nome de classe dele não corresponder ao nome de classe do some, lança exceção
                        std::cerr << "Erro semântico: CLASSNAME '" << current_classname << "' não encontrado no axioma de fechamento. Linha " << yylineno << std::endl;
                        exit(EXIT_FAILURE); 
                    }
                }else{ // lança exceção caso a lista esteja vazia mesmo aparecendo um axioma (only) antes
                        std::cerr << "Erro semântico: CLASSNAME '" << current_classname << "' não encontrado no axioma de fechamento. Linha " << yylineno << std::endl;
                        exit(EXIT_FAILURE); 
                }
            } else{ // adiciona na lista para verificar se o only que aparecer após regras do some (assim como a propreidade) são iguais, se forem, lança exceção e, caso a propriedade e os nomes de classes forem diferentes, não lança exceção, apesar de não ser boa prática
                classname_list_for_only.push_back($3);
            }
            precedence_some = true;
            property_list.push_back($1); // para verificação das propriedades iguais
        }
        | PROPERTY SOME CLASSNAME COMMA property_only_description 
        {   
            possible_object_property_list.emplace_back($1, yylineno);
            precedence_only = true;
            precedence_some = true;
            property_list.push_back($1);

            if (!classname_list.empty()) {
                std::string current_classname = std::string($3);
                bool found = false;

                for (auto it = classname_list.begin(); it != classname_list.end(); ++it) {
                    if (*it == current_classname) {
                        classname_list.erase(it);
                        found = true; 
                        closure = true;
                        break;
                    }
                }

                if (!found) {
                    std::cerr << "Erro semântico: CLASSNAME '" << current_classname << "' não encontrado no axioma de fechamento. Linha " << yylineno << std::endl;
                    exit(EXIT_FAILURE); 
                }
            } else{
                classname_list_for_only.push_back($3);
            }
        }

        | PROPERTY SOME CLASSNAME AND property_only_description
        {   
            possible_object_property_list.emplace_back($1, yylineno);
            precedence_only = true;
            precedence_some = true;
            property_list.push_back($1);

            if (!classname_list.empty()) {
                std::string current_classname = std::string($3);
                bool found = false;

                for (auto it = classname_list.begin(); it != classname_list.end(); ++it) {
                    if (*it == current_classname) {
                        classname_list.erase(it);
                        found = true; 
                        closure = true;
                        break; 
                    }
                }

                if (!found) {
                    std::cerr << "Erro semântico: CLASSNAME '" << current_classname << "' não encontrado no axioma de fechamento. Linha " << yylineno << std::endl;
                    exit(EXIT_FAILURE); 
                }
            } else{
                classname_list_for_only.push_back($3);
            }
        }

        | PROPERTY SOME subc_namespace_type general_descriptions
        {
            possible_data_property_list.emplace_back($1, yylineno);
        }
        | INVERSE PROPERTY only_or_some_or_quantifier CLASSNAME COMMA general_descriptions
        | INVERSE PROPERTY only_or_some_or_quantifier CLASSNAME AND general_descriptions
        | INVERSE PROPERTY only_or_some_or_quantifier CLASSNAME
        | INVERSE PROPERTY only_or_some_or_quantifier error {
            printf("Erro na criação das descrições. O analisador esperava o nome de uma classe.\n");
            exit(EXIT_FAILURE); 
            }
        | INVERSE PROPERTY error {
            printf("Erro na criação das descrições. O analisador esperava 'only', 'some' ou um quantificador após a propriedade.\n");
            exit(EXIT_FAILURE); 
            }
        | INVERSE error {
            printf("Erro na criação das descrições. O analisador esperava uma propriedade após o 'inverse'.\n");
            exit(EXIT_FAILURE); 
            }
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
        | PROPERTY ONLY LEFT_PARENTHESIS class_list_or RIGHT_PARENTHESIS COMMA general_descriptions
        {
            if (precedence_some == true) {
                std::string last_element = property_list.back();
                if (last_element == $1) {
                    std::cerr << "Erro semântico: Axioma de fechamento declarado indevidamente. Linha " << yylineno << std::endl;
                    exit(EXIT_FAILURE); 
                }
                if (!classname_list.empty() && !classname_list_for_only.empty()) {
                    // Usar um set para otimizar a busca
                    std::unordered_set<std::string> classname_set(classname_list_for_only.begin(), classname_list_for_only.end());
                    bool found = false;

                    for (const auto& classname : classname_list) {
                        if (classname_set.count(classname) > 0) {
                            found = true;
                            break;
                        }
                    }

                    if (found) {
                        std::cerr << "Erro semântico: Axioma de fechamento declarado indevidamente. Linha " << yylineno << std::endl;
                        exit(EXIT_FAILURE);
                    }
                }
            }
        }
        
        | PROPERTY ONLY LEFT_PARENTHESIS class_list_or RIGHT_PARENTHESIS AND general_descriptions
        {
            if (precedence_some == true) {
                std::string last_element = property_list.back();
                if (last_element == $1) {
                    std::cerr << "Erro semântico: Axioma de fechamento declarado indevidamente. Linha " << yylineno << std::endl;
                    exit(EXIT_FAILURE); 
                }
                if (!classname_list.empty() && !classname_list_for_only.empty()) {
                    // Usar um set para otimizar a busca
                    std::unordered_set<std::string> classname_set(classname_list_for_only.begin(), classname_list_for_only.end());
                    bool found = false;

                    for (const auto& classname : classname_list) {
                        if (classname_set.count(classname) > 0) {
                            found = true;
                            break;
                        }
                    }

                    if (found) {
                        std::cerr << "Erro semântico: Axioma de fechamento declarado indevidamente. Linha " << yylineno << std::endl;
                        exit(EXIT_FAILURE);
                    }
                }
            }
        }

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
        : LEFT_PARENTHESIS PROPERTY SOME CLASSNAME RIGHT_PARENTHESIS
        {
            possible_object_property_list.emplace_back($2, yylineno);
        }
        | LEFT_PARENTHESIS PROPERTY ONLY CLASSNAME RIGHT_PARENTHESIS
        | LEFT_PARENTHESIS PROPERTY quantifier CARDINAL CLASSNAME RIGHT_PARENTHESIS
        | LEFT_PARENTHESIS PROPERTY quantifier CARDINAL subc_namespace_type RIGHT_PARENTHESIS
        | LEFT_PARENTHESIS PROPERTY SOME subc_namespace_type RIGHT_PARENTHESIS
        {
            possible_data_property_list.emplace_back($2, yylineno);
        }
        | LEFT_PARENTHESIS PROPERTY SOME CARDINAL subc_namespace_type RIGHT_PARENTHESIS
        | LEFT_PARENTHESIS PROPERTY ONLY CARDINAL subc_namespace_type RIGHT_PARENTHESIS
        | LEFT_PARENTHESIS PROPERTY SOME LEFT_PARENTHESIS PROPERTY VALUE INDIVIDUAL RIGHT_PARENTHESIS RIGHT_PARENTHESIS
        {
            nested = true;
        }
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

or_and
    : AND
    | OR
    ;

nested
    : LEFT_PARENTHESIS nested_builds RIGHT_PARENTHESIS or_and nested
    {
        nested = true;
    }
    | LEFT_PARENTHESIS nested_builds RIGHT_PARENTHESIS
    {
        nested = true;
    }
    | property_only_or_some_classname_or_description or_and nested
    | property_only_or_some_classname_or_description COMMA general_descriptions
    | property_only_or_some_classname_or_description
    | LEFT_PARENTHESIS property_some_description RIGHT_PARENTHESIS or_and nested
    {
        nested = true;
    }
    | LEFT_PARENTHESIS property_only_description RIGHT_PARENTHESIS or_and nested
    {
        nested = true;
    }
    | LEFT_PARENTHESIS property_only_description RIGHT_PARENTHESIS
    {
        nested = true;
    }
    | LEFT_PARENTHESIS property_some_description RIGHT_PARENTHESIS
    {
        nested = true;
    }
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

only_or_some_or_quantifier
        : SOME 
        | quantifier CARDINAL
        | ONLY
        | quantifier error {
            printf("Erro. O analisador esperava um valor numérico após o quantificador.\n");
            exit(EXIT_FAILURE); 
        }
        ;

sign
        : GREATER_THAN_SIGN EQUALS
        | GREATER_THAN_SIGN
        | LESS_THAN_SIGN EQUALS
        | LESS_THAN_SIGN
        | EQUALS EQUALS
        ;

subc_namespace_type
        : NAMESPACE INTEGER LEFT_BRACKET sign CARDINAL RIGHT_BRACKET 
        | NAMESPACE INTEGER
        | NAMESPACE STRING
        | NAMESPACE DOUBLE LEFT_BRACKET sign CARDINAL DOT CARDINAL RIGHT_BRACKET 
        | NAMESPACE DOUBLE
        | NAMESPACE FLOAT LEFT_BRACKET sign CARDINAL DOT CARDINAL RIGHT_BRACKET 
        | NAMESPACE FLOAT
        | NAMESPACE error {
            printf("Erro na criação de um namespace. O analisador esperava uma declaração como integer, string ou float.\n");
            exit(EXIT_FAILURE); 
            }
        ;

class_list_or
        :   CLASSNAME 
        {
            classname_list.push_back($1);
        }
        |   CLASSNAME OR class_list_or
        {
            classname_list.push_back($1);
        }
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

    std::cout << "Data Property List:" << std::endl;
    for (const auto& property : data_property_list) {
        std::cout << property.first << " (line " << property.second << ")" << std::endl;
    }
    std::cout << std::endl;

    std::cout << "Object Property List:" << std::endl;
    for (const auto& property : object_property_list) {
        std::cout << property.first << " (line " << property.second << ")" << std::endl;
    }

    return 0;
}

void yyerror(const char* msg) {

        extern int yylineno;
        extern char * yytext;

        cout << "Erro sintático: TOKEN \"" << yytext << "\" (Linha " << yylineno << ")\n";
}

