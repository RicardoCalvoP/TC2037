# Context-Free Grammars

### Syntaxs of `for` structure in C

Example:

```c
for (int = 0; i < 10; i++){
    ```
}

for (;;) // Infinite loop
    printf("Cool!");

```

BNF (Backus - Naur Form):

```xml
<for> ::= for (<init>; <condition>; <update>) { <expression> }
                | for (<init>; <condition>; <update>) <expressions>

<init> ::= <type><var> = <value> 
                | <var> = <value>
                | <lambda>

<condition> ::= <expression> 
                | <lambda>
<update> ::= <var><update-operator>
                | <update-operator> <var>

<update-operator> ::= ++ || --

<expressions> ::= <expression> | <expression><expressions>
```

EBNF (Extended Backus - Naur Form):

```bash
FOR ::= 'for' '(' INIT ';' CONDITION ',' UPDATE ')' ( EXPRESSION | '{' { EXPRESSION } '}')
```