# Analisador Léxico para OWL2 (Manchester Syntax)

## Descrição
Este projeto tem como objetivo desenvolver um **analisador léxico** para a linguagem **OWL2** no formato **Manchester Syntax**, capaz de identificar e classificar tokens como palavras-chave, identificadores, operadores e literais. O analisador será responsável por reconhecer os elementos lexicais presentes em arquivos OWL2, garantindo conformidade com as regras da sintaxe e detectando possíveis erros. Essa ferramenta é essencial para validar a estrutura léxica de ontologias e prepará-las para uso em sistemas semânticos, como motores de inferência e integração de dados.

## Integrantes do Grupo
Erick Patrick de Paula Morais Freitas

Samuel Rogenes Carvalho Freire

## Desafio
O desafio proposto é desenvolver um analisador léxico capaz de identificar e categorizar os seguintes elementos da linguagem OWL2:

## Principais Componentes
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

O analisador mantém uma tabela de símbolos onde são armazenados os tokens identificados, suas categorias (por exemplo, tipo, classe, propriedade) e o número da linha onde foram encontrados.
