# Context-free grammars

Name: 

## Grammar definitions

Describe the basic grammar necessary to write a valid *construction* in the language indicated.

The contents of the *construction* do not need to be specified.

Consider all the requirements for the construction according to the language. For example, the rules for the names of the constructions

### BNF Python functions

```xml
<function> ::= def <name> (<params>) :
                    <statement>
                    <return>


<name> ::= <string>

<params> ::= <params>, <param>
                        |   <param>
                        |   <lambda>

<return> ::= <return>
                    |   <return> <statement>
                    |   <lambda>


```

### EBNF Python functions

```bash
FUNCTION ::= 'def' NAME '(' [PARAMS] ')' ':'
                            {STATEMENT}
                            [RETURN]

NAME ::= LETTER {LETTER | DIGIT | '_'}

PARAMS ::= PARAM {',' PARAM}

PARAM ::= NAME

RETURN ::= 'return' [STATEMENT]

STATEMENT ::= (STATEMENT | STATEMENT [{,STATEMENT}])


```

### BNF Elixir modules

```xml
<module> ::= defmodule <name> do
                        <contents>
                    end

<name>: <UpperCase><Digit>
<contents> ::= <content>
                    | <function> <contents>
<UpperCase>::= A | B | C | ... | X | Y | Z
<Digit>::= a | b | c | . .. | x | y | z | 0 | 1 | ... | 9 <Digit>
```

### EBNF Elixir modules

```bash
MODULE ::= 'defmodule' NAME 'do' 
                        {CONTENTS}
                    'end'
```

### BNF Elixir functions

```xml
<function> ::= def <name> (<params>) do <content> end
                        |   def <name> (<params>), do: <contents> end

<name> ::= <lowercase><digit>
<lowercase> ::= a | b | c | . .. | x | y | z
<digit> ::= <digit> a | b | c | . .. | x | y | z | A | B | C | ... | X | Y | Z | 0 | 1 | ... | 9 
<content> ::= <action>
<contents> ::= <contents><content>
                    |   <content>

```

### EBNF Elixir functions

```bash
FUNCTION ::= 'def' NAME '(' [PARAMS] ')' 'do' {CONTENTS} 'end'
            | 'def' NAME '(' [PARAMS] ')' ',' 'do' ':' CONTENT

NAME ::= LETTER {LETTER | DIGIT | '_'}

PARAMS ::= PARAM {',' PARAM}

PARAM ::= NAME

CONTENTS ::= STATEMENT

```