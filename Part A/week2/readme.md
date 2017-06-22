# Неделя I
* [Краткое содержание в ПДФ](resources/section1sum.pdf).
* [Код из лекций](resources/section1_video_code_files).
* [Мой код](code), что написал по ходу просмотра.
* [Домашка](homework1).

## ML Variable Bindings and Expressions
В контексте курса нужно воспринимать ML как совершенно новый язык и не примешивать уже имеющийся опыт.

См. [`first.sml`](code/first.sml).

См. [слайды](resources/3_ML_expressions_and_variable_bindings.pdf).

### Синтаксис объявления (привязки, binding) переменных
```ml
(* Variable bindings, see `first.sml` *)
val x = 34;
val y = 17;
```

Ключевое слово `val`, имя переменной, после `=` идет _выражение_ (в данном случае просто 34). `x` будет типа `int`, потому что 34 — integer.

ML — статически типизированный язык: до выполнения программы происходит проверка типов.

### Семантика: статическое и динамическое окружение
Семантика — что означает то, что записано синтаксически.

Сначала формируется статическое окружение: проверяются типы и что переменные определены, статическое окружение наполняется.

Потом формируется динамическое окружение: происходит вычисление выражений и присваивание, наполняется динамическое окружение.

Type checking comes before the evaluation.

## Rules for Expressions
См. слайды [`4_rules_for_expressions.pdf`](resources/4_rules_for_expressions.pdf).

Для каждого выражения нужно рекурсивно (там могут быть подвыражения) обработать 3 вопроса:
1. _Синтаксис_ Какой синтаксис? Что надо написать?
2. _Проверка типов_ Какие используются правила для проверки типов? Какого типа выражение и при каких условиях проверка типов сломается?
3. _Вычисление_ Как будет происходить вычисление? По каким правилам мы получим результат (value)?

Сумма `int` и `bool` не пройдет проверку типов. Будет ошибка. ML так работает.

Значение (value) — результат вычисления (evaluate).

### Значения
* Все значения — выражения.
* Не все выражения являются значениями.
* Значение вычисляется само в себя (например, `42` в `val x = 42;`).

### Условия
Синтаксис
: `if e1 then e2 else e3`
: `if`, `then`, `else` — ключевые слова
: `e1`, `e2` и `e3` — подвыражения

Проверка типов
: `e1` должно быть `bool`
: `e2` и `e3` могут быть любого типа, но тип должен быть одинаковый у обоих
: Результат всего выражения — такой же тип, как у `e2` и `e3`.

Вычисление
: Сначала вычислить `e1`.
: Если оно `true`, то вернуть `e2` иначе вернуть `e3`.

### Less than (самостоятельно)
Синтаксис
: `e1` < `e2`
: `e1` и `e2` — подвыражения

Проверка типов
: `e1` и `e2` могут быть `int` или другого числового типа (хз как он сравнивает точно), оба одного и того же
: в итоге получается `bool`

Вычисление
: вычисляем `e1`
: вычисляем `e2`
: если `e1` меньше `e2`, то вернуть `true` иначе `false`


## The REPL and Errors
### Запуск файлов
Нельзя несколько раз подключать один и тот же файл через `use "filename.sml";`. Надо рестартануть REPL. Чтобы не было shadowing у переменных (ниже про это).

### Errors
Типы ошибок: синтаксические, ошибки типов, ошибки вычисления (в том числе логические).

В ML вычитание может быть только бинарной операцией. Чтобы сделать число отрицательным используется тильда:

```ml
val a = -5 (* ошибка *)
val a = 0-5 (* будет работать *)
val a = ~5 (* так правильно, по ML-овски *)
```

В ML floating point numbers называются reals (real numbers).  

`/` — так можно делить reals. Для `integers` нужно использовать `div`:

```ml
val x = 3
val y = 2

val a = x/y (* ошибка, это интеджеры *) 
val a = x div y (* норм *) 
```

## Shadowing
См. [код](resources/section1_video_code_files/6_shadowing.sml).

ML позволяет определять переменные с одинаковыми именами. Причем это не присваивание. Просто определяется новое окружение, а старое затеняется.

https://en.wikipedia.org/wiki/Variable_shadowing

В ESLint есть правило [`no-shadow`](http://eslint.org/docs/rules/no-shadow).

## Functions Informally
См. [код](code/func_pow.sml).

Функции можно вызывать без скобок, если у них только 1 аргумент: `cube 4`. Но если больше, то нужны скобки: `pow(2, 3)`.

Не может быть later function bindings. Функции должны объявляться до вызова.

## Functions Formally
Функция — значение (already a value), она не вычисляется до вызова. Мы не выполняем функцию пока не вызовем, просто сохраняем ее тело в переменную.

В SML нельзя сделать функцию с неопределенным набором аргументов.

Вычисление функции (запуск): `e0(e1, e2)`. Название ф-и — тоже выражение, сначала вычисляем его (находим выше в окружении). Потом вычисляем каждый аргумент. Потом вычисляем тело функции.

## Pairs and Other Tuples
В списках (list) все элементы должны быть одинакового типа.

Tuple — [кортеж](https://ru.wikipedia.org/wiki/Кортеж_(информатика)) — упорядоченный набор фиксированной длины.

Пара — кортеж из двух элементов.

Создание пары (кортежа). В кортеже (паре) `(e1, e2)` каждый элемент вычисляется, значение кортежа — вычисленные значения элементов `(v1, v2)`, тип кортежа: `t1 * t2`.

Доступ к элементам пары (кортежа). Синтаксис:

```ml
#1 e (* первый элемент *)
#2 e (* второй элемент *)
```

Вычисление: вычисляем `e` (ищем в окружении).

Проверка типов: если `e` имеет тип `t1 * t2`, тогда `#1 e` имеет тип `t1`, а `#2 e` имеет тип `t2`.

Nesting tuples: `val x1 = (7, (true, 9))`.

Кортежи имеют предварительно заданное число элементов. Нельзя их генерить налету.

## Introducing Lists
Списки — набор данных произвольной длины (в отличие от кортежей), но у каждого элемента должен быть одинаковый тип данных. Мы не знаем размер списка, пока не запустим программу.

Пустой список `[]`. Evaluates to itself.

List of values is a value. Но можно составлять список из выражений:

```ml
[(1+2), 3, (2+5)]; (* -> [4, 3, 7] *)
```

Операция `::` (cons) — constructing a list. Операция добавления в список.

`e1::e2`, где `e1` вычисляется в `v`, а `e2` в список `[v1, ..., vn]`. Получится `[v, v1, ..., vn]`. То есть `v` добавится в начало списка:

```ml
5::[1, 2, 3]; (* -> [5, 1, 2, 3] *)
5::[1, 2, 3]::[5, 6, 7]; (* можно и так *)
[5]::[[1,2], [3, 4]]; (* и так, тут все элементы списка — списки, одинаковый тип данных *)
```

Пустой список имеет тип `'a list` (alpha list) — это универсальный типа данных и к нему можно добавлять значения любого типа: `(1, 2)::[];`.

### Accessing Lists
Сначала проверяем, не пустой ли лист. Функция `null` в ML — это не спец. значение, как в JS. А простая функция, которая проверяет, не пустой ли список:

```ml
null []; (* true *)
null [1, 2, 3]; (* false *)
```

`hd` — функция head, принимает список и возвращает первый элемент.

`tl` — функция tail, принимает список и возвращает все, кроме первого. Tail списка из 1-го элемента — пустой список (все, элементы кроме первого, первого нет, значит пустой список).

## List Functions
Есть соглашение — именовать переменные/параметры со списками с окончанием `s`. Типа как множественное число:

```ml
fun sum_list(xs : int list) =
    if null xs
    then 0
    else hd xs + sum_list(tl xs)

val sum = sum_list([1, 2, 3])
```

Функции для работы со списками как правило рекурсивны. Обычно в решении нужно указать, что вернуть, когда список пуст и что сделать, когда список не пуст in terms of the tail of that list.

## Let Expressions
Локальные переменные. Видимые только в функции.

```ml
(* let b1 b2 ... bn in e *)
fun silly1 (z : int) = (* int -> int *)
    let val x = if z > 0 then z else 34
        val y = x+z+9
    in
        if x > y then x*2 else y*y
    end
```

Ограничение скоупа. Что внутри `let` не видно с наружи.

## Nested Functions
Вложенные функции нужно использовать, когда они не нужны никому, кроме текущий функции. Им доступно окружение родительской функции. Инкапсулируя хелпер-функцию мы делаем код более стабильным и логичным.

## Let and Efficiency

## Options

## Booleans and Comparison Operations
`e1 andalso e2` — обычно пишут `&&` в современных языках.

`e1 orelse e2` — теперь пишут `||`.

`not e1` — аналогично `!e1`. `!` в ML работает, относится к мутациям.

`=` — сравнение на равенство. Один знак `=`, не два, как часто бывает.

`<>` — на неравенство. Сейчас обычно юзают `!=`.

Нельзя сравнивать `int` и `real` с помощью `<`, `>`, `<=`, `>=`. Тип должен быть одинаковый. Надо конвертить: `Real.fromInt 2; (* => 2.0 *)`.

`=` и `<>` нельзя использовать на типе `real`. ML предполагает, что мы будем сравнивать их более математически.

## Benefits of No Mutation
В функциональных языках нельзя переопределить однажды созданные данные. Только создать новую копию.

```ml
val x = [1, 2, 3];
val y = x;
x = y; (* true *)

val y = 4::y;
x = y; (* false *)
```

```js
const x = [1, 2, 3];
const y = x;
console.log(y == x); // true

y.push(4);
console.log(y == x); // true, оба поменялись
```

## Optional: Java Mutation

## Pieces of a Language
Как изучить язык программирования?

* Синтаксис: как оно пишется.
* Семантика: как происходят вычисления (что делает интерпретатор/компилятор), как происходит проверка типов.
* Идиомы: устоявшиеся конструкции языка. Когда лучше написать `return a || b;`, а когда применять `if/else`. Когда использовать function declaration, когда function expression и пр. Типичные паттерны использования языковых конструкций.
* Библиотеки. Для работы с нужной областью: файловая система, данные и пр.
* Инструменты для работы с языком. Типа REPL. К самому языку не относятся.

# Hints and Gotchas
Краткое содержание недели из Community-contributed Resources.

## Notes on material
* Clear your mind of any preconceived notions of programming ideas.
* Download the reading notes!
* For strings, you have to use double-quote ", and not single-quote '.
* Unary minus is denoted by a tilde `~`.
* Test for equality is a single equals `=`` instead of double `==`.
* Every `if ... then` must also have an `else`.
* You need a `val` or `fun` for anything defined at the "top" level (or anywhere else).
* Always restart the REPL before use-ing the same file twice.
* There are no "assignments", there are "variable bindings". Understand the difference and how shadowing works.
* Types are indicated via a colon after the variable — they are often optional (SML can infer them).
* Forget `for/while` loops; you can do the same with recursion instead.
* Functions are values! (Make sure to understand how it is "evaluated".)
* The type of a tuple `(𝟸𝟹, 𝟹𝟺)` is denoted as `int * int`.
* Function types are denoted by `->`.
* Need to define a "local" variable in a function? Use `let...in...end`.
* "and" is done via `andalso`, "or" via `orelse`.
* "not equal" is `<>`.
* You cannot directly do arithmetic on an `int` and a `real`.

## Notes on the assignment
* Read assignment directions very carefully.
* Examine the required types of the functions, found on the "summary" section of the notes, page 2. Understand why those are the types. Make sure your implementations have those types.
* Don't use pattern matching on this assignment.
* Don't use features or library functions not described in the lectures/notes (except for places where the assignment specifies). In particular, you cannot use any of the `List` structure's functions.
* Write tests for your functions!
* If your problem returns a boolean, oftentimes you can get by with just `andalso` and `orelse`, without needing `if-then-else`. At the very least, avoid `if e then true else false`.
* Avoid recomputing a value when possible. Using `#𝟷`, `#𝟸`, `hd`, and `tl` doesn't really cost anything, but other computations should probably be stored if they are repeated.
* Most functions (with the exception of challenge problems) have bodies in the range of 3-8 lines.
* Make sure your functions are spelled correctly!
* You need to deal with empty lists as a possibility, do not assume they are non-empty.
* In general, do not make assumptions that are not explicitly stated in the assignment (if in doubt, ask in the forums!).
* Take care to think of what "older" and "oldest" means for dates.
* Don't forget to submit in two places! Normal assignment, and peer review.