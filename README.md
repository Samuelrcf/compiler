<h1>Implementação de um Analisador Sintático para OWL Manchester Syntax</h1>

# Índice
1. [Objetivo](#objetivo)
2. [Equipe](#equipe)
3. [Requisitos](#requisitos)
4. [Instalação no Ubuntu (exemplo)](#instalação-no-ubuntu-exemplo)
5. [Estrutura do Projeto](#estrutura-do-projeto)
6. [Tutorial de Execução](#tutorial-de-execução)
7. [Tipos de Classes](#tipos-de-classes)
8. [Descrição dos Tokens do Analisador Sintático](#descrição-dos-tokens-do-analisador-sintático)
9. [Regras de Produção do Analisador Sintático](#regras-de-produção-do-analisador-sintático)
10. [Considerações Finais](#considerações-finais)



<h2>Objetivo</h2>
<p>Especificar um analisador sintático somente para a análise de declarações de classes na linguagem OWL, de acordo com o formato Manchester Syntax, de acordo com as seguintes diretrizes:

Elaborar uma gramática livre de contexto, sem ambiguidade, fatorada e sem recursividade à esquerda;

Utilizar um gerador de analisador sintático com base em análise ascendente;

Simular a leitura de uma especificação de classe como entrada para verificação da consistência da declaração da classe;

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
    <p>É necessário baixar o projeto que foi hospedado no Github. Para isso, é necessario fazer o donwload ou em formato zip ou utilizando a ferramenta do Git</p>
    <p>Para baixar o zip é necessário apenas ir em code e depois em Download ZIP e após isso extrair a pasta</p>
    <p>Se for utilizando o a ferramenta Git é necessário apenas ir no terminal e digitar o seguinte comando:</p>
    <code>git clone https://github.com/...</code>
    <p>Esse comando irá salvar o código em sua máquina local</p>
  </li>
  <li>
    <p>Importante: é necessário ter o flex e o bison configurado no Visual Studio Code para poder funcionar a compilação do projeto</p>
  </li>
  <li>
    <p>Agora para compilar o analisador usando o makeFile devemos digitar o comando make</p>
    <code>make</code>
</li>
  <li>
    <p>O programa irá gerar a análise sintática e mostrar se teve algum erro ou não encontrado no processo de análise</p>
    <p>Depois disso ele irá mostrar uma contagem de todos os tipos de classes e erros se houver algum </p>
  </li>
</ol>

<h2>Tipos de classes</h2>
<ul>
  <li>
    <h3>Classe Primitiva</h3>
    <p>é uma classe cujos indivíduos podem herdar suas propriedades, mas indivíduos avulsos que tenham tais propriedades não podem ser classificados como membros dessas classes. No exemplo a seguir, é possível notar que a declaração deste tipo de classe inclui as definições de propriedades abaixo do axioma “SubClassOf”, ou seja, todos os indivíduos da classe primitiva Pizza serão também membros de tudo o que tem alguma base (PizzaBase) e tudo o que tem conteúdo calórico de algum valor inteiro. Todas as classes podem conter as seções “DisjointClasses” e “Individuals” em suas descrições.</p>
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
    <p>é uma classe que contém condições necessárias e suficientes em sua descrição. Em outros termos, esse tipo de classe não somente transfere suas características para seus indivíduos por herança, mas também permite inferir que indivíduos avulsos que tenham suas propriedades possam ser classificados como membros dessas classes. Uma classe definida normalmente tem uma seção definida pelo axioma “EquivalentTo:” sucedido por um conjunto de descrições. No exemplo abaixo, as classes CheesyPizza e HighCaloriePizza são definidas dessa forma.</p>
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
    <p>uma classe com axioma de fechamento contém normalmente uma cláusula que “fecha” ou restringe as imagens de suas relações a um conjunto bem definido de classes ou de expressões. No exemplo abaixo, note que a classe MargheritaPizza, como domínio da relação ou “tripla RDF” pode estar conectada a duas outras classes de imagem (MozzarellaTopping e TomatoTopping) mediante a propriedade hasTopping. Entretanto, é necessário tornar explícito para o reasoner (motor de inferência lógica) que esse tipo de pizza só pode ter esses dois tipos de cobertura. Por isso, a expressão “hasTopping only (MozzarellaTopping or TomatoTopping)” é considerada um “fechamento” da imagem da relação/propriedade hasTopping, que é usada para descrever as relações que MargheritaPizza tem com possíveis coberturas (Toppings)</p>
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
    <p>é possível que a imagem de uma propriedade que descreve uma classe não seja necessariamente uma outra classe, mas outra tripla composta de propriedade, quantificador e outra classe. Esses aninhamentos criam estruturas semelhantes a orações coordenadas ou subordinadas, como estudamos na gramática da Língua Portuguesa, por exemplo. Observe como a expressão “hasSpiciness value Hot” compreende a imagem (ou objeto) da propriedade “hasTopping”</p>
    <h4>Exemplo</h4>
    <pre><code>Class: SpicyPizza
EquivalentTo:
  Pizza
  and (hasTopping some (hasSpiciness value Hot))
</code></pre>
  </li>
  <li>
    <h3>Classe Enumerada</h3>
    <p>algumas classes podem ser definidas a partir de uma enumeração de suas possíveis instâncias. Por exemplo, uma classe denominada “dias_da_semana” poderia conter apenas sete instâncias, sendo uma para cada dia. Uma outra classe denominada “planetas_do_sistema_solar” poderia conter apenas oito instâncias. Em OWL, há uma forma de se especificar esse tipo de classe. Note que, no exemplo abaixo, a classe Spiciness é definida com um conjunto de instâncias (Hot, Medium e Mild), que aparecem entre chaves.</p>
    <h4>Exemplo</h4>
    <pre><code>Class: Spiciness
EquivalentTo: {Hot, Medium, Mild}
</code></pre>
  </li>
  <li>
    <h3>Classe Coberta</h3>
    <p>uma variação do exemplo anterior consiste em especificar uma classe como sendo a superposição de suas classes filhas. Ou seja, neste caso teríamos a classe Spiciness como sendo a classe mãe e as classes Hot, Mild e Mild como sendo classes filhas. A implicação lógica nesse caso é de que qualquer indivíduo pertencente à classe mãe precisa também estar dentro de alguma classe filha. Esse tipo de classe poderia ser especificada da seguinte forma:</p>
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

## Regras de Produção do Analisador Sintático

As regras de produção definem a gramática do analisador sintático, especificando como os elementos básicos (tokens) podem ser combinados para formar estruturas válidas. A seguir, as principais regras de produção são detalhadas.

---

### **1. Declaração de Classes**
```cpp
classes
    : class
    | class classes
    ;
```
- Define uma lista de classes. Cada classe pode ser declarada isoladamente ou em conjunto com outras.

```cpp
class
    : CLASS CLASSNAME subclass_disjoint_individuals
    | CLASS CLASSNAME equivalent_to {print_rule("Classe definida");}
    | CLASS CLASSNAME class_closure_axiom {print_rule("Classe com axioma de fechamento");}
    ;
```
- **Descrição:**
  - Declara uma classe com diferentes propriedades:
    - Subclasse ou indivíduos disjuntos.
    - Classe equivalente a outra ou com axiomas de fechamento.

---

## **Subclasses e Disjunções**

### **2. Subclasses e Indivíduos Disjuntos**
```cpp
subclass_disjoint_individuals
    : SUBCLASSOF subc_properties optional_disjoint_individuals {print_rule("Classe primitiva");}
    ;
```
- **Descrição:** Especifica uma subclasse com propriedades e, opcionalmente, disjunções de classes ou indivíduos.

### **3. Indivíduos Opcionais e Classes Disjuntas**
```cpp
optional_disjoint_individuals
    : DISJOINTCLASSES disjoint_classes optional_individuals
    | optional_individuals
    ;
```
- **Descrição:** Adiciona a possibilidade de declarar classes disjuntas e/ou indivíduos associados à classe.

---

## **Axiomas e Propriedades**

### **4. Axioma de Fechamento**
```cpp
class_closure_axiom
    : SUBCLASSOF descriptions
    ;
```
- **Descrição:** Define uma classe com restrições baseadas em descrições.

---

## **Equivalência e Classes Enumeradas**

### **5. Equivalência entre Classes**
```cpp
equivalent_to
    : EQUIVALENTTO descriptions optional_individuals
    | EQUIVALENTTO enumerated_class {print_rule("Classe enumerada");}
    | EQUIVALENTTO class_list {print_rule("Classe coberta");}
    ;
```
- **Descrição:**
  - Define classes equivalentes usando:
    - Descrições.
    - Classes enumeradas (explicitamente listadas).
    - Lista de classes (cobertura por conjunto de classes).

### **6. Classe Enumerada**
```cpp
enumerated_class
    : LEFT_BRACE class_list RIGHT_BRACE
    ;
```
- **Descrição:** Representa uma classe definida por um conjunto explícito de membros.

---

## **Descrições e Propriedades**

### **7. Lista de Descrições**
```cpp
descriptions
    : description
    | CLASSNAME AND descriptions
    ;
```
- **Descrição:** Define uma ou mais descrições conectadas por operadores lógicos.

### **8. Descrição de Classe**
```cpp
description
    : LEFT_PARENTHESIS PROPERTY quantifier CLASSNAME RIGHT_PARENTHESIS
    | LEFT_PARENTHESIS PROPERTY quantifier LEFT_PARENTHESIS PROPERTY quantifier CLASSNAME RIGHT_PARENTHESIS RIGHT_PARENTHESIS {print_rule("Classe com descrições aninhadas");}
    | LEFT_PARENTHESIS PROPERTY quantifier NAMESPACE INTEGER LEFT_BRACKET GREATER_THAN_SIGN EQUALS CARDINAL RIGHT_BRACKET RIGHT_PARENTHESIS
    | CLASSNAME COMMA subc_properties
    ;
```
- **Descrição:** Define as propriedades e as restrições de uma classe.

---

## **Propriedades de Subclasses**

### **9. Lista de Propriedades**
```cpp
subc_properties
    : subc_property
    | subc_properties COMMA subc_property
    ;
```
- **Descrição:** Lista de propriedades relacionadas à subclasse.

```cpp
subc_property
    : PROPERTY quantifier subc_namespace_type
    | PROPERTY quantifier subc_logical_expression
    ;
```
- **Descrição:** Define propriedades específicas com base em tipos de namespace ou expressões lógicas.

---

## **Indivíduos**

### **10. Lista de Indivíduos**
```cpp
individuals
    : individual
    ;
```
```cpp
individual
    : INDIVIDUAL COMMA individual
    | INDIVIDUAL
    ;
```
- **Descrição:** Define um ou mais indivíduos associados a uma classe.

---

## **Quantificadores**

### **11. Tipos de Quantificadores**
```cpp
quantifier
    : SOME
    | VALUE
    | MIN
    | MAX
    | EXACTLY
    | ONLY
    ;
```
- **Descrição:** Define restrições como:
  - **SOME**: Pelo menos um valor.
  - **ONLY**: Apenas valores específicos.
  - **EXACTLY**: Um número exato de valores.

---

## **Combinações Lógicas**

### **12. Expressões Lógicas**
```cpp
subc_logical_expression
    : subc_atomic
    | subc_atomic OR subc_logical_expression
    ;
```
- **Descrição:** Combina elementos de forma lógica usando operadores como `OR`.

---

<h2>Considerações Finais</h2> 
<p>Este analisador sintático foi projetado para ser extensível, permitindo a inclusão de novas regras gramaticais e funcionalidades conforme necessário. Ele serve como uma ferramenta educativa e prática para o entendimento dos conceitos de análise sintática e sua aplicação em linguagens formais como OWL Manchester Syntax.</p>
