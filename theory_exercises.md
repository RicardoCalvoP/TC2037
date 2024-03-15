# Practice exercises for theory

Para entrar en modo _"formula"_ usamos `$ Formula $`

1. Recusrive definition of $card (X)$

    I. **Basis:** if $X = \{\}$, then $card(X) = 0$

    II. **Recusrive step:** if $X = Y \cup \{z\}$, then $card(X) = s(card(Y))$

    III. **Closure:** $card(X) = n$ only if it can be obtain from the basis using a finite number of applications of the recursive step.

---

2. Recusive definition of the set of prime numbers $P = \{2,3,5,7,11,13,...\}$

    I. **Basis:** $2 \in P$

    II. **Recursive step:** $n \in P$ only if for any $p \in P$ $n$ $mod$ $p \neq 0$

    III. **Closure:** $n \in P$ only if it can be obtain from the basis using a finite number of applications of the recursive step.

---

3. Recursive definition of the set numbers of $4$

---

4. Prove by induction of gaus 'formula for sum of numbers up to n'

    $\Sigma_{i=0}^n n = \dfrac{n (n+1)}{2}$

    I. **Basis:** $n = 0$
    
    $0 = \dfrac{0 (0+1)}{2} \rightarrow \dfrac{0}{2} \rightarrow 0$

    II. **Inductive hypothesis:** $n = k$

    $\Sigma_{i=0}^k i = \dfrac{k (k+1)}{2}$

    III. **Inductive Step:** $n = k + 1$

    $\Sigma_{i=0}^{(k+1)} i = \dfrac{(k+1)((k+1)+1)}{2}$

    $\Sigma_{i=0}^{k} i +(k+1) = \dfrac{(k+1)((k+1)+1)}{2}$

    $\dfrac{k(k+1)}{2}+(k+1) = \dfrac{(k+1)((k+1)+1)}{2}$

    $\dfrac{k(k+1)}{2} + \dfrac{2(k+1)}{2} = \dfrac{(k+1)((k+1)+1)}{2}$
