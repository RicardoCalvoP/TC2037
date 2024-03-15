# Activity 1.1 - Regular languages
Version 2.0

Reference for math symbols:
https://www.overleaf.com/learn/latex/List_of_Greek_letters_and_math_symbols

VSCode plugin to view graphs:
**Markdown Preview Mermaid Support**
https://mermaid.js.org/syntax/flowchart.html

## Names:
- Ricardo Calvo - A01028889
- Pedro Mauri Mtz    - A01029143


## Exercises:

1. Give a recursive definition of the set of even natural numbers.

    _**SOLUTION:**_



0. Give a recursive definition of the multiplication, using only addition and the successor function.

    _**SOLUTION:**_


0. Prove by induction that $n^3 + 2n$ is divisible by 3 for all natural numbers $n$.

    _**SOLUTION:**_


0. Prove by induction on $n$ that:

    $\sum_{i=0}^{n} 2^i = 2^{n + 1} - 1$

    _**SOLUTION:**_




0. Using the tree below, give the values of each of the items:

    ```mermaid
    graph TD;
        x1-->x2;
        x1-->x3;
        x1-->x4;
        x2-->x5;
        x2-->x6;
        x2-->x7;
        x3-->x8;
        x3-->x9;
        x4-->x10;
        x5-->x12;
        x7-->x13;
        x7-->x14;
        x9-->x15;
        x9 -->x16;
        x10-->x17;
        x10-->x18;
        x13-->x19;
        x16-->x20;
    ```


    # Activity 1.1 - Regular languages
Version 2.0

Reference for math symbols:
https://www.overleaf.com/learn/latex/List_of_Greek_letters_and_math_symbols

VSCode plugin to view graphs:
*Markdown Preview Mermaid Support*
https://mermaid.js.org/syntax/flowchart.html

## Names:
- Pedro Mauri Mtz- A01029143
- Ricardo Calvo Pérez - A01028889

## Exercises:

1. Give a recursive definition of the set of even natural numbers: $P = \{2, 4, 6, 8, 10, 12...\}$

    *SOLUTION:*

    I. *Basis*: 
    
    $2 \in P$

    II. *Recursive step*: 
    
    If $n \in P$, then $n + 2 \in P$ 

    III. *Closure*: 
    
    $n \in P$ only if it can be obtained from the basis using a finite number of applications of the recursive step

0. Give a recursive definition of the multiplication, using only addition and the successor function. 

    *SOLUTION:* 

    I. *Basis*:

    The base product of any base product is 0:

    $m = 0$, then $n \times m = 0$

    II. *Recursive step*:

    If $n \in \mathbb{N}$, then $n \times pred(m)+n$

    III. *Closure*:
    
    $m \times n = k$ only if this equality can be obtained from $m \times 0 = 0$ using finitely many applications of the recursive step

0. Prove by induction that $n^3 + 2n$ is divisible by 3 for all natural numbers $P = \{1, 2, 3, 4, 5, ...\}$

    *SOLUTION:*

    I. *Basis*: 
    
    $1 \in P$

    $1^3 + 2(1) = 3$

    II. *Inductive hypotesis*:

    $n^3 + 2n = 3m$

    $k^3 + 2k = 3m$
    
    III. *Inductive step*:

    $(k + 1) ^ 3 + 2(k + 1) = k^3 + 2k$

    $(k + 1) ^ 3 + 2k + 2 = k^3 + 2k$

0. Prove by induction on $n$ that:

    $\sum_{i=0}^{n} 2^i = 2^{n + 1} - 1$

    *SOLUTION:*

    I. *Basis*:
    
    $n = 0$

    $2^{0 + 1} - 1 = 1$

    II. *Inductive hypotesis*: 
    
    $\sum_{i=0}^{k} 2^i = 2^{k + 1} - 1$

    III. *Inductive step*: $n = k + 1$

    $\sum_{i=0}^{k + 1} 2^i = 2^{k + 1 + 1} - 1 = 2^{k + 2} - 1$    //

    $\sum_{i=0}^{k + 1} 2^i = 2^{k + 2} - 1 = 2^{k + 2} - 1$    //

    $2^{k + 2} - 1 = 2^{k + 2} - 1$    //

0. Using the tree below, give the values of each of the items:

    mermaid
    graph TD;
        x1-->x2;
        x1-->x3;
        x1-->x4;
        x2-->x5;
        x2-->x6;
        x2-->x7;
        x3-->x8;
        x3-->x9;
        x4-->x10;
        x5-->x12;
        x7-->x13;
        x7-->x14;
        x9-->x15;
        x9 -->x16;
        x10-->x17;
        x10-->x18;
        x13-->x19;
        x16-->x20;
    

a. the depth of the tree

    R: 4

b. the ancestors of x18

    R: The ancestors of x18 are: x10, x4 and x1

c. the internal nodes of the tree

    R: x1, x2, x3, x4, x5, x7, x9, x10, x13 and x16

d. the length of the path from x3 to x16

    R: 2

e. the vertex that is the parent of x13

    R: x7

f. the vertices children of x10

    R: x17 and x18