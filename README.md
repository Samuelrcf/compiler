<h1>Implementação de um Analisador Sintático para OWL Manchester Syntax</h1>
<h2>Objetivo</h2>
<p>Especificar um analisador sintático somente para a análise de declarações de classes na linguagem OWL, de acordo com o formato Manchester Syntax, de acordo com as seguintes diretrizes:

Elaborar uma gramática livre de contexto, sem ambiguidade, fatorada e sem recursividade à esquerda;

Construir uma tabela de análise preditiva (para implementação manual) ou utilizar um gerador de analisador sintático com base em análise ascendente;

Simular a leitura de uma especificação de classe como entrada para verificação da consistência da declaração da classe;

Por “consistência”, entende-se que a declaração das classes seguem uma ordem que varia de acordo com o tipo de classe (p.ex.: separação dos nomes das classes por vírgulas nas classes enumeradas, disjunções entre as subclasses de uma classe coberta, separação de cláusulas pela palavra-chave AND ou por espaçamento, no caso das classes definidas e primitivas, respectivamente).</p>

<h2>Equipe</h2>
<ul>
  <li>Erick Patrick de Paula Morais Freitas</li>
  <li>Samuel Rogenes Carvalho Freire</li>
</ul>

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

<h2>Tipos de classes </h2>
      <ul>
        <li>
          <h3> Classe Primitiva </h3>
          <p>é uma classe cujos indivíduos podem herdar suas propriedades, mas indivíduos avulsos que tenham tais propriedades não  podem ser classificados como membros dessas classes. No exemplo a seguir, é possível notar que a declaração deste tipo de classe inclui as definições de propriedades abaixo do axioma “SubClassOf”, ou seja, todos os indivíduos da classe primitiva Pizza serão também membros de tudo o que tem alguma base (PizzaBase) e tudo o que tem conteúdo calórico de algum valor inteiro. Todas as classes podem conter as seções “DisjointClasses” e “Individuals” em suas descrições. </p>
          <h4>Exemplo </h4>
          <p>Class: Pizza </p>
          <br />
          <p> SubClassOf: </p>
          <p>   hasBase some PizzaBase, </p>
          <p>   hasCaloricContent some xsd:integer </p>
          <br />
          <p> DisjointClasses: </p>
          <p>   Pizza, PizzaBase, PizzaTopping </p>
          <br />
          <p> Individuals: </p>
          <p>   CustomPizza1, </p>
          <p>   CustomPizza2 </p> 
        </li>
        <li>
          <h3>Classe Definida </h3>
          <p>é uma classe que contém condições necessárias e suficientes em sua
            descrição. Em outros termos, esse tipo de classe não somente transfere suas características
            para seus indivíduos por herança, mas também permite inferir que indivíduos avulsos que
            tenham suas propriedades possam ser classificados como membros dessas classes. Uma
            classe definida normalmente tem uma seção definida pelo axioma “EquivalentTo:” sucedido por
            um conjunto de descrições. No exemplo abaixo, as classes CheesyPizza e HighCaloriePizza
            são definidas dessa forma. </p>
          <h4>Exemplo </h4>
          <p>Class: CheesyPizza </p>
          <br />
          <p> EquivalentTo:</p>
          <p> Pizza and (hasTopping some CheeseTopping)</p>
          <br />
          <p>Individuals: </p>
          <p>CheesyPizza1 </p>
        </li>
        <li>
          <h3>Classe com axioma de fechamento </h3>
          <p>uma classe com axioma de fechamento
          contém normalmente uma cláusula que “fecha” ou restringe as imagens de suas relações a um
          conjunto bem definido de classes ou de expressões. No exemplo abaixo, note que a classe
          MargheritaPizza, como domínio da relação ou “tripla RDF” pode estar conectada a duas outras
          classes de imagem (MozzarellaTopping e TomatoTopping) mediante a propriedade
          hasTopping. Entretanto, é necessário tornar explícito para o reasoner (motor de inferência
          lógica) que esse tipo de pizza só pode ter esses dois tipos de cobertura. Por isso, a expressão
          “hasTopping only (MozzarellaTopping or TomatoTopping)” é considerada um “fechamento” da
          imagem da relação/propriedade hasTopping, que é usada para descrever as relações que
          MargheritaPizza tem com possíveis coberturas (Toppings)</p>
          <h4>Exemplo </h4>
          <p>Class: MargheritaPizza</p>
          <br>
          <p>SubClassOf:</p>
          <p> NamedPizza, </p>
          <p>hasTopping some MozzarellaTopping, </p>
          <p>hasTopping some TomatoTopping, </p>
          <p>hasTopping only (MozzarellaTopping or TomatoTopping) </p>
        </li>
        <li>
          <h3>Classe com descrições aninhadas </h3>
          <p>é possível que a imagem de uma propriedade que
          descreve uma classe não seja necessariamente uma outra classe, mas outra tripla composta de
          propriedade, quantificador e outra classe. Esses aninhamentos criam estruturas semelhantes a
          orações coordenadas ou subordinadas, como estudamos na gramática da Língua Portuguesa,
          por exemplo. Observe como a expressão “hasSpiciness value Hot” compreende a imagem (ou
          objeto) da propriedade “hasTopping” </p>
          <h4>Exemplo </h4>
          <p>Class: SpicyPizza </p>
          <br />
          <p>EquivalentTo: </p>
          <p> Pizza </p>
          <p> and (hasTopping some (hasSpiciness value Hot)) </p>
        </li>
        <li>
          <h3>Classe Enumerada </h3>
          <p>algumas classes podem ser definidas a partir de uma enumeração de suas
          possíveis instâncias. Por exemplo, uma classe denominada “dias_da_semana” poderia conter
          apenas sete instâncias, sendo uma para cada dia. Uma outra classe denominada
          “planetas_do_sistema_solar” poderia conter apenas oito instâncias. Em OWL, há uma forma de
          se especificar esse tipo de classe. Note que, no exemplo abaixo, a classe Spiciness é definida
          com um conjunto de instâncias (Hot, Medium e Mild), que aparecem entre chaves. </p>
          <h4>Exemplo </h4>
          <p> Class: Spiciness</p>
          <br />
          <p>  EquivalentTo: {Hot , Medium , Mild}<p>
        </li>
        <li>
          <h3>Classe Coberta</h3>
          <p> uma variação do exemplo anterior consiste em especificar uma classe como
            sendo a superposição de suas classes filhas. Ou seja, neste caso teríamos a classe Spiciness
            como sendo a classe mãe e as classes Hot, Mild e Mild como sendo classes filhas. A implicação
            lógica nesse caso é de que qualquer indivíduo pertencente à classe mãe precisa também estar
            dentro de alguma classe filha. Esse tipo de classe poderia ser especificada da seguinte forma:
            Class: Spiciness
            EquivalentTo: Hot or Medium or Mild</p>
          <h4>Exemplo </h4>
          <p>Class: Spiciness </p>
          <br />
          <p>  EquivalentTo: Hot or Medium or Mild</p>
        </li>
        <li>
          <h3>Classe Especial</p>
          <p> Uma classe que não satisfaz nenhuma das anteriores </p>
          <h4>Exemplos</h4>
          <p>Class: PizzaBase </p>
          <br />
          <p>DisjointClasses:</p>
          <p>Pizza, PizzaBase, PizzaTopping</p>
          <br/>
          <p> Class: PizzaTopping </p>
          <br />
          <p> DisjointClasses: </p>
          <p>  Pizza, PizzaBase, PizzaTopping </p>
          <br />
          <p>Class: Evaluated</p>
          <br />
          <p> EquivalentTo: </p> 
          <p>BrokerServiceProvider or Connector or CoreParticipant</p>
          <br />
          <p> SubClassOf: </p> 
          <p> FunctionalComplex</p>
        </li>
      </ul>
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

---

<p>Estes tokens fornecem uma base estruturada para a análise de uma linguagem formal usada para descrever classes, indivíduos e suas relações, permitindo um entendimento claro e organizado de uma gramática rica em semântica.</p>
<h2>Considerações Finais</h2> 
<p>Este analisador sintático foi projetado para ser extensível, permitindo a inclusão de novas regras gramaticais e funcionalidades conforme necessário. Ele serve como uma ferramenta educativa e prática para o entendimento dos conceitos de análise sintática e sua aplicação em linguagens formais como OWL Manchester Syntax.</p> <p>Para dúvidas ou contribuições, entre em contato com os integrantes da equipe ou acesse o repositório do projeto no GitHub.</p>
