# Actividad 2.1
# Programacion funcional parte 1
# Ricardo Calvo - A01028889
# 01/03/2024

defmodule Hw.Ariel1 do
  def invert(list), do: do_invert(list, [])

  defp do_invert([], res), do: res
  defp do_invert([head | tail], res), do: do_invert(tail, [head | res])

  # 1. La funcion fahrenheit-to-celsius toma como entrada una temperatura f en grados Fahrenheit
  # y la convierte a su equivalente en grados Celsius

  def fahrenheit_to_celsius(f) do
    5 / 9 * (f - 32)
  end

  # CHECK

  # 2. La funcion sign recibe como entrada un valor entero n. Devuelve -1 si n es negativo,
  # 1 si n es positivo mayor que cero, o 0 si n es cero

  def sign(num) do
    cond do
      num > 0 -> 1
      num < 0 -> -1
      true -> 0
    end
  end

  # CHECK

  # 3. La funcion roots devuelve la ra ́ız que resuelve una ecuaci ́on cuadr ́atica a partir de sus tres coeficiente, a, b y
  # c, que se reciben como entrada.

  def roots(a, b, c) do
    (-b + :math.sqrt(b * b - 4 * (a * c))) / (2 * a)
  end

  # CHECK

  # 4. El  ́ındice de masa corporal, o BMI por sus siglas in ingl ́es,
  # se utiliza para determinar si la proporci ́on de peso y altura de una persona es adecuada.

  def bmi(weight, height) do
    b_m_i = calculate_bmi(weight, height)

    cond do
      b_m_i < 20 -> :underweight
      20 <= b_m_i and b_m_i < 25 -> :normal
      25 <= b_m_i and b_m_i < 30 -> :obese1
      30 <= b_m_i and b_m_i < 40 -> :obese2
      true -> :obese3
    end
  end

  defp calculate_bmi(weight, height), do: weight / (height * height)

  # CHECK

  # 5. La funcion factorial toma un entero positivo n como su entrada y devuelve el
  # factorial correspondiente

  def factorial(num) do
    cond do
      num == 0 -> 1
      true -> num * factorial(num - 1)
    end
  end

  # CHECK

  # 6. La funcion duplicate toma una lista lst como entrada y devuelve una nueva lista
  # en donde cada elemento de lst esta duplicado.

  def duplicate(list), do: duplicate_list(list, [])

  defp duplicate_list([], res), do: invert(res)
  defp duplicate_list([head | tail], res), do: duplicate_list(tail, [head, head | res])

  # CHECK

  # 7. La funcion pow toma dos entradas como entrada: un n ́umero a y un entero positivo b.
  # Devuelve el resultado de calcular a elevado a la potencia b

  def pow(a, b) do
    cond do
      b == 0 -> 1
      b == 1 -> a
      true -> recursive_pow(a, b, 1)
    end
  end

  defp recursive_pow(_, 0, res), do: res
  defp recursive_pow(a, b, res), do: recursive_pow(a, b - 1, res * a)

  # CHECK

  # 8. La funcion fib toma un entero positivo n como entrada y devuelve el elemento
  # correspondiente de la secuencia de Fibonacci

  def fib(n) do
    cond do
      n <= 1 -> n
      true -> fib(n - 1) + fib(n - 2)
    end
  end

  # CHECK

  # 9. La funcion enlist coloca dento de una lista a cada elemento de nivel
  # superior de la lista que recibe como entrada

  def enlist(list), do: do_enlist(list, [])

  defp do_enlist([], res), do: invert(res)
  defp do_enlist([head | tail], res), do: do_enlist(tail, [[head] | res])

  # CHECK (problem with numbers > 6)

  # 10. La funcion positives toma una lista de numeros lst como entrada y devuelve una nueva
  # lista que solo contiene los numeros positivos de lst

  def positives(list), do: do_positives(list, [])

  defp do_positives([], res), do: invert(res)
  defp do_positives([head | tail], res) when head > 0, do: do_positives(tail, [head | res])
  defp do_positives([_ | tail], res), do: do_positives(tail, res)

  # CHECK

  # 11. La funcion add-list devuelve la suma de los numeros contenidos en la
  # lista que recibe como entrada , o 0 si esta vacıa

  def add_list(list), do: add(list, 0)

  defp add([], count), do: count
  defp add([head | tail], count), do: add(tail, count + head)

  # CHECK

  # 12. La funcion invert-pairs toma como entrada una lista cuyo contenido son listas de dos elementos.
  # Devuelve una nueva lista con cada pareja invertida.

  def invert_pairs(list), do: do_invert_pairs(list, [])

  defp do_invert_pairs([], res), do: invert(res)
  defp do_invert_pairs([{a, b} | tail], res), do: do_invert_pairs(tail, [{b, a} | res])

  # CHECK

  # 13. La funcion de list-of-symbols? toma una lista lst como entrada. Devuelve verdadero si todos los
  # elementos (posiblemente cero) contenidos en lst son s ́ımbolos, o falso en caso contrario

  def is_atom_list(list), do: do_is_atom_list(list)

  defp do_is_atom_list([]), do: true

  defp do_is_atom_list([head | tail]) do
    cond do
      is_atom(head) -> do_is_atom_list(tail)
      true -> false
    end
  end

  # CHECK

  # 14. El funcion swapper toma tres entradas: dos valores a y b, y una lista lst. Devuelve una nueva
  # lista en la que cada ocurrencia de a en lst se intercambia por b, y viceversa. Cualquier otro
  # elemento de lst permanece igual. Se puede suponer que lst no contiene listas anidadas

  def swapper(list, a, b), do: do_swapper(list, a, b, [])

  defp do_swapper([], _, _, res), do: invert(res)

  defp do_swapper([head | tail], a, b, res) do
    cond do
      head == a -> do_swapper(tail, a, b, [b | res])
      head == b -> do_swapper(tail, a, b, [a | res])
      true -> do_swapper(tail, a, b, [head | res])
    end
  end

  # CHECK

  # 15. La funcion dot-product toma dos entradas: las listas a y b. Devuelve el resultado de realizar
  # el producto punto de a por b. El producto punto es una operacion algebraica que toma dos secuencias
  # de n ́umeros de igual longitud y devuelve un solo n ́umero que se obtiene multiplicando los elementos
  # en la misma posicion y luego sumando esos productos

  def dot_product(list1, list2), do: do_dot_product(list1, list2, 0)

  defp do_dot_product([], [], res) do
    cond do
      res > 0 -> res
      true -> 0
    end
  end

  defp do_dot_product([a_head | a_tail], [b_head | b_tail], res),
    do: do_dot_product(a_tail, b_tail, res + a_head * b_head)

  # CHECK

  # 16. La funcion average recibe una lista de numeros lst como entrada. Devuelve la media aritmetica
  # de los elementos contenidos en lst, o 0 si lst esta vacıa

  def average(list), do: do_average(list, 0, 0)

  defp do_average([], res, count) do
    cond do
      count > 0 -> res / count
      true -> 0
    end
  end

  defp do_average([head | tail], res, count), do: do_average(tail, res + head, count + 1)

  # CHECK

  # 17. La funcion standard-deviation recibe una lista de numeros lst como entrada. Devuelve la desviacion
  # estandar de la poblacion de los elementos contenidos en lst, o 0 si lst esta vacıa.

  def std_dev(list), do: do_std_dev(list)

  defp do_std_dev([]), do: 0

  defp do_std_dev(list) do
    avg = average(list)
    dist = distance(list, avg)
    sum_dist = add_list(dist)
    div_sum_dist = sum_dist / length(list)
    res = :math.sqrt(div_sum_dist)
    res
  end

  defp distance(list, avg), do: do_distance(list, avg, [])
  defp do_distance([], _, res), do: res

  defp do_distance([head | tail], avg, res),
    do: do_distance(tail, avg, [(head - avg) * (head - avg) | res])

  # CHECK

  # 18. La funcion replic toma dos entradas: una lista lst y un numero entero n, donde n ≥ 0. Devuelve una
  # nueva lista que replica n veces cada elemento contenido en lst

  def replic(num, list), do: do_replic(num, list, num, [])

  defp do_replic(_, [], _, res), do: invert(res)
  defp do_replic(0, [_ | tail], num, res), do: do_replic(num, tail, num, res)

  defp do_replic(count, [head | tail], num, res),
    do: do_replic(count - 1, [head | tail], num, [head | res])

  # CHECK

  # 19. La funcion expand toma una lista lst como entrada. Devuelve una lista donde el primer elemento de
  # lst aparece una vez, el segundo elemento aparece dos veces, el tercer elemento aparece tres veces,
  # y asısucesivamente

  def expand(list), do: do_expand(list, [], 1, 1)

  defp do_expand([], res, _, _), do: invert(res)
  defp do_expand([_ | tail], res, 0, length), do: do_expand(tail, res, length + 1, length + 1)

  defp do_expand([head | tail], res, count, length),
    do: do_expand([head | tail], [head | res], count - 1, length)

  # CHECK

  # 20. La funcion binary recibe un entero n como entrada (n ≥ 0). Si n es igual a cero, devuelve una
  # lista vacıa. Si n es mayor que cero, devuelve una lista con una secuencia de unos y ceros equivalente
  # a la representacion binaria de n

  def binary(num), do: do_binary(trunc(num), [])

  defp do_binary(0, res), do: res

  defp do_binary(num, res), do: do_binary(trunc(num / 2), [rem(num, 2) | res])

  # CHECK

  # IO.inspect(binding())
end
