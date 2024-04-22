# Activity 2.4 - Lambda calculus
Version 1.0

Reference for math symbols:
https://www.overleaf.com/learn/latex/List_of_Greek_letters_and_math_symbols

VSCode plugin to view graphs:
**Markdown Preview Mermaid Support**
https://mermaid.js.org/syntax/flowchart.html

## Name:
- `Ricardo Calvo`


## Instructions

Watch a video that explains many of the fundamental principles of **Lambda Calculus**:
https://www.youtube.com/watch?v=3VQ382QG-y4

## Exercises:

1. What is the basic building block of **Lambda Calculus**?

    `The basic building block of Lambda Calculus is Lambda (Function Signifier) a (Parameter Variable)  . returns expression`
    $\lambda a.a$ 
     `This is known as a Lambda Abstraction`

0. According to the video, describe what is a **Combinator**

    `A Combinator is a function where the body variables are bound tp the parameter in return. This means that you dom't require any arguments to be applied.`


0. Go to the website: http://lambdacalc.io/ and try the expression:
`(∧ (eq (¬ ⊤) ⊥) (∨ ⊥ ⊤))`
Does the result make sense to you? Explain why?

 `Yes, because if you dived the function in different subfunctions we can conclude that we get to the same answer.`

 `The first subfunction is (eq (¬ ⊤) ⊥) where if we dived this into a smaller subfunction we get (¬ ⊤) that means the opposite of TRUE, therefore FALSE. Then it tells os that FALSE EQUAL FALSE`

 `The second  subfunction is (∨ ⊥ ⊤)) where it tells us an OR operation where if any of both is TRUE, everything is going to be TRUE.`

 `Finally we have an AND operator, where it tells us that if both of the subexpressions  are TRUE, everything is going to be TRUE, otherwise is going to be FALSE.`

 

 


## Reminder: Booleans in Church encoding

Name | $\lambda$-Calculus
-----|-------------------
TRUE | $\lambda a b\ .\ a$
FALSE| $\lambda a b\ .\ b$
NOT  | $\lambda p\ .\ p\ F\ T$
AND  | $\lambda p q\ .\ p\ q\ p$
OR   | $\lambda p q\ .\ p\ p\ q$
EQUAL| $\lambda p q\ .\ p\ q\ (NOT\ q)$
