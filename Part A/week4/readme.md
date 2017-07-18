# Неделя IV, First-Class Functions
## Introduction to First-Class Functions
Основные характеристики функционального программирования:
* Иммутабельность — неизменность/стремление к неизменности данных. Ни использовать присваивание (только binding).
* Функции как значения

И еще:
* Часто ФП использует рекурсию и рекурсивные типы данных (списки).
* Стиль/код программ более математичный (определение функций).
* Часто используются «ленивые» вычисления (Haskell, Lisp).

Какой язык считать функциональным? Многие языки позволяют ФП, но не многие заточены под него. Можно сказать, что если дизайн языка продуман так, что ФП в нем идет естественно, просто, то это функциональный язык. А так принципы ФП реализованы во многих языках, бери и кодь.

First-Class Function — можем передавать как прочие примитивы. Ф-я — значение. Самый частый вариант использование — передача функции как аргумента в другую функцию или возврат функции из функции.

Higher-Order Function — функция высшего порядка, принимает аргументом функцию и/или возвращает функцию.

Замыкание (Function Closure) — функция, использующая bindings из вне. Из окружения, выше своего определения.

## Functions as Arguments

## Polymorphic Types and Functions as Arguments
Универсальные функции часто полиморфны, мы можем в них передавать не фиксировнный набор типов, но разные типы данных просто по определенным правилам.

Так для функции `n_times`, которая принимает функцию, число итераций и аргумент:

```sml
fun n_times (f,n,x) = 
    if n=0
    then x
    else f (n_times(f,n-1,x))

fun increment x = x + 1;           (* instantiates 'a with int *)
val x3 = n_times(tl,2,[4,8,12,16]) (* instantiates 'a with int list *);
```

ML сформирует тип

```sml
val n_times = fn : ('a -> 'a) * int * 'a -> 'a
```

Альфы (`'a`) могут буть любого типа, но должны быть одинаковы. В случае с функцией `increment` там будут `int`, а в случае с `tl` — список интов.

Это полиморфизм, одна и та же функция может обрабатывать разные данные (аргумент `x`) разными способами (с помощью функции `f`). Только `n` должен быть `int`, потому что в теле ф-и он сравнивается с `0`.

Ф-и высшего порядка (higer-order) не обязательно должны быть полиморфны, а полиморфные функции не обязательно должны быть высшего порядка.

Пример не полиморфной ф-и высшего порядка:

```sml
(* Считает число вызовов `f` пока не будет возвращен `0` *)
fun times_until_zero (f,x) = 
    if x=0 then 0
    else 1 + times_until_zero(f, f x)

(* val times_until_zero = fn : (int -> int) * int -> int *)

(* Пример использования *)
fun decrement x = x-1
val x = times_until_zero(decrement, 3)
```

* `x` должен быть `int`, т. к. он сравнивается с `0`.
* `f` должна быть `int -> int`, т. к. она принимает `x` аргументом и результат ее вызова передается в рекурсивный вызов `times_until_zero` вторым аргументом.
* Ну и сама `times_until_zero` должна вернуть `int`, ее результат складывается с `1`.

Пример полиморфной ф-и не высшего порядка:

```sml
(* Считает число элементов в списке,
список может содержать данные любого типа *)
fun len xs =
    case xs of
       [] => 0
      | _::xs' => 1 + len xs'

(* val len = fn : 'a list -> int *)

val test_len1 = len([1, 2, 3, 4])
val test_len2 = len(["a", "b", "c"])
```

Ф-я `len` не является ф-ей высшего порядка (не принимает другие ф-и и не возвращает ф-ю), но может принимать данные разных типов (списки с любыми данными).

## Anonymous Functions
Синтаксис для анонимных ф-ий в ML `fn [args] => [body]`:

```sml
fun triple_n_times (n,x) =
    n_times((fn y => 3*y), n, x);
```
