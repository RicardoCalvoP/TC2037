# Context-free grammars

Name: Ricardo Calvo

## Grammar definitions

Describe the basic grammar necessary to write a valid *construction* in the language indicated.

The contents of the *construction* do not need to be specified.

Consider all the requirements for the construction according to the language. For example, the rules for the names of the constructions

### BNF Python functions

```xml
<function> ::= def <name> (<params>) :
                    <statement>
                    <return>

     | <function> ::= def <name> () :
                    <statement>
                    <return>


<name> ::= <string>

<params> ::= <param>, <params>
                        |   <param>


<return> ::= <return>
                    |   <return> <statement>


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



```

### BNF Elixir modules

```xml
<module> ::= defmodule <name> do
                        <functions>
                    end

<name>: <UpperCase><Digit>
<functions> ::= <function>
                    | <function> <functions>
<UpperCase>::= A | B | C | ... | X | Y | Z
<Digit>::= a | b | c | . .. | x | y | z | 0 | 1 | ... | 9 <Digit>
```

### EBNF Elixir modules

```bash
MODULE ::= 'defmodule' NAME 'do' 
                        {FUNCTIONS}
                    'end'
```

### BNF Elixir functions

```xml
<function> ::= <def> <name> (<params>) do <content> end
                        |   <def> <name> (<params>), do: <contents> 
                        |   <def> <name> (<params>) when <condition> do <contents> end
                        |   <def> <name> () do <contents> end
                        |   <def> <name> (), do: <contents> 

<def> ::= def | defp 
<name> ::= <lowercase><digit>
<lowercase> ::= a | b | c | . .. | x | y | z
<digit> ::= <digit> a | b | c | . .. | x | y | z | A | B | C | ... | X | Y | Z | 0 | 1 | ... | 9 
<content> ::= <action>
<contents> ::= <contents><content>
                    |   <content>
<condition> ::= <function>
                | <comparison>
                

```

### EBNF Elixir functions

```bash
FUNCTION ::= 'def'['p'] NAME '(' [PARAMS] ')' 'do' {CONTENTS} 'end'
            | 'def'['p'] NAME '(' [PARAMS] ')' ',' 'do' ':' CONTENT
            | 'def'['p'] NAME '(' [PARAMS] ')' 'when' CONDITION 'do' {CONTENTS} 'end'

NAME ::= LETTER {LETTER | DIGIT | '_'}

PARAMS ::= PARAM {',' PARAM}

PARAM ::= NAME

CONTENTS ::= STATEMENT

CONDITION ::= FUNCTION | COMPARISON
```