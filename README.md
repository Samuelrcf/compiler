<h1>Implementação de um compilador(analisador léxico, sintático e semântico) para OWL Manchester Syntax</h1>

# Índice
1. [Objetivo](#objetivo)
2. [Equipe](#equipe)
3. [Requisitos](#requisitos)
4. [Instalação no Ubuntu (exemplo)](#instalação-no-ubuntu-exemplo)
5. [Estrutura do Projeto](#estrutura-do-projeto)
6. [Tutorial de Execução](#tutorial-de-execução)
7. [Tipos de Classes](#tipos-de-classes)
8. [Analisador Léxico](#analisador-léxico)
   - [Principais Componentes](#principais-componentes)
   - [Tabela de Símbolos](#tabela-de-símbolos)
9. [Analisador Sintático](#analisador-sintático)
   - [Descrição dos Tokens do Analisador Sintático](#descrição-dos-tokens-do-analisador-sintático)
   - [Regras de Produção do Analisador Sintático](#regras-de-produção-do-analisador-sintático)
   - [Saída do Analisador Sintático](#saída-do-analisador-sintático)
10. [Analisador Semântico](#analisador-semântico)
    - [Análise de Precedência dos Operadores de Cabeçalho](#análise-de-precedência-dos-operadores-de-cabeçalho)
        - [Precedência das Palavras-Chave](#precedência-das-palavras-chave)
        - [Axioma de Fechamento](#axioma-de-fechamento)
    - [Verificação Estática de Tipos por Coerção](#verificação-estática-de-tipos-por-coerção)
    - [Verifição Estática de Tipos Por Sobrecarga](#verifição-estática-de-tipos-por-sobrecarga)
11. [Considerações Finais](#considerações-finais)





<h2>Objetivo</h2>
<p>O projeto tem como objetivo desenvolver um compilador completo para a linguagem OWL Manchester Syntax, integrando as etapas de análise léxica, sintática e semântica. O analisador léxico é responsável por identificar e categorizar os elementos básicos da linguagem, como palavras reservadas, identificadores, e símbolos especiais. O analisador sintático verifica a estrutura gramatical das declarações, assegurando que estejam em conformidade com as regras de produção definidas. Por fim, o analisador semântico valida a lógica das declarações, auxiliando o ontologista a: (1) escrever as declarações usando a ordem correta dos operadores de cabeçalho (Class, SubclassOf, EquivalentTo, DisjointClasses, Individuals); (2) definir corretamente os tipos de dados e seus respectivos intervalos em data properties; e (3) classificar propriedades como data properties ou object properties, utilizando sobrecarga para simplificar a distinção. Esse compilador visa fornecer um suporte abrangente para a escrita e validação de ontologias, garantindo precisão e consistência.</p>

<h2>Equipe</h2>
<ul>
  <li>Erick Patrick de Paula Morais Freitas</li>
  <li>Samuel Rogenes Carvalho Freire</li>
</ul>

## Requisitos

Antes de começar, certifique-se de que você possui os seguintes requisitos:

- **G++** (ou outro compilador C++ compatível)
- **GDB** (para depuração)
- **Make** (opcional, se você preferir usar o Make ao invés do CMake)
- **CMake** (para construção do projeto)
- **Flex** (Ferramenta de Analisador Léxico)
- **Bison** (Ferramenta de Analisador Sintático)

### Instalação no Ubuntu (exemplo)

Se você não tem o Flex, Bison, CMake, Make, GCC ou GDB instalados, você pode instalar utilizando os seguintes comandos:

```bash
sudo apt-get update
sudo apt-get install flex bison cmake make g++ gdb
```

## Estrutura do Projeto

```plaintext
.
├── lexer.l                # Arquivo de definições do Flex (Analisador Léxico)
├── Makefile               # Arquivo de configuração para o Make
├── Parser.y               # Arquivo de definições do Bison (Analisador Sintático)
├── symbol_table.h         # Cabeçalho da tabela de símbolos
└── teste                  # Arquivo de texto com a linguagem **OWL2** no formato **Manchester Syntax** (usado para validar o lexer e gerar a tabela de símbolos)
```

<h2>Tutorial de Execução:</h2>
<ol>
  <li>
    <p>Certifique-se de estar em um ambiente Linux. Faça o donwload do projeto em formato zip ou utilizando git clone</p>
    <p>Para baixar o zip é necessário apenas ir em code e depois em Download ZIP e após isso extrair a pasta</p>
    <p>Se for utilizando o a ferramenta Git é necessário apenas ir no terminal e digitar o seguinte comando:</p>
    <code>git clone git@github.com:Samuelrcf/compiler.git</code>
    <p>Esse comando irá salvar o código em sua máquina local</p>
  </li>
  <li>
    <p>Importante: é necessário ter o flex e o bison configurado no Visual Studio Code para poder funcionar a compilação do projeto</p>
  </li>
  <li>
    <p>Agora para compilar o analisador usando o makeFile devemos digitar os seguintes comandos:</p>
    <code>make clean</code>
    <code>make</code>
  </li>
  <li>
    <p>Após compilar use o comando (você pode substituir "teste_analyzer" por qualquer arquivo de texto que esteja na mesma pasta do programa):</p>
    <code>./analyzer < teste_analyzer</code>
  </li>
  <li>
    <p>O programa irá gerar a análise sintática e mostrar se teve algum erro ou não encontrado no processo de análise</p>
  </li>
</ol>

<h2>Tipos de classes</h2>
<ul>
  <li>
    <h3>Classe Primitiva</h3>
    <p>Classe cujos indivíduos podem herdar suas propriedades, mas indivíduos avulsos que tenham tais propriedades não podem ser classificados como membros dessas classes. No exemplo a seguir, é possível notar que a declaração deste tipo de classe inclui as definições de propriedades abaixo do axioma “SubClassOf”, ou seja, todos os indivíduos da classe primitiva Pizza serão também membros de tudo o que tem alguma base (PizzaBase) e tudo o que tem conteúdo calórico de algum valor inteiro. Todas as classes podem conter as seções “DisjointClasses” e “Individuals” em suas descrições.</p>
    <h4>Exemplo</h4>
    <pre><code>Class: Pizza
SubClassOf:
  hasBase some PizzaBase,
  hasCaloricContent some xsd:integer

DisjointClasses:
  Pizza, PizzaBase, PizzaTopping

Individuals:
  CustomPizza1,
  CustomPizza2
</code></pre>
  </li>
  <li>
    <h3>Classe Definida</h3>
    <p>Classe que contém condições necessárias e suficientes em sua descrição. Em outros termos, esse tipo de classe não somente transfere suas características para seus indivíduos por herança, mas também permite inferir que indivíduos avulsos que tenham suas propriedades possam ser classificados como membros dessas classes. Uma classe definida normalmente tem uma seção definida pelo axioma “EquivalentTo:” sucedido por um conjunto de descrições. No exemplo abaixo, as classes CheesyPizza e HighCaloriePizza são definidas dessa forma.</p>
    <h4>Exemplo</h4>
    <pre><code>Class: CheesyPizza
EquivalentTo:
  Pizza and (hasTopping some CheeseTopping)

Individuals:
  CheesyPizza1
</code></pre>
  </li>
  <li>
    <h3>Classe com axioma de fechamento</h3>
    <p>Uma classe com axioma de fechamento contém normalmente uma cláusula que “fecha” ou restringe as imagens de suas relações a um conjunto bem definido de classes ou de expressões. No exemplo abaixo, note que a classe MargheritaPizza, como domínio da relação ou “tripla RDF” pode estar conectada a duas outras classes de imagem (MozzarellaTopping e TomatoTopping) mediante a propriedade hasTopping. Entretanto, é necessário tornar explícito para o reasoner (motor de inferência lógica) que esse tipo de pizza só pode ter esses dois tipos de cobertura. Por isso, a expressão “hasTopping only (MozzarellaTopping or TomatoTopping)” é considerada um “fechamento” da imagem da relação/propriedade hasTopping, que é usada para descrever as relações que MargheritaPizza tem com possíveis coberturas (Toppings)</p>
    <h4>Exemplo</h4>
    <pre><code>Class: MargheritaPizza
SubClassOf:
  NamedPizza,
  hasTopping some MozzarellaTopping,
  hasTopping some TomatoTopping,
  hasTopping only (MozzarellaTopping or TomatoTopping)
</code></pre>
  </li>
  <li>
    <h3>Classe com descrições aninhadas</h3>
    <p>É possível que a imagem de uma propriedade que descreve uma classe não seja necessariamente uma outra classe, mas outra tripla composta de propriedade, quantificador e outra classe. Esses aninhamentos criam estruturas semelhantes a orações coordenadas ou subordinadas, como estudamos na gramática da Língua Portuguesa, por exemplo. Observe como a expressão “hasSpiciness value Hot” compreende a imagem (ou objeto) da propriedade “hasTopping”</p>
    <h4>Exemplo</h4>
    <pre><code>Class: SpicyPizza
EquivalentTo:
  Pizza
  and (hasTopping some (hasSpiciness value Hot))
</code></pre>
  </li>
  <li>
    <h3>Classe Enumerada</h3>
    <p>Algumas classes podem ser definidas a partir de uma enumeração de suas possíveis instâncias. Por exemplo, uma classe denominada “dias_da_semana” poderia conter apenas sete instâncias, sendo uma para cada dia. Uma outra classe denominada “planetas_do_sistema_solar” poderia conter apenas oito instâncias. Em OWL, há uma forma de se especificar esse tipo de classe. Note que, no exemplo abaixo, a classe Spiciness é definida com um conjunto de instâncias (Hot, Medium e Mild), que aparecem entre chaves.</p>
    <h4>Exemplo</h4>
    <pre><code>Class: Spiciness
EquivalentTo: {Hot, Medium, Mild}
</code></pre>
  </li>
  <li>
    <h3>Classe Coberta</h3>
    <p>Uma variação do exemplo anterior consiste em especificar uma classe como sendo a superposição de suas classes filhas. Ou seja, neste caso teríamos a classe Spiciness como sendo a classe mãe e as classes Hot, Mild e Mild como sendo classes filhas. A implicação lógica nesse caso é de que qualquer indivíduo pertencente à classe mãe precisa também estar dentro de alguma classe filha. Esse tipo de classe poderia ser especificada da seguinte forma:</p>
    <h4>Exemplo</h4>
    <pre><code>Class: Spiciness
EquivalentTo: Hot or Medium or Mild
</code></pre>
  </li>
  <li>
    <h3>Classe Especial</h3>
    <p>Uma classe que não satisfaz nenhuma das anteriores</p>
    <h4>Exemplos</h4>
    <pre><code>Class: PizzaBase
DisjointClasses:
  Pizza, PizzaBase, PizzaTopping

Class: PizzaTopping
DisjointClasses:
  Pizza, PizzaBase, PizzaTopping

Class: Evaluated
EquivalentTo:
  BrokerServiceProvider or Connector or CoreParticipant
SubClassOf:
  FunctionalComplex
</code></pre>
  </li>
</ul>

            
---

<h1>Analisador Léxico</h1>

<h2>Principais Componentes</h2>

### Palavras Reservadas:

AND, OR, NOT: Operadores relacionais.

SOME, ALL, VALUE, MIN, MAX, EXACTLY, THAT: Quantificadores.

ONLY, CLASS, EQUIVALENTTO, INDIVIDUALS, SUBCLASSOF, DISJOINTCLASSES: Palavras-chave para descrever classes e relações entre elas.

### Tipos de Dados:

Tipos como rational, real, decimal, string, integer, entre outros, são reconhecidos e contados conforme aparecem no código de entrada.

### Classes:

começam com letra maiúscula e podem conter palavras compostas com ou sem separação por underline (ex.: ClassName, My_Class).

### Propriedades: 

começando com letra minúsculas, representando propriedades ou atributos de uma classe ou entidade (ex.: propertyName).

### Indivíduos: 

Identificadores que geralmente referenciam instâncias específicas de uma classe. Iniciam com letra maiúscula e terminam com números (ex.: Individual123).

### Símbolos Especiais:

Símbolos como colchetes, chaves, parênteses, e outros caracteres especiais são tratados como tokens separados.

### Namespaces:

Identificados por uma sequência de 3 a 4 letras minúsculas seguidas por dois pontos.

## Tabela de Símbolos

<p>O analisador mantém uma tabela de símbolos onde são armazenados os tokens identificados, suas categorias (por exemplo, tipo, classe, propriedade) e o número da linha onde foram encontrados.</p>

---

<h1>Analisador Sintático</h1>
            
<h2>Descrição dos Tokens do Analisador Sintático</h2>

<p>Este texto descreve os tokens definidos no analisador sintático e suas funções no contexto da linguagem analisada. Os tokens são representações simbólicas que ajudam o parser a identificar e processar elementos da entrada de acordo com regras gramaticais.</p>


## **Tokens de Estruturação e Agrupamento**

- **`CLASS`**: Declara uma nova classe.
- **`EQUIVALENTTO`**: Define equivalência entre classes ou conceitos.
- **`INDIVIDUALS`**: Lista de indivíduos associados a uma classe.
- **`SUBCLASSOF`**: Indica que uma classe é subclasse de outra.
- **`DISJOINTCLASSES`**: Declara que um conjunto de classes é mutuamente disjunto.
- **`DISJOINTWITH`**: Especifica que duas classes são disjuntas.


## **Tokens para Agrupamento e Delimitação**

- **`LEFT_PARENTHESIS`, `RIGHT_PARENTHESIS`**: Parênteses usados para agrupar expressões.
- **`LEFT_BRACKET`, `RIGHT_BRACKET`**: Colchetes para delimitar listas ou propriedades.
- **`LEFT_BRACE`, `RIGHT_BRACE`**: Chaves para enumerar classes ou indivíduos.


## **Tokens de Dados Literais**

Estes tokens representam tipos de dados frequentemente usados em descrições de propriedades:

- **Numéricos e Reais**
  - **`RATIONAL`**: Número racional.
  - **`REAL`**: Número real.
  - **`DECIMAL`**, **`DOUBLE`**, **`FLOAT`**: Representam diferentes formatos de números com ponto flutuante.
  - **`INT`**, **`INTEGER`**, **`SHORT`**, **`LONG`**: Representam números inteiros de diferentes precisões.
  - **`POSITIVEINTEGER`**, **`NEGATIVEINTEGER`**, **`NONNEGATIVEINTEGER`**, **`NONPOSITIVEINTEGER`**: Variantes de inteiros com restrições de sinal.

- **Strings e Literais**
  - **`LANGSTRING`**: String com especificação de linguagem.
  - **`PLAINLITERAL`**, **`XMLLITERAL`**, **`LITERAL`**: Tipos de literais para expressar valores textuais.
  - **`NORMALIZEDSTRING`**, **`TOKEN`**, **`NAME`**, **`NCNAME`**, **`NMTOKEN`**: Strings formatadas ou normalizadas para casos específicos.

- **Binários**
  - **`BASE64BINARY`**, **`HEXBINARY`**: Representações binárias em diferentes codificações.

- **Outros**
  - **`ANYURI`**: Representa um URI genérico.
  - **`BOOLEAN`**: Tipo de dado booleano (`true` ou `false`).
  - **`DATETIME`**, **`DATETIMESTAMP`**: Representam valores de data e hora.


## **Tokens de Relacionamento e Operadores**

- **Relacionamentos**
  - **`PROPERTY`**: Propriedades associadas a classes ou indivíduos.
  - **`NAMESPACE`**: Espaço de nome para identificar propriedades ou classes.
  - **`SPECIAL_SYMBOL`**: Representa símbolos especiais que podem aparecer nas expressões.

- **Operadores Lógicos e Quantificadores**
  - **`SOME`, `ONLY`, `EXACTLY`, `THAT`, `VALUE`, `ALL`, `MIN`, `MAX`**: Quantificadores usados para descrever restrições de propriedades.
  - **`AND`, `OR`, `NOT`**: Operadores lógicos para construir expressões complexas.

- **Comparações**
  - **`GREATER_THAN_SIGN`, `LESS_THAN_SIGN`**: Operadores de comparação usados em propriedades ou expressões.


## **Tokens de Separação e Erros**

- **Separação**
  - **`COMMA`**: Usado para separar itens em listas ou expressões.
  - **`EQUALS`**: Representa atribuições ou comparações.
  
- **Tratamento de Erros**
  - **`INVALID_TOKEN`**: Representa um token inválido encontrado durante a análise.


## **Tokens Específicos de Classes e Indivíduos**

- **`CLASSNAME`**: Identificador único para uma classe.
- **`INDIVIDUAL`**: Representa indivíduos que pertencem a uma classe ou relação.


<p>Estes tokens fornecem uma base estruturada para a análise de uma linguagem formal usada para descrever classes, indivíduos e suas relações, permitindo um entendimento claro e organizado de uma gramática rica em semântica.</p>
---

Aqui está uma reformulação mais clara e organizada do texto original, com base no código atualizado:

---

<h2>Regras de Produção do Analisador Sintático</h2>

As regras de produção definem a gramática utilizada pelo analisador sintático. Elas especificam como tokens básicos podem ser combinados para formar construções válidas na linguagem. Abaixo estão as principais regras, acompanhadas de explicações detalhadas.

---

### **1. Declaração de Classes**
```cpp
classes
    : class
    | class classes
    | error {
        printf("Erro na criação da classe. O analisador esperava a declaração 'Class:'.\n");
        exit(EXIT_FAILURE);
    }
    ;
```
- **Descrição:** 
  - Representa uma lista de declarações de classes.
  - Em caso de erro, uma mensagem é exibida.

```cpp
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
```
- **Descrição:** 
  - Define uma classe, que pode ser:
    - Primitiva, com subclasses ou disjunções.
    - Definida, com relações de equivalência.
  - Trata erros como a ausência de um nome de classe.

---

### **2. Subclasses e Disjunções**
```cpp
subclass_disjoint_individuals 
        :   SUBCLASSOF descriptions optional_disjoint_with optional_equivalent_to optional_disjoint_individuals 
        |   SUBCLASSOF CLASSNAME
        |   SUBCLASSOF error {
            printf("Erro na criação da classe primitiva. O analisador esperava a declaração 'SubClassOf:' seguido de descrições.\n");
            exit(EXIT_FAILURE); 
            }
        ;
```
- **Descrição:** 
  - Declara uma subclasse, com descrições opcionais de equivalência ou disjunções.

```cpp
optional_disjoint_individuals
        :   DISJOINTCLASSES class_list_comma optional_individuals
        |   optional_individuals
        |   DISJOINTCLASSES error {
            printf("Erro na definição das classes disjuntas. O analisador esperava uma classe ou uma lista de classes.\n");
            exit(EXIT_FAILURE); 
        }
        ;
```
- **Descrição:** 
  - Permite a declaração de classes disjuntas e/ou indivíduos associados.

---

### **3. Classes Definidas e Enumeradas**
```cpp
equivalent_to
        :   EQUIVALENTTO descriptions optional_subclass_of optional_disjoint_individuals 
        |   EQUIVALENTTO enumerated_individuals {print_rule("Classe enumerada");}
        |   EQUIVALENTTO class_list_or optional_subclass_of optional_disjoint_individuals {print_rule("Classe coberta");}
        |   EQUIVALENTTO error {
            printf("Erro na criação da classe definida. O analisador esperava a declaração 'EquivalentTo:' seguido de descrições, lista de classes ou de uma enumeração de indivíduos.\n");
            exit(EXIT_FAILURE); 
            }
        ;
```
- **Descrição:** 
  - Define uma classe equivalente, com descrições, enumerações ou cobertura.

```cpp
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
```
- **Descrição:** 
  - Representa uma classe definida explicitamente por indivíduos.

---
### 4. Classes Aninhadas

```cpp
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
```

- **Descrição:**  
  Essa regra permite a definição de **classes aninhadas**, ou seja, classes que contêm outras classes ou descrições dentro de parênteses para expressar relações complexas ou hierarquias.  

  - As classes podem ser combinadas utilizando operadores lógicos como **AND** e **OR**.
  - Suportam descrições baseadas em propriedades, restrições ou combinações de classes.
  - Permite estruturas aninhadas, que são ideais para representar relações sofisticadas entre elementos ou especificar axiomas compostos.

#### **Exemplo de uso:**
```text
(ClassA AND (ClassB OR (PropertyX SOME ClassC)))
```

Neste exemplo:
- **ClassA** é combinada com uma estrutura aninhada.
- A estrutura aninhada contém **ClassB OR** outra descrição baseada na propriedade **PropertyX SOME ClassC**.

### **5. Descrições e Propriedades**
```cpp
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
```
- **Descrição:** 
  - Lista de descrições conectadas por operadores lógicos.

```cpp
description
        :   property_some_classname 
        |   property_some_namespace
        |   nested 
        ;
```
- **Descrição:** 
  - Define propriedades e restrições de uma classe, incluindo descrições aninhadas.

---

### **6. Indivíduos**
```cpp
optional_individuals
        :   INDIVIDUALS individuals
        |   INDIVIDUALS error {
            printf("Erro na criação das instâncias. O analisador esperava um indivíduo ou uma lista de indivíduos.\n");
            exit(EXIT_FAILURE); 
            }
        |   
        ;
```
```cpp
individuals
    : individual
    ;
```
```cpp
individual
        :   INDIVIDUAL
        |   INDIVIDUAL COMMA individual
        ;
```
- **Descrição:** 
  - Permite a declaração de indivíduos associados a uma classe.

---

### **7. Quantificadores**
```cpp
quantifier
    | MIN
    | MAX
    | EXACTLY
    ;
```
- **Descrição:** 
  - Define restrições quantitativas aplicadas a propriedades, como:
    - **SOME**: Pelo menos um valor.
    - **ONLY**: Apenas valores específicos.

---

### **8. Some, Only e Quantificadores**
```cpp
only_or_some_or_quantifier
        : SOME 
        | quantifier CARDINAL
        | ONLY
        ;
```
- **Descrição:** 
  - **SOME**: Pelo menos um valor.
  - **ONLY**: Apenas valores específicos.

---

<h2>Saída do Analisador Sintático</h2>
<p>Para cada classe identificada pelo analisador sintático será exibido uma mensagem com o tipo da classe identificada e suas características(se houver). Por exemplo:</p>
<P><strong>Entrada:</strong></P>
<pre><code>Class: Pizza
SubClassOf:
hasBase some PizzaBase,
hasCaloricContent some xsd:integer
DisjointClasses:
Pizza, PizzaBase, PizzaTopping
Individuals:
CustomPizza1,
CustomPizza2</code></pre>
<P><strong>Saída:</strong></P>
<pre><code>Regra aplicada: Classe primitiva</code></pre>
<p>Em casos de erro, ou seja, quando a entrada não está descrita de acordo com a sintaxe da linguagem, é exibido uma mensagem de erro contendo o TOKEN, a linha em que ocorreu o erro e uma mensagem explicativa. Por exemplo:</p>
<P><strong>Entrada:</strong></P>
<pre><code>...
Class: SpicyPizza
EquivalentTo:
Pizza
and (hasTopping some (hasSpiciness value Hot1))
Class: VegetarianPizza
EquivalentTo:
Pizza
and (hasTopping only
(CheeseTopping or VegetableTopping))
Class: PizzaBase
DisjointClasses:
Pizza, PizzaBase, PizzaTopping
Class: PizzaTopping
DisjointClasses:
Pizza, PizzaBase, PizzaTopping
Class: Spiciness
EquivalentTo:
{Hot , Medium , Mild}</code></pre>
<P><strong>Saída:</strong></P>
<pre><code>Erro sintático: TOKEN "Disjoint Classes:" (linha 117)
Erro na criação da classe. O analisador esperava a declarção 'SubClassOf:' ou 'EquivalentTo:'.</code></pre>

---

<h1>Analisador Semântico</h2>

<h2>Análise de precedência dos operadores de cabeçalho</h2>

<h3>Precedência das Palavras-Chave</h3>
<p>Nessa primeira análise, buscamos garantir que a declaração das palavras-chave siga uma determinada ordem, sendo esta: <strong>Class → EquivalentTo → SubClassOf → DisjointClasses → Individuals.</strong></p>
<p><strong>Exemplo:</strong></p>
<pre><code>
// Classe correta
Class: NOME_DA_CLASSE
    EquivalentTo:
    CLASSE

// Classe correta
Class: NOME_DA_CLASSE
    SubClassOf:
    CLASSE
    DisjointClasses:
    OUTRA_CLASSE
    INDIVIDUALS:
    INDIVIDUO

// Classe com erro
Class: CLASSE_ERRO
    SubClassOf:
    CLASSE
    EquivalentTo:
    CLASSE
</code></pre>

<h3>Axioma de fechamento</h3>
<p>Também temos a precedência do axioma de fechamento para uma propriedade que deve ser declarado somente após as classes relacionadas à propriedade.</p>
<p><strong>Exemplo:</strong></p>
<pre><code>
//...
 SubClassOf:
 CLASSE,
 PROPRIEDADE QUANTIFICADOR EXEMPLO,
 PROPRIEDADE QUANTIFICADOR OUTROEXEMPLO,
 PROPRIEDADE only (EXEMPLO or OUTROEXEMPLO)
// O fragmento abaixo resulta em erro
 SubClassOf:
 CLASSE,
 PROPRIEDADE only (EXEMPLO or OUTROEXEMPLO),
 PROPRIEDADE QUANTIFICADOR EXEMPLO,
 PROPRIEDADE QUANTIFICADOR OUTROEXEMPLO
</code></pre>

<h2>Verificação Estática de Tipos por Coerção</h2>
<p> Nesta análise, o objetivo é garantir que tipos que requerem uma delimitação de intervalo, no caso o xsd:integer e xsd:float, possuam essa restrição após sua declaração, envolta em colchetes, com um operador relacional e uma cardinalidade. Também, garante-se que um tipo inteiro receberá um inteiro como parâmetro e um ponto-flutuante recebera um ponto-flutuante.</p>
<pre><code>
 // ...
  EquivalentTo:
  CLASSE
  and (PROPRIEDADE QUANTIFICADOR xsd:integer[>= 400])
  and (PROPRIEDADE QUANTIFICADOR xsd:float[>= 20.5])
 // O fragmento abaixo resulta em erro
  EquivalentTo:
  CLASSE
  and (PROPRIEDADE QUANTIFICADOR xsd:float)
</code></pre>
<p>Além da garantia que um os operadores min, max e exactly sejam sucedidos de uma cardinaldide.</p>
<pre><code>
 // ...
  EquivalentTo:
  CLASSE
  and (PROPRIEDADE min 1 CLASSE)
 // O fragmento abaixo resulta em erro
  EquivalentTo:
  CLASSE
  and (PROPRIEDADE exactly CLASSE)
</code></pre>

<h2>Verifição Estática de Tipos Por Sobrecarga</h2>
<p>A última análise feita identifica e diferencia uma Data property de uma Object property para auxiliar o usuário na hora de debugar. Uma Data property é definida pela tripla (propriedade, quantificador, datatype) enquanto que o Object property se define pela tripla (propriedade, quantificador, classe).</p>
<pre><code>
 // ...
  EquivalentTo:
  CLASSE
  and (PROPRIEDADE QUANTIFICADOR xsd:string) // Data property  
 // ...
  SubClassOf:
  CLASSE,
  PROPRIEDADE QUANTIFICADOR CLASSE // Object property
</code></pre>
---

<h2>Considerações Finais</h2> 
<p>Este analisador sintático foi projetado para ser extensível, permitindo a inclusão de novas regras gramaticais e funcionalidades conforme necessário. Ele serve como uma ferramenta educativa e prática para o entendimento dos conceitos de análise sintática e sua aplicação em linguagens formais como OWL Manchester Syntax.</p>
