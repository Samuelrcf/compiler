# Analisador Léxico para OWL2 (Manchester Syntax)

## Descrição
Este projeto tem como objetivo desenvolver um **analisador léxico** para a linguagem **OWL2** no formato **Manchester Syntax**, capaz de identificar e classificar tokens como palavras-chave, identificadores, operadores e literais. O analisador será responsável por reconhecer os elementos lexicais presentes em arquivos OWL2, garantindo conformidade com as regras da sintaxe e detectando possíveis erros. Essa ferramenta é essencial para validar a estrutura léxica de ontologias e prepará-las para uso em sistemas semânticos, como motores de inferência e integração de dados.

## Integrantes do Grupo
Erick Patrick de Paula Morais Freitas

Samuel Rogenes Carvalho Freire

## Funcionalidades
- Identificação de tokens: palavras-chave, identificadores, operadores e literais.
- Validação da conformidade com a Manchester Syntax.
- Detecção de erros lexicais em arquivos OWL2.

## Requisitos

Antes de começar, certifique-se de que você possui os seguintes requisitos:

- **G++** (ou outro compilador C++ compatível)
- **GDB** (para depuração)
- **Make** (opcional, se você preferir usar o Make ao invés do CMake)
- **CMake** (para construção do projeto)
- **Flex** (Ferramenta de Analisador Léxico)
- **Bison** (se necessário para a parte sintática)

### Instalação no Ubuntu (exemplo)

Se você não tem o Flex, Bison, CMake, Make, GCC ou GDB instalados, você pode instalar utilizando os seguintes comandos:

```bash
sudo apt-get update
sudo apt-get install flex bison cmake make g++ gdb
```

## Estrutura do Projeto

```plaintext
.
├── lex.yy.cc              # Código gerado pelo Flex (lexer)
├── lexer.l                # Arquivo de definições do Flex (lexer)
├── Makefile               # Arquivo de configuração para o Make
├── symbol_table.h         # Cabeçalho da tabela de símbolos
└── teste                  # Arquivo de testes (geralmente usado para validar o lexer e a tabela de símbolos)
```



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
