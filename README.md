# Analisador Léxico para OWL2 (Manchester Syntax)

## Índice

1. [Descrição](#descrição)
2. [Integrantes do Grupo](#integrantes-do-grupo)
3. [Funcionalidades](#funcionalidades)
4. [Requisitos](#requisitos)
   - 4.1 [Instalação no Ubuntu](#instalação-no-ubuntu-exemplo)
5. [Estrutura do Projeto](#estrutura-do-projeto)
6. [Principais Componentes](#principais-componentes)
7. [Tabela de Símbolos](#tabela-de-símbolos)

## Descrição
Este projeto tem como objetivo desenvolver um **analisador léxico** para a linguagem **OWL2** no formato **Manchester Syntax**, capaz de identificar e classificar tokens como palavras-chave, identificadores, operadores e literais. O analisador será responsável por reconhecer os elementos lexicais presentes em arquivos OWL2, garantindo conformidade com as regras da sintaxe e detectando possíveis erros. Essa ferramenta é essencial para validar a estrutura léxica de ontologias e prepará-las para uso em sistemas semânticos, como motores de inferência e integração de dados.

## Integrantes do Grupo
Erick Patrick de Paula Morais Freitas

Samuel Rogenes Carvalho Freire

## Funcionalidades
As funcionalidades principais incluem:

### Identificação de Tokens:

- Identifica operadores relacionais (e.g., AND, OR, NOT), quantificadores (e.g., SOME, ALL, VALUE), tipos de dados (rational, real, etc.), classes, palavras-chave, literais e outros símbolos especiais.
- Detecta erros, como tokens inválidos ou desconhecidos, exibindo mensagens de erro no console.
- Validação da conformidade com a Manchester Syntax.

### Contadores:

- Mantém contadores para rastrear a frequência de cada tipo de token identificado durante a análise.

### Execução:

#### Processa uma entrada padrão (stdin) ou arquivo fornecido, analisa os tokens e exibe:
- A contagem de cada tipo de token.
- O conteúdo completo da tabela de símbolos.
  
### Estrutura do Código:

Utiliza uma biblioteca personalizada (symbol_table.h) para gerenciar a tabela de símbolos.
Aplica padrões regulares para definir regras de identificação de tokens no arquivo de entrada.

## Requisitos

Antes de começar, certifique-se de que você possui os seguintes requisitos:

- **G++** (ou outro compilador C++ compatível)
- **GDB** (para depuração)
- **Make** (opcional, se você preferir usar o Make ao invés do CMake)
- **CMake** (para construção do projeto)
- **Flex** (Ferramenta de Analisador Léxico)

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
└── teste                  # Arquivo de texto com a linguagem **OWL2** no formato **Manchester Syntax** (usado para validar o lexer e gerar a tabela de símbolos)
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

A Tabela de Símbolos é uma estrutura fundamental em compiladores que armazena e gerencia informações sobre identificadores (como variáveis e funções) encontrados no código-fonte durante a análise léxica e sintática. Nesse projeto, a tabela foi implementada como uma classe em C++ que utiliza um std::unordered_map para mapear os nomes dos símbolos a uma estrutura contendo seu tipo e as linhas onde aparecem. Sua principal função é auxiliar futuramente na análise semântica, verificando o uso correto dos símbolos, e na geração de código, associando símbolos a endereços, visto que ela registra informações sobre cada token detectado, como o tipo, o valor, e a linha onde ocorreu. Ela possui métodos para adicionar novos símbolos e exibir a tabela formatada, evitando duplicação de linhas.

## Como usar o Analisador Léxico
### Passo 1: Clonar o Repositório ou Fazer o Download
Clone o repositório do github com o comando: 
```plaintext
git clone git@github.com:Samuelrcf/compiler.git
```
ou faça o Download Zip.

### Passo 2: Configurar o Ambiente
Certifique-se de estar em um ambiente Linux ou usando o WSL (Windows Subsystem for Linux).
Abra o repositório no VSCode (ou outro editor/IDE de sua preferência que suporte C/C++).

### Passo 3: Compilar e Executar o Analisador Léxico
Abra um terminal na pasta onde o programa lexer.l está localizado e execute os seguintes comandos:
#### Limpar os arquivos gerados durante o processo de compilação
```plaintext
make clean
```
#### Construir o arquivo executável lexer, conforme as dependências do Makefile
```plaintext
make
```
#### Executa o programa gerado (lexer) e redireciona o conteúdo do arquivo teste como entrada para o analisador léxico
```plaintext
./lexer < teste
```

Substitua "teste" pelo nome do arquivo que contém o texto a ser analisado.
Certifique-se de que o arquivo teste está na mesma pasta onde o programa foi compilado ou use o caminho completo para ele.
Se aparecer algum erro durante a execução dos comandos, verifique se todas as dependências necessárias estão instaladas no sistema, como o Flex e o G++.
